# iterative operations provider
import eventTimestampsSaver
import kernelFunctionsSummarising
import kernelFunctionsEstimationsSaving
import paramsSet
import process
import resultsProcessing
import logging as log
from datetime import datetime
import pytz
import durationCounter


class IterativeProcessor:

    def __init__(self):
        self.params_set = paramsSet.ParamsSet()
        log.basicConfig(level=self.params_set.get_logging_level())

    def perform_iterative_simulation_and_estimation(self):
        log.info(
            ' ' + str(datetime.now(pytz.timezone('Europe/Moscow')).strftime("%H:%M:%S")) +
            ' Iterative process started.')

        params_set = paramsSet.ParamsSet()
        params_set.create_results_folder()

        amount_of_simulations = self.params_set.get_amount_of_processes()
        func_saving = kernelFunctionsEstimationsSaving.KernelFunctionsEstimationsSaving()
        timestamps_saver = eventTimestampsSaver.EventTimestampsSaver()

        for simulation_number in range(amount_of_simulations):
            simulation_duration = durationCounter.DurationCounter()
            proc = process.factory_get_process(True, simulation_number)
            simulation_duration.get_printed_duration_for_smth('Simulation')

            timestamps_saver.append_new_timestamps_sets(simulation_number,
                                                        proc.timestamps_of_events)

            estimation_duration = durationCounter.DurationCounter()
            estimated_kernels = proc.estimate_kernel_from_process_with_HawkesEM().kernel
            estimation_duration.get_printed_duration_for_smth('Estimation')

            func_saving.append_kernel_functions_to_the_process_estimations_files(simulation_number,
                                                                                 estimated_kernels)
            log.info(
                ' ' + str(datetime.now(pytz.timezone('Europe/Moscow')).strftime("%H:%M:%S")) +
                ' Simulation № ' + str(simulation_number) + ' estimated and recorded.')

        results_processor = resultsProcessing.ResultsProcessing()
        funcs_summarise = kernelFunctionsSummarising.KernelFunctionsSummarising()
        funcs_summarise.compute_file_with_averages()
        results_processor.create_file_with_parameters_specified()
        results_processor.save_estimated_explicit_parameters_from_list(funcs_summarise.get_explicit_parameters())
        results_processor.save_simulation_plot_with_a_full_matrix_of_plots()
