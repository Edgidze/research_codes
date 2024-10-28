import folderCreator
import paramsSet
import pandas as pd
import os
import task


def name_for_df_with_estimated_kernel_functions(dimension_row,
                                                dimension_column):
    params_set = paramsSet.ParamsSet()
    name_base = task.simulate_estimate_save_results_string + '~' + params_set.get_task_identification_name()  #
    subfolder = params_set.get_results_path() + '/kernel_functions'
    folderCreator.create_folder(subfolder)
    return subfolder + '/' + name_base + '_estimated_kernel_functions_' + str(
        dimension_row) + str(dimension_column) + '.xlsx'


class KernelFunctionsEstimationsSaving:

    def __init__(self):
        self.params_set = paramsSet.ParamsSet()

        # creation of file for every process estimations
        df_estimations_for_every_process = pd.DataFrame(columns=list(self.params_set.get_t_values()))

        for dimension_row in range(self.params_set.get_amount_of_dimensions()):
            for dimension_col in range(self.params_set.get_amount_of_dimensions()):

                try:
                    os.remove(name_for_df_with_estimated_kernel_functions(dimension_row, dimension_col))
                except OSError:
                    pass

                # check if specified file exists and if not - create one
                if not os.path.isfile(name_for_df_with_estimated_kernel_functions(dimension_row, dimension_col)):
                    df_estimations_for_every_process.to_excel(
                        name_for_df_with_estimated_kernel_functions(dimension_row, dimension_col), index=False)

    def append_kernel_functions_to_the_process_estimations_files(self,
                                                                 process_number,
                                                                 kernel_estimations_for_the_next_process):
        for dimension_row in range(self.params_set.get_amount_of_dimensions()):
            for dimension_col in range(self.params_set.get_amount_of_dimensions()):
                df_current = pd.read_excel(name_for_df_with_estimated_kernel_functions(dimension_row, dimension_col))

                new_row = kernel_estimations_for_the_next_process[dimension_row][dimension_col]
                df_part_appended = pd.DataFrame([list(new_row)],
                                                index=[str(process_number)],
                                                columns=list(self.params_set.get_t_values()))
                df_new = pd.concat([df_current,
                                    df_part_appended], axis=0, join='inner')
                df_new.to_excel(name_for_df_with_estimated_kernel_functions(dimension_row, dimension_col), index=True)
