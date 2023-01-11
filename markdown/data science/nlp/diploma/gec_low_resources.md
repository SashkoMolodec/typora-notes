## Grammatical Error Correction in Low-Resource Scenarios

Original paper [here](https://arxiv.org/pdf/1910.00353v3.pdf).

Гітхаб репо зі скріптами по генеруванню синтетичних даних [тут](https://github.com/ufal/low-resource-gec-wnut2019).



- Прітрейн на синтетичних даних until convergance. Лейбли берем з common crawl і генеруємо noisy інпути (неправильні речення)

- Файнтюн модель на міксі з original language training data (з анотованого геку) і їх згенерованими синтетичними версіями у якомусь ratio (для чеської/німецької/англ це було 1:2 (5M original oversampled, 10M syntetical)).

  > The original sentences in Czech, German and Russian are the training data of the corresponding languages.
  >
  > Це берем наший в 20К і робим аж 5 мільйонів

  

Я маю синтетичні (неправильне-правильне речення) для прітрейнінгу

І дані для файнтюнінгу з анотованого ГЕК корпусу оверсемплю овердофіга, аби було 10М синтетчних і 5М оріджінал оверсемплед.



Розроб