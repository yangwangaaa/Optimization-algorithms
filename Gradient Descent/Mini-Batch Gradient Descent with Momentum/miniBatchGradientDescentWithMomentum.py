import numpy as np
import math
import sklearn


def random_mini_batches(X, Y, mini_batch_size=64, seed=0):
	"""

	Function to create a list of random minibatches

	Inputs:
		X, Y -- Input and output data, vector
		mini_batch_size -- integer
	Output:
		mini_batches -- list if minibatches

	"""

    np.random.seed(seed)
    m = X.shape[1]
    mini_batches = []

    # Shuffle (X, Y)
    permutation = list(np.random.permutation(m))
    shuffled_X = X[:, permutation]
    shuffled_Y = Y[:, permutation].reshape((1, m))

    # Partition (shuffled_X, shuffled_Y). Minus the end case.
    num_complete_minibatches = math.floor(m / mini_batch_size)
    for k in range(0, num_complete_minibatches):
        mini_batch_X = shuffled_X[:, k *
                                  mini_batch_size:(k + 1) * mini_batch_size]
        mini_batch_Y = shuffled_Y[:, k *
                                  mini_batch_size:(k + 1) * mini_batch_size]
        mini_batch = (mini_batch_X, mini_batch_Y)
        mini_batches.append(mini_batch)

    # Handling the end case (last mini-batch < mini_batch_size)
    if m % mini_batch_size != 0:
        mini_batch_X = shuffled_X[:,
                                  num_complete_minibatches * mini_batch_size:]
        mini_batch_Y = shuffled_Y[:,
                                  num_complete_minibatches * mini_batch_size:]
        mini_batch = (mini_batch_X, mini_batch_Y)
        mini_batches.append(mini_batch)

    return mini_batches


def initialize_velocity(parameters):
	"""
	
	Initializes the velocity
	
	Input:    
		parameters -- python dictionary containing W and b
	
	Output:   
		v -- dictionary containing the current velocity vW and vb

	"""

    L = len(parameters) // 2  # number of layers in the neural networks
    v = {}

    # Initialize velocity
    for l in range(L):
        v["dW" + str(l + 1)] = np.zeros_like(parameters["W" + str(l + 1)])
        v["db" + str(l + 1)] = np.zeros_like(parameters["b" + str(l + 1)])

    return v


def gradient_descent_with_momentum(parameters, grads, v, beta, learning_rate):
	"""
	
	Function to update neural network weights using gradient descent
	
	Inputs:   
		parameters -- dictionary containing W and b           
		grads -- dictionary cointaining dW and dB           
		v -- dictionary containing current velocity           
		beta -- momentum hyperparameter, scalar           
		learning_rate -- scalar
	Output:   
		parameters -- updated dictionary
	
	"""

    L = len(parameters) // 2  # number of layers in the neural networks
    # Momentum update for each parameter
    for l in range(L):
        # compute velocities
        v["dW" + str(l + 1)] = beta * v["dW" + str(l + 1)] + \
            (1 - beta) * grads['dW' + str(l + 1)]
        v["db" + str(l + 1)] = beta * v["db" + str(l + 1)] + \
            (1 - beta) * grads['db' + str(l + 1)]
        # update parameters
        parameters["W" + str(l + 1)] = parameters["W" +
                                                  str(l + 1)] - learning_rate * v["dW" + str(l + 1)]
        parameters["b" + str(l + 1)] = parameters["b" +
                                                  str(l + 1)] - learning_rate * v["db" + str(l + 1)]

    return parameters, v


mini_batches = random_mini_batches(X, Y, mini_batch_size)
v = initialize_velocity(parameters)
parameters, grads, v = gradient_descent_with_momentum_test_case(
    parameters, grads, v, beta, learning_rate)
