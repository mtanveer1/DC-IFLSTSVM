# DC-IFLSTSVM

Dual center based intuitionistic fuzzy plane based classifiers


This code corresponds to the paper:  Anuradha Kumari, M. Tanveer (2024). Dual center based intuitionistic fuzzy plane based classifiers, International Joint Conference on Neural Networks (IJCNN 2024), Yokohama, Japan.

If you are using our code, please give proper citation to the above given paper.

If there is any issue/bug in the code please write to phd2101141007@iiti.ac.in


%%%%%%%%%%%% Description of files

1. Main file: This is the main file of DC_IFLSTSVM. To utilize this code, you simply need to import the data and execute this script. Within the script, you will be required to provide values for various parameters.
To replicate the results achieved with CGFTSVM-ID, please adhere to the same instructions outlined in the paper "Dual center based intuitionistic fuzzy plane based classifiers". 

2. DC_IFLSTSVM_func: This file contains the function to solve the optimization problem and calculates the AUC value.

3. conjugate_gradient: This function solves the system of linear equations using Conjugate gradient method.

4. Function_Kernel: This function corresponds to the kernel function mapping of data points. 

5. DC_IFuzzy_MemberShip: It assigns membership value to the data points using the dual center based intuitionistic fuzzy scheme.


NOTE: The dataset imported here is KEEL data set "iono". And the parameters passed are optimal parameters corresponding to the dataset. 

In addition, PDF file "results on UCI data" contains the table demonstrating the performance of all the models across UCI datasets. 
