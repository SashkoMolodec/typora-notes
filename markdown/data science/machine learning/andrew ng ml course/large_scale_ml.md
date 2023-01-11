## :elephant: Large Scale Machine Learning

[:arrow_backward:](../../ds_index)

When we are developing a model and want to optimize it we can come up with gradient descent to minimize cost function. The problem it's when we meet with a very large training set this algorithm becomes computationally very expensive. 

In usual Batch gradient descent for one step we need to involve all the training examples when computing the cost function and then change parameters a little bit. It's very expensive operation if we have millions and millions of training examples so that's where Stochastic gradient descent breaks in.

[toc]

#### 1. Stochastic Gradient Descent

Compute the cost function only for one ($x^{(i)}, y^{(i)}$) training example and after that update $\theta$ parameters for one step:

$cost(\theta, (x^{(i)}, y^{(i)})) = \frac{1}{2}(h_{\theta}(x^{(i)}) - y^{(i)})^2$

Full algorithm:

1. Randomly shuffle (reorder) training examples

2. $$
   \text{Repeat } \{ 
   \\ \text{for} \ i:= 1,...,m \{ 
   \\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  \theta_j := \theta_j - \alpha(h_{\theta}(x^{(i)})-y^{(i)})x_j^{(i)} & ( \text{for every} \ j = 0,...,n)
   \\ \ \ \ \ \ \ \ \ \} 
   \\ \}
   $$

On each $i$ iteration we are working only with one training example and all $\theta_j$ parameters we're going to change. 



#### 2. Mini-Batch Gradient Descent

Use $b$ examples in each gradient iteration.

For example $b=10, m=1000$, algorithm will look like:
$$
\text{Repeat }\{ 
\\ \text{for} \ i:= 1,11,21,31..,991 \{ 
\\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  \theta_j := \theta_j - \alpha\frac{1}{10}\sum_{k=i}^{i+9}(h_{\theta}(x^{(k)})-y^{(k)})x_j^{(k)} & ( \text{for every} \ j = 0,...,n)
\\ \ \ \ \ \ \ \ \ \} 
\\ \}
$$



#### 3. Stochastic Gradient Descent Convergence

During learning, compute $cost(\theta, (x^{(i)}, y^{(i)}))$ before updating $\theta$ using $(x^{(i)}, y^{(i)}).$

For example, every 1000 iterations plot $cost$ averaged over the last 1000 examples processed by algorithm. And same as with the Batch gradient, we observe if our plot decreases. We can change iteration number if the plot looks to noisy and ambiguous.

> Learning rate $\alpha$ is typically held constant. We can slowly decrease $\alpha$ over time if we want $\theta$ to converge. (E.g. $\alpha = \frac{const1}{iterationNumber + const2}$).