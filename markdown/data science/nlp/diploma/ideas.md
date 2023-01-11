## Diploma ideas



GEC papers [here](https://paperswithcode.com/task/grammatical-error-correction/latest) (very cool) :heavy_exclamation_mark:



Ідея: юзати формат М2



Українська - фузійна мова. Як це впливає на тренування в НЛП.

> The Ukrainian language is a fusional language. Notional parts of speech possess a rich inflectional paradigm, which is why Ukrainian admits free word order.

[GEC corpus ukrainian](https://arxiv.org/pdf/2103.16997v1.pdf) 

Категорії помилок: fluency, grammar, punctuation, spelling.



Скрипти в пайтоні на виправлення базової граматики:
[DariaMinieieva/correctorUA: This is a telegram bot for correcting language mistakes in group chats (github.com)](https://github.com/DariaMinieieva/correctorUA)



####  A Simple Recipe for Multilingual Grammatical Error Correction

[Paper](https://arxiv.org/pdf/2106.03830v1.pdf) 

- CLANG-8 - звідси можна витягнути якісь українські тексти. Не витягнеш, в Lang-8 нема взагалі дуже укр мови.



1. Use mT5 model (multilingual version of T5)

> mT5 has been pre-trained on mC4 corpus, a subset of Common Crawl, covering 101 languages and composed of about 50 billion documents. About mt5 here in [paper](https://arxiv.org/abs/2010.11934).

2. GEC pre-training data

Split all paragraphs in mc4 corpus into sentences. After that corrupts each sentence. 

> For example, Naplava and Straka (2019) perform word substitutions with the entries from **ASpell4** which in turn makes the generation of synthetic data language-specific.

3. gT5: Large Multilingual GEC Model

Use fine-tuning datasets. Try next training regimes: 

- Mix GEC pre-training data with fine-tuning data 
- Mixing pre-training and fine-tuning examples but annotating with different prefixes (didn't get it)
- Use GEC pre-training until convergence and then fine-tuning (most computationally expensive but gives best results)



### Шо будем робить

Яка проблема: натренувати можем, але такі трабли:

- треба якусь хорошу базову мовну модель, яку прийдеться ше дотренувати на укр.

- мало даних (можливо прийдеться генерити синтетичні дані).



> У чому фішка: не зможемо писати БЕРТУ і якісь дуже круті різні хеди, які би виправляли по граматиці різні кейси, дуже треба багато крутити параметрів, аби цей multi stage tuning запрацював + може то багато коду, якому прийдеться самому писати.
> І запарно продумувати оте правильне тегування.



#### Українізований mT5 дотренований на синтетичних даних + UA_GEC fine-tuning

База взята маленько відси: [A Simple Recipe for Multilingual Grammatical Error Correction](https://arxiv.org/pdf/2106.03830v1.pdf). 

1. [How to adapt a multilingual T5 model for a single language | by David Dale | Towards Data Science](https://towardsdatascience.com/how-to-adapt-a-multilingual-t5-model-for-a-single-language-b9f94f3d9c90)
   Можна попробувати з base версією та xxl (будуть такі модні таблички потім) - мені треба тиждень на це.

2. Далі можна спробувати нагенерити синтетичні дані (тут Масік) - і далі будем тестити з ними й без них. Оригінальний пейпер як то можна зробити -  [Synthetic Data Generation for Grammatical Error Correction with Tagged Corruption Models](https://arxiv.org/pdf/2105.13318.pdf)
3. Fine-tuning на сгенерованому (я) й відпріпроцесеному датасеті UA_GEC (Масік)



Пейпери додаткові:

- [Statistical and neural language models for the Ukrainian Language (ucu.edu.ua)](https://er.ucu.edu.ua/bitstream/handle/1/2047/Khaburska_Statistical and Neural Language.pdf?sequence=1&isAllowed=y)
- [Context-Based Question-Answering System for the Ukrainian Language (ucu.edu.ua)](https://er.ucu.edu.ua/bitstream/handle/1/1898/Tiutiunnyk_Context-based Question-answering.pdf?sequence=1&isAllowed=y)
- [A Comparative Analysis for English and Ukrainian Texts  Processing Based on Semantics and Syntax Approach](http://ceur-ws.org/Vol-2870/paper26.pdf)



#### Інші системи й порівняння

##### GECToR (2020)

З пейпера [його](https://arxiv.org/pdf/2005.12592.pdf):

> NMT-based GEC systems suffer from several issues which make them inconvenient for real world deployment: (i) slow inference speed, (ii) demand for large amounts of training data and (iii) interpretability and explainability; they require additional functionality to explain corrections, e.g., grammatical error type classification.

У них це вирішується тим, що вони не юзають енкодер-декодер, а тільки енкодер. Не генерують нові речення (sequence generation), а генерують теги (sequence tagging).

Їхнє рішення:

> Our GEC sequence tagging system consists of three training stages: pretraining on synthetic data, fine-tuning on an errorful parallel corpus, and finally, fine-tuning on a combination of errorful and on a small, high-quality dataset containing both errorful and error-free sentences.

Але впирається все у комплексність (треба придумувати цілу систему тегувань).



##### WebSpellChecker (2019)

Використовується BERTа для encoded репрезентацій і "heads" - шось типу нейронок, які шукають помилки, позначають їх (себто дають рекомендації де треба поправити) й потім вже окремо поправляють.
Головна перевага: теж як у гектору - все швидше і результати також високі. 

З того їх [пейпера](https://aclanthology.org/W19-4426.pdf):

> Though this approach can represent the following challenges: (i) the sequence is reconstructed entirely, regardless of errors number; (ii) sentences are processed at low speed during inference; (iii) errors tend to accumulate since a failure in prediction of a single token can lead to a rupture of the entire chain in the network.

Але теж ці хеди свої придумувати складно й довго.

