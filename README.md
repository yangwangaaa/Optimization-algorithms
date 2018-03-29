# Optimization algorithms
A collections of implementation of different optimizations algorithms. A short explantation and some results are given here. For more detailed explanation, see the individual projects readme's.

## [Ant Colony optimization](https://github.com/WardQ/Optimization-algorithms/tree/master/Ant%20Colony)

A metaheuristic algorithm, here applied to solve the Travelling Salesperson Problem. By leaving virtual 'feromones', the ants try to find the shortest cycle visiting each vertex exactly once.

A visualisation of the path after each iteration on a world trip (Euclidian TSP) is given:
![](https://github.com/WardQ/Optimization-algorithms/blob/master/Ant%20Colony/AntColony.gif)

The evolution of the shortest path length after each iteration:
![](https://github.com/WardQ/Optimization-algorithms/blob/master/Ant%20Colony/evolution_pathlength.png)

## [Genetic Algorithms](https://github.com/WardQ/Optimization-algorithms/tree/master/Genetic%20Algorithms)

Genetic optimization algorithms are inspired on the mutations and genetic crossing in DNA code. By running many generations, the solution gets optimized.

![](https://github.com/WardQ/Optimization-algorithms/blob/master/Genetic%20Algorithms/result.png)

## [Genetic Programming](https://github.com/WardQ/Optimization-algorithms/tree/master/Genetic%20Programming)

Genetic Programming tries to fit a combination of functions to a given dataset.

<img src="https://github.com/WardQ/Optimization-algorithms/blob/master/Genetic%20Programming/finalResult.png" width="400><img src="https://github.com/WardQ/Optimization-algorithms/blob/master/Genetic%20Programming/error.png">

## [Gradient Descent](https://github.com/WardQ/Optimization-algorithms/tree/master/Gradient%20Descent)

Basic gradient descent algorithm.

![](https://github.com/WardQ/Optimization-algorithms/blob/master/Gradient%20Descent/result2.png)
## [Mini-Batch Adam](https://github.com/WardQ/Optimization-algorithms/tree/master/Mini-Batch%20Adam)

Adaptive Moment Estimation (ADAM) is a combination of RMSProp and Momentum. Often used in Deep Neural networks. Mini-batch processes only a part of the dataset, instead of the whole dataset.

## [Mini-Batch Gradient Descent with Momentum](https://github.com/WardQ/Optimization-algorithms/tree/master/Mini-Batch%20Gradient%20Descent%20with%20Momentum)

Gradient descent with momentum, which stabilizes the direction of the steps taken. Mini-batch processes only a part of the dataset, instead of the whole dataset.

## [Particle Swarm Optimisation](https://github.com/WardQ/Optimization-algorithms/tree/master/Particle%20Swarm%20Optimization)

Another bio-inspired optimization algorithm. This time, the inspiration comes from swarms of animals. By working together, the function is optimized.

![](https://github.com/WardQ/Optimization-algorithms/blob/master/Particle%20Swarm%20Optimization/ParticleSwarm.gif)
## [Shuffled Complex Evolution](https://github.com/WardQ/Optimization-algorithms/tree/master/Shuffled%20Complex%20Evolution)

Shfuffled Complex Evolution (here in the Nealder-Mead variant) is another optimization algorithm, often used in hydrological studies.

![](https://github.com/WardQ/Optimization-algorithms/blob/master/Shuffled%20Complex%20Evolution/result.png)
## [Simulated Annealing](https://github.com/WardQ/Optimization-algorithms/tree/master/Simulated%20Annealing)

Simulated Annealing is an extention of gradient descent, where certain 'worse' solutions can be accepted temporarely. It succeeds in escaping local minima.
![](https://github.com/WardQ/Optimization-algorithms/blob/master/Simulated%20Annealing/alpine_simulated_annealing.png)
