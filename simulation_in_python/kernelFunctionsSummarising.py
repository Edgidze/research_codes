import paramsSet
import pandas as pd
import os
import kernelFunctionsEstimationsSaving
import task


def name_for_df_with_average_estimated_kernel_functions():
    params_set = paramsSet.ParamsSet()
    name_base = params_set.get_task_parameter_sets_specification()
    name_base_splitted = name_base.split('~', -1)

    # in case the specified task name doesn't correspond to the task, when the folder was created
    if name_base_splitted[0] != task.simulate_estimate_save_results_string:
        name_base_splitted.insert(1, task.simulate_estimate_save_results_string)
        name_base = '~'.join(name_base_splitted[1:])

    return params_set.get_results_path() + '/' + name_base + '_estimated_average_kernel_functions.xlsx'


class KernelFunctionsSummarising:

    def __init__(self):
        self.params_set = paramsSet.ParamsSet()
        self.t_values = self.params_set.get_t_values()
        self.dimensions_amount = self.params_set.get_amount_of_dimensions()
        self.name_base = self.params_set.get_task_parameter_sets_specification()
        self.explicit_parameters_estimated = None

        # creation of a file for averages
        self.df_average_estimations = pd.DataFrame(columns=list(self.params_set.get_t_values()))

    def compute_file_with_averages(self):
        for dimension_row in range(self.params_set.get_amount_of_dimensions()):
            for dimension_col in range(self.params_set.get_amount_of_dimensions()):

                # check if the specified file exists and if not - throw an exception as absent file can not be averaged
                if not os.path.isfile(
                        kernelFunctionsEstimationsSaving.name_for_df_with_estimated_kernel_functions(dimension_row,
                                                                                                     dimension_col)):
                    raise Exception(
                        'Average kernels can not be computed, as not all files with estimated kernels for processes exist!!')

                df_with_estimations_for_processes = pd.read_excel(
                    kernelFunctionsEstimationsSaving.name_for_df_with_estimated_kernel_functions(dimension_row,
                                                                                                 dimension_col),
                    index_col=0)

                rows_amount = df_with_estimations_for_processes.shape[0]
                rows_sum = df_with_estimations_for_processes.loc[0, :]
                for row in range(1, rows_amount):
                    rows_sum = rows_sum + df_with_estimations_for_processes.loc[row, :]
                averaged_row = rows_sum / rows_amount

                df_part_appended = pd.DataFrame([list(averaged_row)],
                                                index=[str(dimension_row) + str(dimension_col)],
                                                columns=list(self.params_set.get_t_values()))
                self.df_average_estimations = pd.concat([self.df_average_estimations,
                                                         df_part_appended], axis=0, join='inner')
        self.df_average_estimations.to_excel(
            name_for_df_with_average_estimated_kernel_functions(),
            index=True)

    def __compute_explicit_parameters(self):
        df_average_estimated_kernels = pd.read_excel(
            name_for_df_with_average_estimated_kernel_functions(), index_col=0)
        list_of_estimated_kernel_functions = []
        row = 0
        for i in range(self.dimensions_amount):
            for j in range(self.dimensions_amount):
                estimated_kernel_function = list(df_average_estimated_kernels.iloc[row, :])

                list_of_estimated_kernel_functions.append(
                    self.params_set.estimate_explicit_function_parameters(estimated_kernel_function))
                row += 1

        self.explicit_parameters_estimated = list_of_estimated_kernel_functions

    def get_explicit_parameters(self):
        if self.explicit_parameters_estimated is None:
            self.__compute_explicit_parameters()
        return self.explicit_parameters_estimated
