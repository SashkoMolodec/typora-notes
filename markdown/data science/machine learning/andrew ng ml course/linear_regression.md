##  :straight_ruler: Linear Regression

[:arrow_backward:](../../ds_index)

[toc]

### 1. Model representation

![H6qTdZmYEeaagxL7xdFKxA_2f0f671110e8f7446bb2b5b2f75a8874_Screenshot-2016-10-23-20.14.58](../../../../src/img/andr_ng_ml_course/ml_linear_regr_1.png)

We use $x^{(i)}$ to denote the "input" variables (input features), and $y^{(i)}$ as the output or target variable. For supervising learning our goal is given a training set, learn a function $h: X \to Y$ so that $h(x)$ is a "good" predictor/hypothesis for the $y$.

Predict continuous target variable - regression problem, small number of discrete values - classification problem.

---



### 2. Cost function

We can measure the accuracy of our hypothesis function by using a cost function:
$$
J(\theta_{0},\theta_{1}) = \frac{1}{2m}\sum_{i=1}^{m}(h_{\theta}(x_{i})-y_{i})^2
$$
$\frac{1}{2}\overrightarrow{x}$ is the mean of the squares of $h_{\theta}(x_{i}-y_{i})$, or the difference between the predicted value and the actual value.

> The mean is halved ($\frac{1}{2}$) as a convenience for the computation of the gradient descent, as the derivative term of the square function will cancel out the term.

This function is also called "Squared error function", or "Mean squared error". Bellow is the summarization what the cost function does:



<img src="../../../../src/img/andr_ng_ml_course/cost_func_linear_regr.png" alt="cost_func_linear_regr" style="zoom: 80%;" />

---



### 3. Gradient Descent

For estimating the parameters $\theta$ in the hypothesis we use gradient descent. We need it to **reduce cost function** to it's minimum. Below is a graph of a cost function using two parameters ($\theta_{0}, \theta_{1}$) :

<img src="../../../../src/img/andr_ng_ml_course/ml_linear_regr_3.png" alt="ml_linear_regr_3"  />

We'll succeed when our cost function is at the very bottom of the pits in our graph. We need to iteratively reach it by taking the derivative (tangential line to a function) of our cost function. The slope of the tangent is the derivative at that point and it will give negative or positive value so showing where to move:

$$\text{repeat until convergence} \ \{ \\ \theta_{j} := \theta_{j} - \alpha \frac{\partial}{\partial\theta_{j}} J(\theta_{0},\theta_{1}) & \text{for} \ j=0,1 \\ \}$$

$\alpha$ - learning rate (size of each step).

It's important to simultaneously update the parameters $\theta_{0},\theta_{1},...,\theta_{n}$ at each iteration $j$.



##### Simplified example with one parameter 

<img src="../../../../src/img/andr_ng_ml_course/ml_linear_regr_4.png" style="zoom:80%;" />

Convergence is when $\alpha \frac{\partial}{\partial\theta_{j}} J(\theta_{1})$ approaches 0 as we approach the bottom of our convex function. Gradient descent will automatically take smaller steps as we approach a local minimum so no need to change $\alpha$ over time. At the minimum we'll get $\theta_{1}:=\theta_{1}-\alpha*0$.

> Convex function is the bow shaped function (cost function in our case).

We should adjust $\alpha$ parameter to ensure the gradient descent converges in a reasonable time. Failure to converge when value is too large or doing this for a very long time is **bad**:

<img src="../../../../src/img/andr_ng_ml_course/ml_linear_regr_5.png" style="zoom:80%;" />



#### Gradient descent for Linear Regression

When applying to linear regression we'll get a new form of the gradient descent formula:

$$\text{repeat until convergence} \ \{ \\ \theta_{j} := \theta_{j} - \alpha \frac{1}{m} \sum_{i=1}^{m} (h_{\theta}(x_{i}) - y_{i})x_j^{(i)} & \text{for j := 0...n} \\ \}$$

$m$ - size of the training set.

Derivation of $\frac{\partial}{\partial\theta_{j}} J(\theta)$ for a single example:

<img src="../../../../src/img/andr_ng_ml_course/ml_linear_regr_6.png" style="zoom: 80%;" />

We add $\frac{1}{m} \sum_{i=1}^{m}$  to compute the average of all derivations (gradients).

##### Batch gradient descent

All the training data is taken into the consideration to take a single step. We take the average of the gradients of all the training examples and then use that mean gradient to update our parameters. So that's just one step.

![xAQBlqaaEeawbAp5ByfpEg_24e9420f16fdd758ccb7097788f879e7_Screenshot-2016-11-09-08.36.49](../../../../src/img/andr_ng_ml_course/ml_linear_regr_8.png)

The optimization problem here for linear regression has only one global, and no other local, optima. That's why it always converges to the global minimum.



#### Speeding up gradient descent

We can speed up gradient descent by having each of our input values in roughly the same range. This is because $\theta$ will descend quickly on small ranges and slowly on large so the process of getting to minimum will be inefficient. 

##### Feature scaling

Make sure features are on a same similar scale (like $-1 \le x_i \le 1$). We could divide the input values by the range (the maximum value minus the minimum value) to result in a new range of just 1.

##### Mean normalization

Replace $x_i$ with $x_i-\mu_i$ to have features approximately zero mean. Substract the average value from an input variable (new average of input variable will be zero).


Formula for **implementing both**: $x_i = \frac{x_i - \mu_i}{s_i}$.

For example, if $x_i$ represents housing prices with a range of 100 to 2000 and a mean value of 1000, then $x_i := \frac{price - 1000}{1900}$.

> When working with polynomial regression (eg. $h_{\theta}(x) = \theta_0x_1 + \theta_2x_2^2 + \theta_3x_3^3$) using feature scaling becomes very important. if $x_1$ has range 1 - 1000 then range of $x_1^2$ becomes 1 - 1000000 and that of $x_1^3$ becomes 1 - 1000000000.

___



### 4. Normal Equation

Normal equation allows us to perform the minimization without iterations, in one go. We will minimize J by taking its derivatives with respect to the $\theta_j$'s, and setting them to zero. It will allow us to find the optimum. Formula is given below:
$$
\theta = (X^TX)^{-1}X^Ty
$$
<img src="../../../../src/img/andr_ng_ml_course/ml_linear_regr_9.png" alt="ml_linear_regr_9" style="zoom:80%;" />

>  There is **no need** to do feature scaling with the normal equation.



#### Gradient descent vs Normal Equation

| Gradient descent           | Normal Equation                               |
| -------------------------- | --------------------------------------------- |
| Need to choose $\alpha$    | No need to choose $\alpha$                    |
| Needs many iterations      | No need to iterate                            |
| O$(kn^2)$                  | O($n^3$), need to calculate inverse of $X^TX$ |
| Works well when n is large | Slow if n is very large                       |

O($n^3$) means very slow, so when $n$ exceeds 10000 it might be good to switch to an iterative process.



##### Normal equation Noninevitability

If $X^TX$ is noninvertible, the causes might be:

- Redundant linearly dependent features;
- Too many features ($m \le n$), so need to delete some features or use "regularization"
