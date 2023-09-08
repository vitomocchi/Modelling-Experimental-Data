# Modelling-Experimental-Data


## Introduction
This project focuses on a two-population model simulating the competition between two types of yeasts for the same substrate. The goal is to experimentally determine the values of two parameters to minimize the discrepancy between the experimental data and the model.

## Analysis

### Reorganization of Experimental Data
The experimental data is collected in a file named `yeasts.dat`. It contains time-series data for the volumes of two types of yeasts. The data is reorganized to account for multiple measurements at the same time point.

### Optimization Approach and Code Description
The MATLAB script `minimizing` is used to find the optimal values of the parameters. A brute-force search is employed over a predefined grid of values. The `ode45` MATLAB solver is used to simulate the ODE system and compute the deviation between the simulated and experimental values. The optimal values found are \(k_1=0.05\) and \(k_2=0.005\).

## Results
The project includes plots comparing the simulated values with the experimental data. A table summarizing the obtained results is also presented.

## Conclusion
Despite optimizing the values of the parameters, the proposed differential model does not provide a good representation of the experimental data. The squared deviation between the experimental and simulated values is high, indicating that the model may not be a good fit for the data.

