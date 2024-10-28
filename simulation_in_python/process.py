from abc import ABC, abstractmethod
import numpy as np

from tick.base import TimeFunction
from tick.hawkes import (SimuHawkes, HawkesEM, HawkesKernelTimeFunc)

import kernelFunctionsSet
import paramsSet


# creating correct tasks
def factory_get_process(is_process_simulated, number_of_the_process):
    if is_process_simulated:
        return SimulatedProcess(number_of_the_process)
    else:
        raise Exception('is_process_simulated value is not boolean!!!')


# Hawkes process class
class Process(ABC):
    @abstractmethod
    def __init__(self, number_of_the_process):
        self.params_set = paramsSet.ParamsSet()
        self.timestamps_of_events = None
        self.intensity_of_simulated_process = None
        self.intensity_tracking_times = None

        raise NotImplementedError

    def estimate_kernel_from_process_with_HawkesEM(self):
        kernel_inferred = HawkesEM(kernel_support=self.params_set.get_kernel_support(),
                                   # the "depth" of event's impact in time
                                   kernel_size=self.params_set.get_kernel_size(),
                                   # amount of the descrete pieces in the estimated function
                                   max_iter=self.params_set.get_max_iter(),  # amount of estimation iterations
                                   verbose=False,
                                   record_every=1,  # for recording every iteration
                                   n_threads=-1  # to use as many processes as available
                                   )
        kernel_inferred.fit(self.timestamps_of_events)
        return kernel_inferred


class SimulatedProcess(Process):
    def __init__(self, number_of_the_simulation):
        self.params_set = paramsSet.ParamsSet()
        kernel_functions_set = kernelFunctionsSet.KernelFunctionsSet()

        time_functions = list()
        hawkes_kernels = list()

        # creation of HawkesKernelTimeFuncs
        for i in range(len(kernel_functions_set.funcs)):
            time_functions.append(TimeFunction((self.params_set.get_t_values(), kernel_functions_set.funcs[i])))
            hawkes_kernels.append(HawkesKernelTimeFunc(time_functions[i]))

        def list_of_square_matrix(size, *elements):
            return np.matrix(elements).reshape(size, size).tolist()

        kern_s = list_of_square_matrix(int(len(kernel_functions_set.funcs) ** 0.5), hawkes_kernels)

        process = SimuHawkes(kernels=kern_s,
                             baseline=self.params_set.get_baseline(),
                             end_time=self.params_set.get_run_time(),
                             verbose=False,
                             seed=self.params_set.get_initial_seed() + number_of_the_simulation)

        process.track_intensity(self.params_set.get_intensity_tracking_frequency())
        process.simulate()

        self.timestamps_of_events = process.timestamps

        self.intensity_of_simulated_process = process.tracked_intensity
        self.intensity_tracking_times = process.intensity_tracked_times
