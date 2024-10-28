import folderCreator
import paramsSet
import os
import pandas as pd
import task


def name_for_dfs_with_events_timestamps(dimension):
    params_set = paramsSet.ParamsSet()
    name_base = task.simulate_estimate_save_results_string + '~' + params_set.get_task_identification_name()  #
    subfolder = params_set.get_results_path() + '/timestamps'
    folderCreator.create_folder(subfolder)
    return subfolder + '/' + name_base + '_event_timestamps_dimension' + str(
        dimension) + '.csv'


class EventTimestampsSaver:

    def __init__(self):
        self.params_set = paramsSet.ParamsSet()

        # creation of file for every process estimations
        df_estimations_for_every_process = pd.DataFrame()

        for dimension in range(self.params_set.get_amount_of_dimensions()):

            try:
                os.remove(name_for_dfs_with_events_timestamps(dimension))
            except OSError:
                pass

            # check if specified file exists and if not - create one
            if not os.path.isfile(name_for_dfs_with_events_timestamps(dimension)):
                df_estimations_for_every_process.to_csv(
                    name_for_dfs_with_events_timestamps(dimension), index=False, sep="\t")

    def append_new_timestamps_sets(self,
                                   process_number,
                                   timestamps_set):
        for dimension in range(self.params_set.get_amount_of_dimensions()):
            try:
                df_current = pd.read_csv(name_for_dfs_with_events_timestamps(dimension), sep="\t")
                new_column = timestamps_set[dimension]
                df_part_appended = pd.DataFrame({int(process_number): list(new_column)})
                df_new = pd.concat([df_current,
                                    df_part_appended], axis=1, join='outer')
            except:
                new_column = timestamps_set[dimension]
                df_new = pd.DataFrame({int(process_number): list(new_column)})

            df_new.to_csv(name_for_dfs_with_events_timestamps(dimension), index=False, sep="\t")
