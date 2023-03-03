## :page_with_curl: Clean Code Notes

[:arrow_backward:](backend_index)

[toc]

#### formatting

Код читається зверху-вниз: з більш абстрактного до більш конкретного - як статті в газетах.

Якщо функція викликається іншою, то її краще десь неподалік закинути, аби можна було швидко знайти.

Константи не обов'язково розміщувати на початку класу - вартує їх тримати в потрібному скоупі. Якщо вона використовується у чомусь низькорівневому, то який сенс оголошувати ту змінну на вищому рівні абстракції класу?



#### functions

Функції мають бути компактними. Бажано не більше 20 стрічок.

Функція повинна виконувати тільки одну операцію. І вона повинна виконувати її добре.

Буває таке, що складно оприділити кількість операцій. Тоді треба дивитись: якщо все відбувається на одному рівні абстракцій, то може бути як одна:

```
public static String renderPageWithSetupsAndTeardowns(
  PageData pageData, boolean isSuite) throws Exception {
  if (isTestPage(pageData))
    includeSetupAndTeardownPages(pageData, isSuite);
  return pageData.getHtml();
}
```

Якби ми описували функцію вище, то це виглядало б так:  перевіряємо, чи сторінка являється тестовою. Якщо це так, то включаємо певні блоки. В будь-якому випадку генеруємо HTML код.

Якщо ми розбиваємо функцію на секції, то це теж погано, тому що осмисленно це зробити неможливо (тому й поганою є практика залишати коментарі).

Код повинен читатись зверху вниз (від найвищої абстракції до найменшої).


**switch в методах.**
Написати компактний switch досить складно, бо по природі він вже займає багато місця. Уникнути його можна - юзати поліморфізм.

Але не завжди втічеш, тому його треба ховати у якісь класи-фабрики, для прикладу.

Правило з книги: юзати, якщо використовується для створення поліморфних об'єктів й ховаються за властивістю наслідування, аби бути невидимим для інших частин системи.


**аргументи функцій.**
Функції з трьома параметрами варто уникати, або мати дуже хороші аргументи й пояснення, чому її варто залишити.

Існують різні кейси використання унарних форм (один аргумент):
- перевірка якоїсь умови *fileExists("MyFIle")*;
- отримання аргументу, його обробка й повернення;
- подія (без вихідного параметру), тут треба спеціально підбирати такі назви, аби користувач це зрозумів. 

Якщо передаємо й модифікуємо, то краще повертати це назад. Й out параметр передавати й не повертати теж якось не дуже.
*StringBuffer transform(StringBuffer in) > void transform(StringBuffer out)*

Аргументи-прапорці - дуже паскудна річ.

Краще уникати вихідних аргументів, а юзати щось типу *report.appendFooter()*.

Щодо бінарних функцій, то їх розуміти складніше, ніж унарні. 
виклик **writeField(name)** зі сходу зрозуміліший, ніж **writeField(outputStream, name)**. Варто зупинитись й тільки тоді буде ясно, що перший аргумент **outputStream** повинен ігноруватись. Але так не повинно бути, адже саме в таких місцях й ховаються проблеми. 

Варто ізольовувати блоки try/catch, тому що вони замішують обробку помилки з основним кодом. Й це вже дві операції.

Старатись надавати перевагу нестатичним методам, ніж статичним. Якщо має бути таки статична, то варто впевнитись чи в майбутньому ми не вимагатимемо від неї поліморфної поведінки.



#### classes

В класі спочатку йдуть відкриті статичні константи, далі приватні статичні, за ними приватні змінні. Далі йдуть паблік методи, а нижче приватні.

Інкапсуляція. Поля класу й допоміжні методи як правило приватні, але іноді робимо їх захищеними (аби дістатись до них з тестів).

Класи повинні бути компактними. Й цю компактність визначає ступінь відповідальності. (single responsibility principle).

Зв'язність. В кожному класі має бути невелика кількість змінних екземплярів. Кожний метод класу може оперувати з якоюсь кількістю цих змінних. Й чим більше аргументів, тим більше цей метод є зв'язним з класом. Це добре.

Підтримка зв'язності приводить до зменшенню класів.

