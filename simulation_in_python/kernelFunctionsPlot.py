import matplotlib.pyplot as plt
import numpy as np
import matplotlib as mpl
import statistics


class KernelFunctionsPlot:
    def __init__(self,
                 dimension_number,
                 kernel_support,
                 name_base,
                 t_values,
                 params_set,
                 functions_values_for_explicit_parameters_estimated,
                 list_of_estimated_kernel_functions
                 ):
        self.dimensions_number = dimension_number
        self.t_values = t_values
        self.params_set = params_set
        self.functions_values_for_explicit_parameters_estimated = functions_values_for_explicit_parameters_estimated
        self.list_of_estimated_kernel_functions = list_of_estimated_kernel_functions
        self.kernel_support = kernel_support
        self.name_base = name_base
        self.func_num = 0

    def plot_matrix_of_plots(self,
                             postfix = ''):

        i_range = range(0, self.dimensions_number)
        j_range = range(0, self.dimensions_number)

        # Set the default color cycle
        mpl.rcParams['axes.prop_cycle'] = mpl.cycler(color=['g', 'g', 'g', 'k', 'r'])

        if self.dimensions_number == 1:
            fig, ax = plt.subplots(self.dimensions_number, self.dimensions_number, figsize=(15, 10), squeeze=False)
        else:
            fig, ax = plt.subplots(self.dimensions_number, self.dimensions_number, figsize=(15, 10))

        # plotting real kernel function lines
        counter = 0
        for i in i_range:
            for j in j_range:
                ax[i, j].plot(self.t_values, self.params_set.get_kernel_function_values(counter),
                              label='the real kernels')
                counter += 1

        counter = 0
        for i in i_range:
            for j in j_range:
                ax[i, j].plot(self.t_values,
                              self.params_set.get_kernel_function_values(counter) + 2 * statistics.stdev(
                                  np.array(self.params_set.get_kernel_function_values(counter))), ls=':',
                              drawstyle='steps-mid',
                              label='the real kernels +- 2 standard deviations')
                counter += 1

        counter = 0
        for i in i_range:
            for j in j_range:
                ax[i, j].plot(self.t_values,
                              self.params_set.get_kernel_function_values(counter) - 2 * statistics.stdev(
                                  np.array(self.params_set.get_kernel_function_values(counter))), ls=':',
                              drawstyle='steps-mid')
                counter += 1

        # plotting average estimated kernel function lines
        counter = 0
        for i in i_range:
            for j in j_range:
                ax[i, j].plot(self.t_values, self.list_of_estimated_kernel_functions[counter], linestyle='--',
                              drawstyle='steps-mid',
                              label='average non-parametrically estimated kernels')
                counter += 1

        # plotting lines for estimated explicit parameters
        counter = 0
        for i in i_range:
            for j in j_range:
                ax[i, j].plot(self.t_values, self.params_set.get_kernel_function_values_for_arbitrary_params(
                    *self.functions_values_for_explicit_parameters_estimated[counter]),
                              label='kernels of the estimated explicit parameters')
                counter += 1

        for ax in fig.axes:
            ax.set_ylim(bottom=0)  # the above border is not fixed now
            ax.set_xlim([0, self.kernel_support])

        # make plots better
        fig.tight_layout()

        # put a legend below current axis
        ax.legend(loc='upper left', bbox_to_anchor=(-1.1 * (self.dimensions_number - 1), - 0.15),
                  fancybox=False, shadow=False, ncol=4)

        plt.savefig(
            self.params_set.get_results_path() + '/' 'plot_with_' + self.name_base + '_estimated_average_kernel_functions' + postfix + '.png',
            bbox_inches="tight")
