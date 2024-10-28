import paramsSet
import pandas as pd
import kernelFunctionsSummarising
import os
import kernelFunctionsPlot


class ResultsProcessing:

    def __init__(self):
        self.params_set = paramsSet.ParamsSet()
        self.name_base = self.params_set.get_task_parameter_sets_specification()
        self.t_values = self.params_set.get_t_values()
        self.dimensions_number = self.params_set.get_amount_of_dimensions()
        self.kernel_support = self.params_set.get_kernel_support()
        self.kernel_functions_summarising = kernelFunctionsSummarising.KernelFunctionsSummarising()
        self.info_file_name = self.params_set.get_results_path() + '/' + self.params_set.get_task_identification_name() + '_parameters_specification.txt'


    def create_file_with_parameters_specified(self):

        try:
            os.remove(self.info_file_name)
        except OSError:
            pass

        self.f = open(self.info_file_name, 'w')

        self.__populate_file_with_simulation_parameters()

        self.f.close()

    def save_estimated_explicit_parameters_from_list(self,
                                                     list_of_lists_with_parameters):
        self.f = open(self.info_file_name, 'a')

        self.f.write(' Estimated explicit parameters: \n')
        self.f.write('  ' + 'The kernel functions parameters are mult, k and theta. ' + ' \n')

        for params_list_num in range(len(list_of_lists_with_parameters)):
            self.f.write('  ' + 'Kernel function ' + str(params_list_num) + ' parameters- ' + str(
                list(list_of_lists_with_parameters[params_list_num])) + ' \n')

        self.f.close()

    def __populate_file_with_simulation_parameters(self):

        self.f.write("Simulation " + self.params_set.get_task_identification_name() + " file." + '\n' + '\n')

        self.f.write(
            'The task for the program was: ' + self.params_set.get_task_parameter_sets_specification() + '\n' + '\n')
        self.f.write(' Simulation parameters: \n')
        self.f.write('  ' + 'Amount of simulations- ' + str(self.params_set.get_amount_of_processes()) + ' \n')
        self.f.write('  ' + 'Run time- ' + str(self.params_set.get_run_time()) + ' \n')
        self.f.write('  ' + 'Baseline- ' + str(self.params_set.get_baseline()) + ' \n')
        self.f.write('  ' + 'Initial seed- ' + str(self.params_set.get_initial_seed()) + ' \n')
        self.f.write(
            '  ' + 'Intensity tracking frequency- ' + str(self.params_set.get_intensity_tracking_frequency()) + ' \n')
        self.f.write('  ' + 'Maximum amount of iterations- ' + str(self.params_set.get_max_iter()) + ' \n')
        self.f.write('\n')

        self.f.write(' Kernel functions parameters: ' + ' \n')
        self.f.write('  ' + 'Kernel functions type- ' + str(self.params_set.get_kernel_function_type()) + ' \n')
        self.f.write('  ' + 'Amount of dimensions- ' + str(self.params_set.get_amount_of_dimensions()) + ' \n')
        self.f.write('  ' + 'Kernel support- ' + str(self.params_set.get_kernel_support()) + ' \n')
        self.f.write('  ' + 'Kernel size- ' + str(self.params_set.get_kernel_size()) + ' \n')
        self.f.write('  ' + 'The kernel functions parameters are mult, k and theta. ' + ' \n')
        for kernel_fun_num in range(self.params_set.get_amount_of_dimensions() ** 2):
            self.f.write('  ' + 'Kernel function ' + str(kernel_fun_num) + ' parameters- ' + str(
                self.params_set.get_kernel_function_average_parameters(kernel_fun_num)) + ' \n')
        self.f.write('\n')

    def save_simulation_plot_with_a_full_matrix_of_plots(self):
        df_average_estimated_kernels = pd.read_excel(
            kernelFunctionsSummarising.name_for_df_with_average_estimated_kernel_functions(), index_col=0)

        list_of_estimated_kernel_functions = []
        for row in range(self.dimensions_number ** 2):
            list_of_estimated_kernel_functions.append(list(df_average_estimated_kernels.iloc[row, :]))

        functions_values_for_explicit_parameters_estimated = self.kernel_functions_summarising.get_explicit_parameters()

        kernel_functions_plot = kernelFunctionsPlot.KernelFunctionsPlot(self.dimensions_number,
                                                                        self.kernel_support,
                                                                        self.name_base,
                                                                        self.t_values,
                                                                        self.params_set,
                                                                        functions_values_for_explicit_parameters_estimated,
                                                                        list_of_estimated_kernel_functions)

        kernel_functions_plot.plot_matrix_of_plots()
