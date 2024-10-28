import durationCounter
import staticStorage
import paramsSet
import task

# the main entry point of the program
if __name__ == '__main__':
    # print("Hello World!! :)")

    duration = durationCounter.DurationCounter()

    params_set = paramsSet.ParamsSet()

    for current_task_num in range(params_set.get_task_parameter_sets_specification_length()):
        task_duration = durationCounter.DurationCounter()

        staticStorage.set_current_task(current_task_num)

        current_task = task.factory_get_specified_task()
        current_task.perform_task()

        task_duration.get_printed_duration_for_smth('Task ' + str(current_task_num))

    duration.get_printed_process_duration()