Розглянемо невеличкий приклад: в нас є велика функція з багатьма змінними. Ми хочемо виділити якийсь кусочок в окремий невеличкий метод, але є проблема - юзається в цьому кусочку аж 4 змінних. Передамо ці параметри новій функції у виді параметрів? **НЄЄ**.
Якщо ми переробимо ті змінні методу в змінні класу, то зможемо простіше виділити код.
Звісно, може так статись, що дуже багато вилізе тих полів класу, які будуть юзатись в окремих методах. Буде втрачатись зв'язність. Можливо тоді вартує виділити змінні/методи в цілий новий клас? Якщо ми це зробимо, то зв'язність збільшиться, а це чудово.

Структурування з врахуванням змін.



#### about architecture

Є чотири простих правила, завдяки яким підвищується якісь проектування й зберігається чистота коду:
- забезпечувати проходженню всіх тестів
- не містити коду, який дублюється
- аби код був прямолінійним й легко зрозумілим
- мінімальна кількість класів й методів

Дуже корисно мати тести, аби можна було рефакторити й узагалі не боятись за те, шо десь щось поламаєш.



#### comments

Коментарі це дурна штука. 

Їх юзати можна, але в дуже окремих випадках:
- юридичні коментарі
- пояснення, якщо ми використовуємо стандартні ліби, або код, який не можемо змінити
- попередження про щось
- TODO

Загальні правила кажуть, що кожна функція має мати коментар javadoc. Але це неправада - часто буде тільки гірше.

Коли ми коментуємо функцію, то розглядаємо суто її скоуп.

Немає сенсу юзати javadoc, якщо код не буде використовуватись для широкого кола людей. Лишні коментарі будуть тільки відволікати.

Закоментований код, який не юзається, варто відразу видаляти!



#### exceptions

Хорошою практикою є винесення обробки якоїсь помилки в окремий метод. 

Для того, щоб приховувати десь багато логіки exceptions - можна юзати класи-обгортки.
Також обгортки використовуються для того, щоб зменшити залежність між власним кодом й викликом сторонніх апі (в якомусь одному класі повністю пропрацюємо їх й потім у наший код).

```java
public class LocalPort {
  private ACMEPort innerPort;

  public LocalPort(int portNumber) {
    innerPort = new ACMEPort(portNumber);
  }

  public void open() {
    try {
      innerPort.open();

    } catch (DeviceResponseException e) {
      throw new PortDeviceFailure(e);
    } catch (ATM1212UnlockedException e) {
      throw new PortDeviceFailure(e);
    } catch (GMXError e) {
      throw new PortDeviceFailure(e);
    }
  }
}

...

LocalPort port = new LocalPort(12);
  try {
    port.open();
  } catch (PortDeviceFailure e) {
    reportError(e);
    logger.log(e.getMessage(), e);
  } finally {
  }
```

Fowler - об'єкти особливої поведінки. Ми створюємо спеціальний об'єкт, який налаштовуємо, щоб він відпрацьовував в окремому місці якусь поведінку. 

