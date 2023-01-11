## :policeman: Overfitting & Regularization

[:arrow_backward:](../../ds_index)

[toc]

#### 1. The Problem of Overfitting

For picking the best model we might add extra features. However, sometimes it's bad because even though the fitted curve passes through all points perfectly, we wouldn't say that this become a good predictor.

![0cOOdKsMEeaCrQqTpeD5ng_2a806eb8d988461f716f4799915ab779_Screenshot-2016-11-15-00.23.30](../../../../src/img/andr_ng_ml_course/ml_overfitting_1.png)

On the left - problem of **underfitting** (structure is not captured by model at all);
On the center - good model;
On the right - problem of **overfitting**.

**Underfitting**, or high bias, causes from having very simple function or too few features. **Overfitting**, or high variance, is caused by a complicated function that is not well generalized to predict new data.

How to solve underfitting:

1) Reduce the number of features:
   - Manually select which features to keep.
   - Use a model selection algorithm.
2) Regularization:
   - Keep all the features, but reduce the magnitude of parameters $\theta_{j}$.
   - Regularization works well when each feature can contribute a little.



#### 2. Cost Function 

If we have overfit from our hypothesis function, we can reduce the weight that some of the terms carry by increasing their cost:
$$
min_\theta\ \dfrac{1}{2m}\sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})^2 + 1000\cdot\theta_3^2 + 1000\cdot\theta_4^2
$$
Now, in order for the cost function to get close to zero, we will have to significantly reduce the values of $\theta_3$ and $\theta_4$ to zero. Their weight has gone and our model is good:

<img src="../../../../src/img/andr_ng_ml_course/ml_overfitting_2.png" alt="ml_overfitting_2" style="zoom: 50%;" />


We could also **regularize** all of our theta parameters in a single summation as:
$$
min_\theta\ \dfrac{1}{2m}\  \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})^2 + \lambda\ \sum_{j=1}^n \theta_j^2
$$
The $\lambda$ is the **regularization parameter** that determines how much the costs of parameters should be inflated.

If $\lambda$ is chosen to be too large it may smooth out the function too much and cause underfitting.



#### 3. Regularized Linear Regression

We can apply regularization to linear regression, so here is next modification of gradient descent:
$$
\begin{align*} & \text{Repeat}\ \lbrace \newline & \ \ \ \ \theta_0 := \theta_0 - \alpha\ \frac{1}{m}\ \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})x_0^{(i)} \newline & \ \ \ \ \theta_j := \theta_j - \alpha\ \left[ \left( \frac{1}{m}\ \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})x_j^{(i)} \right) + \frac{\lambda}{m}\theta_j \right] &\ \ \ \ \ \ \ \ \ \ j \in \lbrace 1,2...n\rbrace\newline & \rbrace \end{align*}
$$
(separated $\theta_0$ because we don't need to penalize it with regularization).

##### Normal Equation

Formula with regularization:
$$
\begin{align*}& \theta = \left( X^TX + \lambda \cdot L \right)^{-1} X^Ty \newline& \text{where}\ \ L = \begin{bmatrix} 0 & & & & \newline & 1 & & & \newline & & 1 & & \newline & & & \ddots & \newline & & & & 1 \newline\end{bmatrix}\end{align*}
$$

> If $m<n$, then $X^TX$ is non-invertible. However, when we add the term $\lambda \cdot L$ , then $X^TX + \lambda \cdot L$ becomes invertible.



#### 4. Regularized Logistic Regression

Formula of the updated cost function:
$$
J(\theta) = - \frac{1}{m} \sum_{i=1}^m \large[ y^{(i)}\ \log (h_\theta (x^{(i)})) + (1 - y^{(i)})\ \log (1 - h_\theta(x^{(i)}))\large] + \frac{\lambda}{2m}\sum_{j=1}^n \theta_j^2
$$
In gradient descent we just add $+ \frac{\lambda}{m}\theta_j$ at the end for regularizing parameters (skip $\theta_0$).