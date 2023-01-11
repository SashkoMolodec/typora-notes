## :bulb: Logistic Regression

[:arrow_backward:](../../ds_index)

Sometimes we don't need $h_{\theta}$ to take values larger than 1 or smaller than 0 (we need to give a probability percentage, for e.g.). To satisfy $0 \le h_{\theta}(x) \le 1$ we'll use Logistic Function.

[toc]

#### 1. Hypothesis Representation

We use the "Sigmoid Function", also called the "Logistic Function":
$$
h_{\theta}(x) = g(\theta^Tx) \\
z = \theta^Tx \\
g(z) = \frac{1}{1+e^{-z}}
$$
Sigmoid function looks like this:

![1WFqZHntEead-BJkoDOYOw_2413fbec8ff9fa1f19aaf78265b8a33b_Logistic_function](../../../../src/img/andr_ng_ml_course/ml_lg_1.png)

$$
z = 0, e^0 = 1 \Rightarrow g(z) = 1/2 \\ 
z \rightarrow \infin, e^{-\infin} \rightarrow 0 \Rightarrow g(z) = 1 \\ z \rightarrow -\infin, e^{\infin} \rightarrow \infin \Rightarrow g(z) = 0
$$
So if our input $g$ is $\theta^TX$, then that means:
$$
h_{\theta}(x) = g(\theta^TX) \ge 0.5 \\ when \  \theta^Tx \ge 0
$$
From these statements we can now say:
$$
\theta^Tx \ge 0 \Rightarrow y = 1 \\ 
\theta^Tx \lt 0 \Rightarrow y = 0
$$

##### Decision Boundary

<img src="../../../../src/img/andr_ng_ml_course/ml_lg_2.png" alt="ml_lg_2" style="zoom: 33%;" />

The decision boundary is the line that separates the area where $y=0$ and where $y=1$. It is created by our hypothesis function and it could possibly be non-linear.



#### 2. Cost Function for Logistic Regression

Formula:
$$
\begin{align*}& J(\theta) = \dfrac{1}{m} \sum_{i=1}^m \mathrm{Cost}(h_\theta(x^{(i)}),y^{(i)}) \newline & \mathrm{Cost}(h_\theta(x),y) = -\log(h_\theta(x)) \; & \text{if y = 1} \newline & \mathrm{Cost}(h_\theta(x),y) = -\log(1-h_\theta(x)) \; & \text{if y = 0}\end{align*}
$$
When $y = 1$, we get the following plot for $J(\theta)$ vs $h_{\theta}(x)$:

<img src="../../../../src/img/andr_ng_ml_course/ml_lg_3.png" alt="ml_lg_3" style="zoom: 67%;" />

$Cost = 0$ if $y=1, h_{\theta}(x) = 1$
But as $h_{\theta}(x) \rightarrow 0 \\ Cost \rightarrow \infin$

Captures intuition that if $h_{\theta}(x) \rightarrow 0$ but $y=1$ then we penalize learning algorithm by a very large cost (so we'll need to minimize it for better predictions).

Similarly, when $y=0$:

<img src="../../../../src/img/andr_ng_ml_course/ml_lg_5.png" style="zoom:67%;" />



##### Simplified version

We can compress our cost function's into one case:
$$
\mathrm{Cost}(h_\theta(x),y) = - y \; \log(h_\theta(x)) - (1 - y) \log(1 - h_\theta(x))
$$
When $y$ is equal to 1, then the second term $(1-y)\log(1-h_{\theta}(x))$ will be zero and won't affect the result. If $y=0$ then first term disappears. 

Full version of the cost function:
$$
J(\theta) = - \frac{1}{m} \displaystyle \sum_{i=1}^m [y^{(i)}\log (h_\theta (x^{(i)})) + (1 - y^{(i)})\log (1 - h_\theta(x^{(i)}))]
$$
Vectorized implementation:
$$
\begin{align*} & h = g(X\theta)\newline & J(\theta) = \frac{1}{m} \cdot \left(-y^{T}\log(h)-(1-y)^{T}\log(1-h)\right) \end{align*}
$$


#### 3. Multiclass Classification: One-vs-all

<img src="../../../../src/img/andr_ng_ml_course/ml_lg_6.png"  />
