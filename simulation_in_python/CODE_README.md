<b><u>simulationStudies</u></b>

<u>Configuration process</u>

1. All the user configurations should be performed in the configuration.ini file. Configuration is performed through specifying parameters in the parameter sets and choosing the correct parameter sets for a specific task. These structure of parameter sets is chosen for easier parameters manipulations. Instead of specifying all the parameters once again, one can easily select another parameter set.


2. Configuration process consists of five parts. For better understanding they are described in the reversed order.
   1) In the 'files paths specification' section the path to the result files should be specified.
   2) In the 'kernel functions specifications' section parameter sets with kernel parameters are specified.
   3) In the 'simulation specifications' section parameter sets with simulation parameters are specified.
   4) In the 'tasks specifications' section the clusters of parameter sets are specified. The program performs tasks based on these parameter set clusters. Cluster items specify parameter sets names, which contain parameters for a specific task. 
   5) In the 'task definition' section the tasks for the program are specified. Each task's name characterises the operation, which should be performed. Tasks should be separated with commas. Each task's name matches with the correct task specification section name in the square brackets.  


3. Further the configuration algorithm is clarified more thoroughly. 


4. The tasks should be specified in the 'task definition' section in the 'TaskSpecification' field from the provided options. The task name part before `~` defines the type of the task. The second task name part after `~` defines the name of the set with parameters, which will be computed or should be analysed for obtaining new results. The second part gives the opportunity to specify different tasks of one type. It is useful to name it based on the crucial parameters of the simulations for easier process distinguishing.   


5. For the chosen task a corresponding [ ] cluster of parameter sets should be found. In this section the corresponding param sets should be specified. <i>(For every perform_simulations_save_all_results task, SimulationSpecification and KernelFunctionsParamSet should be specified)</i> 


6. For each of the specified param sets the correct params should be defined, these are:
   * for 'simulation specifications', [simulation_specification~X] - the corresponding simulation parameters. Part after `~`- identification of a param set.
   * for 'kernel functions specifications', [gamma_M~X] - the corresponding kernel functions parameters. Part before `_`- the type of functions. Here it is functions based on gamma distribution. Gamma distribution with k and θ parameters, multiplied by mult parameter. Part between `_` and `~` equals the amount of dimensions in the simulation. Part after `~`- identification of a param set.


7. For any task the path to the folder with the result files should be specified in the field 'ResultsPath' of the 'files paths specification' section.


8. The level of program logging can be specified in the 'logging level specification' section.