Не повертати null !!!
Якщо десь може бути NullPointerExceptiom, то заміняємо можливий викид null'а на ексепшон, або об'єкт "особливого випадку" (його окремо налаштовуємо так, що при якомусь кейсі, для прикладу, повернемо дефолтний об'єкт). Якщо зі стороннього API може прилетіти null, то вартує сворити обгортку з методом, який має це зарізолвати.

Не передавати null !!!
Не існує хороших способів, як це обробляти. Тому краще взагалі це заборонити.



#### module testing

TDD - Test Driven Development:
- Не писати коду продукту, поки не напишеться "отказной" модульний тест;
- Не писати модульний тест в об'ємі більшому, ніж потрібно для "отказа";
- Не писати коду продукту в об'ємі більшому, ніж потрібно для проходження "отказного" тесту.

Тести писати надзвичайно корисно, бо якщо ми повністю їх напишемо для якогось класу, то не будемо боятись змінювати самий код. Й тут ще важливо підтримувати тести, які вже були написані, бо в іншому випадку з часом вони також пропадуть.

Класно юзати патерн **побудова-операція-перевірка**. Це коли ми спочатку будуємо тестові дані, викликаємо самий метод й робимо перевірки результатів.

В тестовому середовищі можна нехтувати пам'яттю. Й загалом, можна більше штучок робити, ніж в реальному коді. Але чистим він все одно має бути.

Правило одного assert'у досить хороше, бо легко будуть читатись тести. Але якщо треба більше одного, то не страшно.

**Одна тестова функція має перевіряти тільки одну концепцію.**

П'ять додаткових характеристик чистих тестів:
- Fast. Тести мають швидко запускатись;
- Independent. Тести не повинні залежати одне від одного;
- Repeatable. Тести мають давати однакові результати в будь-якому середовищі (бо якщо середовище не буде доступним, то й ніц не протестуєш);
- Self-validating. Тест має бути очевидним й зрозумілим. Пройшов він чи ні;
- Timely. Модульні тести мають писатись своєчасно, а саме перед кодом продукта (якщо буде здаватись, що тестувати складно, то значить це ніяк не продумувалось при проектуванні кода продукта).

Модульні тести варто писати ще перед написанням кодом продукту, аби передбачити зручність в тестуванні.



#### objects and data structures

*Процедурний код (той, який використовує структури даних), дозволяє легко добавляти нові функції без змін існуючих структур даних. Напрочуд, ООП код спрощує добавлення нових класів без змін існуючих функцій.*

*В процедурному коді важко добавляти нові структури даних, бо потрібні зміни усіх функцій. В ООП складно додати нові функції, бо прийдеться переписувати усі класи.*

Приховування реалізації направлено на формування абстракцій!
Замість простого геттера можемо написати якийсь крутіший метод, який би щось повертав (вирахувані проценти, для прикладу).

Закон Деметри (поширюється тільки на ООП)
Метод не повинен викликати методи об'єктів, які повертаються завдяки якомусь методу.
ctxt.getOptions().getScratchDir().getAbsolutePath() - погано.

DTO це не об'єкт, а структура даних, тому бізнес-логіки там немає бути.



#### systems

Масштабування

*Можливість побудувати "правильну систему з першого разу" - міф.*
Сьогодні реалізуємо одні ріквайрменти, завтра інші. В цьому й сенс гнучкої-ітеративної розробки.

Аспектно-орієнтовне програмування - універсальний підхід для відновлення, підтримки модульності при перехресній (наскрізній) функціональності (коли пхаємо якісь перевірки на ролі, засікання часу відпрацьовування коду, тощо). 
Для таких штук пишуть аспекти.

- Посередники (proxies). Юзаються для створення обгорток для виклика методів окремих об'єктів.

Spring AOP - приклад реалізації тої аспектної біди. Підключаєш ліби, конфігуруєш їх десь - готово! І кешування, зберігання об'єктів, транзакція, безпека - усе наскрізне буде десь в окремому місці, але не в нашому основному коді.

AspectJ - дуже круте розширення джави, на якій можна чудити аспекти. Хоч рішень на Spring й JBoss хватає на 80-90%, однаково ApspectJ дуже потужний інструмент для реалізації аспектної біди. 



#### multithreading

Вартує відділяти багатопотоковий код від іншого основного - для кращого тестування, SRP, легшому виявленню помилок. 

Варто обмежувати доступ до використання спільних об'єктів, даних.

Погано, коли клас має кілька synchronized методів, бо може вилізти багато помилок. Одного такого методу буде досить.

Синхронізовані секції мають мати мінімальний розмір. 



### New

#### Meaningful Names

The length of a name should correspond to the size of its scope.

No need of type encoding (`phoneString`).

Encode the implementation, not the interface (do not use naming `IShapeFactory` but `ShapeFactoryImpl`).

When constructors are overloaded, use static factory methods with names that describe the arguments. For example,

```java
Complex fulcrumPoint = Complex.FromRealNumber(23.0);
```


Pick one word for absctarct concept (it's confusing to have `fetch`, `retrieve `and `get` as equivalent methods of different classes).

Place names in context for your readed by enclosing them in well-named classes, functions, or namespaces.



#### Functions

The blocks within if statements, else statements, while statements should be one line long. It would probably be a function call (with a good descriptive name).

In order to make sure that functions are doing "one thing", we need to make sure that the statements within are at the same level of abstraction.
If we can extract another function from a function without restatement of its implementation then it's doing more than "one thing".

`switch` statement violates SRP (more than one reason to change) and OCP (change whenever new types are added). Tolerate `switch` if they appear only once, are used to create polymorphic objects and are hidden behind an inheritance (may use Abstract Factory pattern).

Don't be afraid to make a function name long.

Avoid passing three arguments. 

Output arguments are harder to understand than input arguments. One input argument is the next best thing to no arguments, for example `Includer.render(pageData)`. Clearly, we will render the data in the `pageData` object.

**Common Monoadic forms**

Good:

```java
boolean fileExists("MyFile")
InputStream fileOpen("MyFile")
void passwordAttemtFailedNTimes(int attempts) //event
```

Bad:

```java
void includeSetupPageInto(StringBuffer pageText)
```

Better:

```java
StringBuffer transform(StringBuffer in)
```

> If a function is going to transform its input, the transformation should appear as the return value.

**Dyadic Functions**

We should generally try to convert them into monoadic. May try to make the method as a class member of some argumnet (`writeField` inside `outputStream` to say `outputStream.writeField(name)`).

Good when:

- Ordered components of a single value (`new Point(0,0)`)


When a function seems to need more than two or three arguments, maybe we should wrap them into a separate class to pass only one instance.

In general, output arugments should be avoided. **If your function must change the state of something, have it change the state of its owning object**.

Extract the bodies of the `try` and `catch` block out into function of their own. 

> Functions do one thing, error handling is one thing, thus functions that handles erros should do nothing else. 



#### Object and data structures

Objects expose behavior and hide data. Easy to add new objects without changing existing behaviors. Hard to add new behaviors to existing objects.

Data structures expose data and have no significant behavior. Easy to add new behaviors to existing data structures. Hard to add new data structures to existing functions.

**The Law of Demeter**

A modue should not know about the innards of the objects it manipulates. Method *f* of a class *C* should only call the methods of these:

- *C*
- An object created by *f*
- An object passed as an argument to *f*
- An object held in an instance variable of *C*

The method should not invoke methods on objects that are returned by any of the allowed functions. Talk to friends, not strangers.
Bad example:

```java
final String outputDir = ctxt.getOptions().getScratchDir().getAbsolutePath()
```

> Note! if ctxt, Options and ScratchDir are just data structures (like DTOs) without behaviour, then they naturally expose their internal structure so no Demeter applies here.



#### Exceptions

Write tests that force exceptions, and then add behavior to your handler to satisfy your tests (catch thrown by test exception). This will cause to build the transaction scope of the `try` block first and maintain the transcation nature of that scope.

If we are calling a null-returning method from a third-party API, consider wrapping that method with a method that either throws an exception or returns a special case object.



#### Tests

**TDD** 3 laws:

- You may not write production code until you have written a failing unit test
- You may not write more of a unit test than is sufficient to fail, and not compiling is failing
- You may not write more production code thant is sufficient to pass the currently failing test



#### Classes

Classes should have a small number of instance variables. Each of the methods of a class should manipulate one ore more of those variables. The more variables a method manipulates **the more cohesive** that method is to its class. It's good to have a high cohesion (згуртованість). 

> When classes lose cohesion - split them.

Do not depend on implementation details but on the interface - isolate the changes. Very useful when integrating third party. We are minimizing coupling (зв'язність) in this way. **The lack of coupling** means that the elements of our system are better isolated from each other and from change.



#### Emergence

Design is "simple" if it follows there rules:

- Runs all the tests
- Contains no duplications
- Expresses the intent of the programmer
- Minimizes the number of classes and methods

The rules are given in order of importance.



#### Multithreading

Recommendations for testing (page 187 in details):

- Treat spurious failures as candidate threading issues

  > Do not ignore system failures as one-offs.

- Get your nonthreaded code working first

- Make your threaded code pluggable

  > Make your thread-based code especially pluggable so that you can run it in various configurations.

- Make your threaded code tunable (tune number of threads)

- Run with more threads than processors

- Run on different platforms

- Instrument your code to try and force failures (hand-coded or automated)
