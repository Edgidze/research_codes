import paramsSet


# set of the simulated kernels container
class KernelFunctionsSet:
    def __init__(self):
        params = paramsSet.ParamsSet()

        self.t_values = params.get_t_values()

        self.funcs = list()
        for func_num in range(params.get_amount_of_dimensions() ** 2):
            self.funcs.append(params.get_kernel_function_values(func_num))
