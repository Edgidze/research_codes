import eventTimestampsReformattedSaver
import iterativeProcessor
import paramsSet
from abc import abstractmethod

simulate_estimate_save_results_string = 'simulate_estimate_save_results'
reformat_timestamps = 'reformat_timestamps'
perform_simulations_save_all_results_str = 'perform_simulations_save_all_results'


# get correct tasks
def factory_get_specified_task():
    params = paramsSet.ParamsSet()
    task_type = params.get_task_type()

    if task_type == simulate_estimate_save_results_string:
        return TaskSimulateEstimateSaveResults()
    elif task_type == reformat_timestamps:
        return TaskReformatTimestamps()
    elif task_type == perform_simulations_save_all_results_str:
        return TaskPerformSimulationsSaveAllResults()

    else:
        raise Exception('The task is not specified properly!!')


# tasks available
class Task:
    @abstractmethod
    def perform_task(self):
        raise NotImplementedError


class TaskSimulateEstimateSaveResults(Task):

    def perform_task(self):
        iterative_processor = iterativeProcessor.IterativeProcessor()
        iterative_processor.perform_iterative_simulation_and_estimation()


class TaskReformatTimestamps(Task):

    def perform_task(self):
        event_timestamps_reformatted_saver = eventTimestampsReformattedSaver.EventTimestampsReformattedSaver()
        event_timestamps_reformatted_saver.reformat_timestamps_sets()


class TaskPerformSimulationsSaveAllResults(Task):

    def perform_task(self):
        TaskSimulateEstimateSaveResults().perform_task()
        TaskReformatTimestamps().perform_task()



