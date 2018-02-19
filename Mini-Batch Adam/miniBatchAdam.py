import numpy as np
import math
import sklearn

# Function to create a list of random minibatches
# Inputs:   X, Y -- Input and output data, vector
#           mini_batch_size -- integer
# Output:   mini_batches -- list if minibatches
def random_mini_batches(X, Y, mini_batch_size = 64, seed = 0):
   
    np.random.seed(seed)            
    m = X.shape[1]
    mini_batches = []
        
    # Shuffle (X, Y)
    permutation = list(np.random.permutation(m))
    shuffled_X = X[:, permutation]
    shuffled_Y = Y[:, permutation].reshape((1,m))

    # Partition (shuffled_X, shuffled_Y). Minus the end case.
    num_complete_minibatches = math.floor(m/mini_batch_size)
    for k in range(0, num_complete_minibatches):
        mini_batch_X = shuffled_X[:,k * mini_batch_size:(k + 1) * mini_batch_size]
        mini_batch_Y = shuffled_Y[:,k * mini_batch_size:(k + 1) * mini_batch_size]
        mini_batch = (mini_batch_X, mini_batch_Y)
        mini_batches.append(mini_batch)
    
    # Handling the end case (last mini-batch < mini_batch_size)
    if m % mini_batch_size != 0:
        mini_batch_X = shuffled_X[:,num_complete_minibatches * mini_batch_size:]
        mini_batch_Y = shuffled_Y[:,num_complete_minibatches * mini_batch_size:]
        mini_batch = (mini_batch_X, mini_batch_Y)
        mini_batches.append(mini_batch)
    
    return mini_batches

# Initializes the velocity 
# Input:    parameters -- python dictionary containing W and b
# Output:   v -- dictionary containing the current velocity vW and vb and sW and sb
def initialize_adam(parameters) :
    
    L = len(parameters) // 2 # number of layers in the neural networks
    v = {}
    s = {}
    
    # Initialize v, s.
    for l in range(L):
        v["dW" + str(l + 1)] = np.zeros_like(parameters["W" + str(l + 1)])
        v["db" + str(l + 1)] = np.zeros_like(parameters["b" + str(l + 1)])

        s["dW" + str(l+1)] = np.zeros_like(parameters["W" + str(l + 1)])
        s["db" + str(l+1)] = np.zeros_like(parameters["b" + str(l + 1)])
    
    return v, s


# Function to update neural network weights using mini batch adam
# Inputs:   parameters -- dictionary containing W and b
#           grads -- dictionary cointaining dW and dB
#           v -- dictionary containing current velocity
#           s -- dictionary containting current squared gradient
#           beta1 -- Exponential decay hyperparameter for the first moment estimates 
#           beta2 -- Exponential decay hyperparameter for the second moment estimates 
#           epsilon -- hyperparameter preventing division by zero in Adam updates
#           learning_rate -- scalar
# Output:   parameters -- updated dictionary
#           v -- moving average of the first gradient, python dictionary
#           s -- moving average of the squared gradient, python dictionary
def adam(parameters, grads, v, s, t, learning_rate = 0.01,
                                beta1 = 0.9, beta2 = 0.999,  epsilon = 1e-8):
   
    L = len(parameters) // 2                 # number of layers in the neural networks
    v_corrected = {}                         
    s_corrected = {}                         
    
    # Perform Adam update on all parameters
    for l in range(L):
        # Moving average of the gradients.
        v["dW" + str(l + 1)] = beta1 * v["dW" + str(l + 1)] + (1 - beta1) * grads['dW' + str(l + 1)]
        v["db" + str(l + 1)] = beta1 * v["db" + str(l + 1)] + (1 - beta1) * grads['db' + str(l + 1)]

        # Compute bias-corrected first moment estimate.
        v_corrected["dW" + str(l + 1)] = v["dW" + str(l + 1)] / (1 - np.power(beta1, t))
        v_corrected["db" + str(l + 1)] = v["db" + str(l + 1)] / (1 - np.power(beta1, t))

        # Moving average of the squared gradients. 
        s["dW" + str(l + 1)] = beta2 * s["dW" + str(l + 1)] + (1 - beta2) * np.power(grads['dW' + str(l + 1)], 2)
        s["db" + str(l + 1)] = beta2 * s["db" + str(l + 1)] + (1 - beta2) * np.power(grads['db' + str(l + 1)], 2)
        ### END CODE HERE ###

        # Compute bias-corrected second raw moment estimate.
        s_corrected["dW" + str(l + 1)] = s["dW" + str(l + 1)] / (1 - np.power(beta2, t))
        s_corrected["db" + str(l + 1)] = s["db" + str(l + 1)] / (1 - np.power(beta2, t))

        # Update parameters.
        parameters["W" + str(l + 1)] = parameters["W" + str(l + 1)] - learning_rate * v_corrected["dW" + str(l + 1)] / np.sqrt(s["dW" + str(l + 1)] + epsilon)
        parameters["b" + str(l + 1)] = parameters["b" + str(l + 1)] - learning_rate * v_corrected["db" + str(l + 1)] / np.sqrt(s["db" + str(l + 1)] + epsilon)

    return parameters, v, s

mini_batches = random_mini_batches(X, Y, mini_batch_size)
v, s = initialize_adam(parameters)
parameters, grads, v = adam(parameters, grads, v, s, t)


