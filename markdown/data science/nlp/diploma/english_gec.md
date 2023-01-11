## English GEC

1) Тренуємо на синтетичних даних спочатку

В роботі GECTOR це було 9M речень та в GEC in low resource languages було 10М, тому ми вирішили також натренувати на 10М для подальшого порівняння. 
З виходом нового C_200M, який вийшов у 2021 якість покращилась.

Там можна відразу й евалюейшони різні зробити. 

[NLP: Building a Grammatical Error Correction Model | by Priya Dwivedi | Apr, 2022 | Towards Data Science](https://towardsdatascience.com/nlp-building-a-grammatical-error-correction-model-deep-learning-analytics-c914c3a8331b)

2) Далі файнтюнінг на анотованому корпусі



Ми натренуємо на clang8, це крч звідси воно:

[2106.03830.pdf (arxiv.org)](https://arxiv.org/pdf/2106.03830.pdf)

Це чому не юзаєм підхід Clang8 + FCE and W&I:

> We also tried fine-tuning these models on BEA (i.e. FCE and W&I) after finetuning them on CLANG-8, but this did not further improve the scores but slightly decreased them, e.g. 0.43 absolute decrease for BEA test when using T5 base. This can be explained by the fact that the model used to clean the target texts has already been trained on BEA. This suggests that the typical GEC training pipeline where a model is first fine-tuned on LANG-8 and then on BEA can be both simplified and made more accurate by only fine-tuning on CLANG-8.