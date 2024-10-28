import eventTimestampsSaver
import folderCreator
import paramsSet
import os
import pandas as pd
import logging as log
from datetime import datetime
import pytz


def name_for_dfs_with_events_reformatted_timestamps(dimension):
    params_set = paramsSet.ParamsSet()
    name_base = params_set.get_task_parameter_sets_specification()
    subfolder = params_set.get_results_path() + '/timestamps_reformatted'
    folderCreator.create_folder(subfolder)
    return subfolder + '/' + name_base + '_event_timestamps_reformatted_dimension' + str(
        dimension) + '.csv'


class EventTimestampsReformattedSaver:

    def __init__(self):
        self.params_set = paramsSet.ParamsSet()

        for dimension in range(self.params_set.get_amount_of_dimensions()):

            try:
                os.remove(name_for_dfs_with_events_reformatted_timestamps(dimension))
            except OSError:
                pass

    def __create_reformatted_dataframe(self,
                                       df_timestamps_old):
        run_time = self.params_set.get_run_time()
        df_timestamps_new = pd.DataFrame()

        for realisation_num in df_timestamps_old.columns:
            list_of_column_values = list(
                [int(round(float(timestamp))) for timestamp in list(df_timestamps_old[realisation_num].dropna())])

            df_part_appended = pd.DataFrame({realisation_num: list(self.__list_disperser(run_time,
                                                                                         list_of_column_values))})
            df_timestamps_new = pd.concat([df_timestamps_new,
                                           df_part_appended], axis=1, join='outer')

        return df_timestamps_new

    def __list_disperser(self,
                         dispersed_list_length,
                         initial_list):
        # create list of certain elements presence
        dispersed_list = [0] * dispersed_list_length

        # populating dispersed list with amounts of the elements
        for initial_list_element_num in range(len(initial_list)):
            try:
                dispersed_list[initial_list[initial_list_element_num]] = dispersed_list[
                                                                             initial_list[initial_list_element_num]] + 1
            except:
                self.params_set.logger.info(
                    'Attention!!! The last of the timestamps will be lost, as a consecuence of rounding to the out of run time timestamp.')

        # loop for list dispersing
        while True:

            changes_occured = False
            for dispersed_list_element_num in range(dispersed_list_length):

                # dispersing too big list elements
                if dispersed_list[dispersed_list_element_num] > 1:
                    changes_occured = True
                    dispersed_list[dispersed_list_element_num] = dispersed_list[dispersed_list_element_num] - 1
                    if dispersed_list_element_num + 1 == dispersed_list_length:
                        self.params_set.logger.info(
                            'ATTENTION: one of the last elements was lost due to dispersing out of the run time!!!')
                    else:
                        dispersed_list[dispersed_list_element_num + 1] = dispersed_list[
                                                                             dispersed_list_element_num + 1] + 1

            if not changes_occured:
                break

        return dispersed_list

    def reformat_timestamps_sets(self):
        # loop for iterating timestamps files
        dimension = 0
        while True:
            try:
                df_timestamps_old = pd.read_csv(eventTimestampsSaver.name_for_dfs_with_events_timestamps(dimension),
                                                sep="\t")
                self.__create_reformatted_dataframe(df_timestamps_old).to_csv(
                    name_for_dfs_with_events_reformatted_timestamps(dimension), index=False, sep="\t")

            except Exception as e:
                log.info(
                    ' ' + str(datetime.now(pytz.timezone('Europe/Moscow')).strftime("%H:%M:%S")) +
                    ' Timestamps for %s reformatted' % self.params_set.get_task_parameter_sets_specification())
                break

            dimension += 1
