## :older_man: Advices for applying ML

[:arrow_backward:](../../ds_index)

[toc]

#### 1. Evaluating a hypothesis

A hypothesis may have a low error for the training examples but still be inaccurate (overfitting). We can split up the data into **training** and **test** sets (70/30). Here is procedure:

1. Learn $\Theta$ and minimize $J_{train}(\Theta)$ using the training set
2. Compute the test set error $J_{test}(\Theta)$

##### The test set error

1. For linear regression: $J_{test}(\Theta) = \dfrac{1}{2m_{test}} \sum_{i=1}^{m_{test}}(h_\Theta(x^{(i)}_{test}) - y^{(i)}_{test})^2$

2. For classification ~ Misclassification error: 
   $$
   err(h_\Theta(x),y) = \ \begin{matrix} 1 & \mbox{if } h_\Theta(x) \geq 0.5\ and\ y = 0\ or\ h_\Theta(x) < 0.5\ and\ y = 1\newline 0 & \mbox otherwise \end{matrix}
   $$
   Having binary error results we can get the average test error:

$$
\text{Test Error} = \dfrac{1}{m_{test}} \sum^{m_{test}}_{i=1} err(h_\Theta(x^{(i)}_{test}), y^{(i)}_{test})
$$

#### 2. Model Selection

Given many models with different polynomial degrees and training set (60% of data), we can identify the best function with lowest cost for our cross validation set (20% of data), and after that estimate it with generalization error using test set (20% of data):

<img src="../../../../src/img/andr_ng_ml_course/advice_applying_ml_model_selection.png" alt="image-advice_applying_ml_model_selection" style="zoom: 33%;" />



#### 3. Diagnosing Bias vs. Variance

We need to find a golden mean between bias and variance. Increasing degree of polynomial tend to decrease the training error but at some point it will increase error, forming a convex curve, for cross validation set: 

<img src="../../../../src/img/andr_ng_ml_course/advice_applying_ml_diagnosing_bias_variance.png" alt="advice_applying_ml_diagnosing_bias_variance" style="zoom:80%;" />

**High bias (underfitting)**: both $J_{train}(\Theta)$ and $J_{CV}(\Theta)$ will be high. Also, $J_{CV}(\Theta) ≈ J_{train}(\Theta)$.
**High variance (overfitting)**: $J_{train}(\Theta)$ will be low and $J_{CV}(\Theta)$ will be much greater than $J_{train}(\Theta)$.

##### Regularization and Bias/Variance

For picking the right $\lambda$ you can iterate through certain values to learn some $\Theta$ and after computing all cross validation errors pick one with the lowest error for testing on $J_{test}(\Theta^{(j)})$ to see if it's well generalized.

<img src="../../../../src/img/andr_ng_ml_course/advice_applying_ml_regularization_and_bias_variance.png" alt="advice_applying_ml_regularization_and_bias_variance" style="zoom: 33%;" />



#### 4. Learning Curves

Starting from a few training examples as data gets larger, the error for a quadratic function increases. On certain $m$ of examples the error value will plateau so it's not always correct to have a LOT of data. There are two cases when data suffers.

##### Experiencing high bias:

Low training set size: causes $J_{train}(\Theta)$ to be low and $J_{CV}(\Theta)$ to be high.
Large training set size: causes both $J_{train}(\Theta)$ and $J_{CV}(\Theta)$ to be high with  $J_{CV}(\Theta) ≈ J_{train}(\Theta)$.

![bpAOvt9uEeaQlg5FcsXQDA_ecad653e01ee824b231ff8b5df7208d9_2-am](../../../../src/img/andr_ng_ml_course/advice_applying_ml_experiencing_high_bias.png)

Conclusion: if suffering from **high bias** getting more training data won't (by itself) help much.

##### Experiencing high variance:

Low training set size: $J_{train}(\Theta)$ be low and $J_{CV}(\Theta)$ to be high.
Large training set size: $J_{train}(\Theta)$ increases with training set size and $J_{CV}(\Theta)$ continues to decrease.  $J_{CV}(\Theta) \gt J_{train}(\Theta)$.

![vqlG7t9uEeaizBK307J26A_3e3e9f42b5e3ce9e3466a0416c4368ee_ITu3antfEeam4BLcQYZr8Q_37fe6be97e7b0740d1871ba99d4c2ed9_300px-Learning1](../../../../src/img/andr_ng_ml_course/advice_applying_ml_experiencing_high_variance.png)

Conclusion: If suffering from **high variance**, getting more training data is likely to help.



#### 5. Decision process

- **Getting more training examples:** Fixes high variance

- **Trying smaller sets of features:** Fixes high variance

- **Adding features:** Fixes high bias

- **Adding polynomial features:** Fixes high bias

- **Decreasing λ:** Fixes high bias

- **Increasing λ:** Fixes high variance.

##### **Diagnosing Neural Networks**

- A neural network with fewer parameters is **prone to underfitting**. It is also **computationally cheaper**.
- A large neural network with more parameters is **prone to overfitting**. It is also **computationally expensive**. In this case you can use regularization (increase λ) to address the overfitting.

**Model Complexity Effects:**

- Lower-order polynomials (low model complexity) have high bias and low variance. In this case, the model fits poorly consistently.
- Higher-order polynomials (high model complexity) fit the training data extremely well and the test data extremely poorly. These have low bias on the training data, but very high variance.
- In reality, we would want to choose a model somewhere in between, that can generalize well but also fits the data reasonably well.



#### 6. Error Analysis

- Start with a simple algorithm, implement it quickly, and test it early on your cross validation data.
- Plot learning curves to decide if more data, more features, etc. are likely to help.
- Manually examine the errors on examples in the cross validation set and try to spot a trend where most of the errors were made.



#### 7. Skewed classes

Suppose we are predicting if person has a cancer. We got 99% of correct diagnoses and 1% error with our model, which sound good. But only 0.50% of patients have cancer so these correct percent's aren't so really. This little class is **skewed**. We need another evaluation metric using precision/recall.

<img src="../../../../src/img/andr_ng_ml_course/advice_applying_ml_skewed_classes.png" alt="image-advice_applying_ml_skewed_classes" style="zoom:50%;" />

##### Precision (how correct)

We have a group of patients for whom we predicted y=1 (has cancer)(predicted positives). How many patients from that group actually have cancer?
$\frac{True \ positives}{\#predicted \ positives} = \frac{True \ positive}{True \ pos + False \ pos}$

##### Recall (how many missed)

We have a group of patients that actually has a cancer (actual positives). How many patients from that group we correctly identified as having cancer? 

$\frac{True \ positives}{\#actual \ positives} = \frac{True \ positive}{True \ pos + False\ neg}$

##### Trading off precision and recall 

If we want to say to a patient if he has a cancer **only if we are very confident** we end up with **higher precision**, **lower recall** (we will predict y=1 on smaller amount of patients).  We set the threshold = 0.9, for example.
If we want to avoid missing too many cases of cancer (avoid false negatives) we'll set the threshold for 0.3 and end up with **higher recall**, **lower precision**.

##### $F_1$ Score (F score)

For picking the best trade-off between precision/recall numbers we can calculate $F_1$ Score: $2\frac{PR}{P+R}$ (P - precision, R - recall), and ideal score would be 1, bad - 0, so need to pick the highest score for best result.
