from abc import abstractmethod
from scipy.stats import gamma as gamma_st


def factory_get_kernel_function(kernel_function_type, t_values, *params):
    if kernel_function_type == 'gamma':
        return KernelFunctionTypeGamma().get_kernel_function_values(t_values, *params)
    else:
        raise Exception('The kernel function is not specified properly!!')


class KernelFunction:

    @abstractmethod
    def get_kernel_function_values(self, t_values, *params):
        raise NotImplementedError


# kernel function based on gamma distribution in k, theta parametrisation, with multiplicator added
class KernelFunctionTypeGamma(KernelFunction):
    def get_kernel_function_values(self, t_values, *params):

        if len(params) != 3:

            raise Exception('Wrong amount of parameters specified!!!')
        else:
            mult = params[0]
            k = params[1]
            theta = params[2]

        # equivalent formulation:
        # return mult * ((t_values ** (k - 1)) * (math.e ** (- t_values / theta)) /
        #                ((theta ** k) * gamma(k)))

        return mult * gamma_st.pdf(t_values, k, 0.0, theta)
