import configparser
import logging
import folderCreator
import kernelFunction
import numpy as np
import staticStorage
from scipy.optimize import curve_fit


# program params from the configuration.ini handler
class ParamsSet:
    def __init__(self):
        # create a configparser for reading the configuration
        self.config = configparser.ConfigParser()
        self.config.read('configuration.ini')

        # define the logging level
        logging.basicConfig(level=int(self.config['log']['LoggingLevel']))
        self.logger = logging
        self.days_available = None

    def get_amount_of_processes(self):
        return int(str(self.config[self.__get_simulation_specification()]['AmountOfSimulations']))

        # return 27

    def get_task_type(self):
        return str(self.get_task_parameter_sets_specification()).rsplit('~', 1)[0]

    def get_task_identification_name(self):
        return str(self.get_task_parameter_sets_specification()).rsplit('~', 1)[1]

    def get_task_parameter_sets_specification_string(self):
        return [x.strip() for x in str(self.config['task']['TaskSpecification']).split(',', -1)]

    def get_task_parameter_sets_specification_length(self):
        return len(self.get_task_parameter_sets_specification_string())

    def get_task_parameter_sets_specification(self):
        current_task_num = staticStorage.get_current_task_num()
        return self.get_task_parameter_sets_specification_string()[current_task_num]

    def get_kernel_function_type(self):
        return str(self.config[self.get_task_parameter_sets_specification()]['KernelFunctionsParamSet'].rsplit('~', 1)[
                       0].rsplit('_', 1)[0])

    def get_amount_of_dimensions(self):
        return int(
            str(self.config[self.get_task_parameter_sets_specification()]['KernelFunctionsParamSet']).rsplit('~', 1)[
                0].split('_', -1)[1])

    def get_initial_seed(self):
        return int(str(self.config[self.__get_simulation_specification()]['InitialSeed']))

    def get_baseline(self):
        return [float(x) for x in str(self.config[self.__get_simulation_specification()]['Baseline']).split(',', -1)]

    def get_run_time(self):
        return int(str(self.config[self.__get_simulation_specification()]['RunTime']))

    def get_intensity_tracking_frequency(self):
        return float(str(self.config[self.__get_simulation_specification()]['IntensityTrackingFrequency']))

    def get_max_iter(self):
        return int(str(self.config[self.__get_simulation_specification()]['MaxIter']))

    def __get_kernel_functions_param_set_name(self):
        return str(self.config[self.get_task_parameter_sets_specification()]['KernelFunctionsParamSet'])

    def __get_simulation_specification(self):
        return str(self.config[self.get_task_parameter_sets_specification()]['SimulationSpecification'])

    def get_kernel_size(self):
        return int(str(self.config[self.__get_kernel_functions_param_set_name()]['KernelSize']))

    def get_kernel_support(self):
        return int(str(self.config[self.__get_kernel_functions_param_set_name()]['KernelSupport']))

    def get_logging_level(self):
        return int(str(self.config['log']['LoggingLevel']))

    def get_results_path(self):
        return self.get_results_folder_path() + self.get_task_identification_name()

    def get_results_folder_path(self):
        return str(self.config['files_paths']['ResultsPath'])

    def get_estimation_start_parameters(self):
        return [float(x) for x in str(
            self.config[self.__get_kernel_functions_param_set_name()]['FunctionStartParametersInEstimation']).split(',',
                                                                                                                    -1)]

    def get_t_values(self):
        return [round(t, 7) for t in np.linspace(start=0,
                                                 stop=int(self.get_kernel_support()),
                                                 num=int(self.get_kernel_size()))]

    def get_kernel_function_values(self, number_of_the_kernel_function):
        func_params_set_name = 'Function' + str(number_of_the_kernel_function) + '_Parameters'

        params = np.fromstring(
            str(self.config[self.config[self.get_task_parameter_sets_specification()]['KernelFunctionsParamSet']][
                    func_params_set_name]),
            dtype=float, sep=',')

        return kernelFunction.factory_get_kernel_function(self.get_kernel_function_type(),
                                                          self.get_t_values(),
                                                          *params)

    def get_kernel_function_average_parameters(self, number_of_the_kernel_function):
        func_params_set_name = 'Function' + str(number_of_the_kernel_function) + '_Parameters'
        return list(np.fromstring(
            str(self.config[self.config[self.get_task_parameter_sets_specification()]['KernelFunctionsParamSet']][
                    func_params_set_name]),
            dtype=float, sep=','))

    def estimate_explicit_function_parameters(self,
                                              estimated_kernel_function_values):
        x = self.get_t_values()
        y = estimated_kernel_function_values
        estimation_start_parameters = self.get_estimation_start_parameters()

        def the_kernel_fun(x, *params):
            return kernelFunction.factory_get_kernel_function(self.get_kernel_function_type(),
                                                              x, *params)

        try:

            result = curve_fit(the_kernel_fun, x, y, p0=estimation_start_parameters,
                               full_output=True)
            return result[0]

        except Exception as e:
            self.logger.error('ERROR during explicit parameters estimation occurred!!')
            self.logger.error('the_kernel_fun: ' + str(the_kernel_fun))
            self.logger.error(' x : ' + str(x))
            self.logger.error(' y : ' + str(y))
            self.logger.error(' estimation_start_parameters : ' + str(estimation_start_parameters))
            self.logger.error(str(e))

            # return the length of params list for correct df creation
            return len(estimation_start_parameters)

    def get_kernel_function_values_for_arbitrary_params(self,
                                                        *arbitrary_params):
        return kernelFunction.factory_get_kernel_function(self.get_kernel_function_type(),
                                                          self.get_t_values(),
                                                          *arbitrary_params)

    def create_results_folder(self):
        folderCreator.create_folder(self.get_results_path())
