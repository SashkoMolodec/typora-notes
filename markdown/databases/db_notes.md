## DB relational notes

[:arrow_backward:](databases_index)

[toc]

#### Normalization

**1NF**: Avoid arrays in single columns 

<img src="../../src/img/databases/db_relational_notes/1.png" alt="image-20230620131559728" style="zoom:50%;" />

Solution: decompose arrays in some other table and make reference by key

<img src="../../src/img/databases/db_relational_notes/2.png" alt="image-20230620131711017" style="zoom:50%;" />



**2NF**: Avoid partial dependencies on the candidate (can be primary, composite) keys

<img src="../../src/img/databases/db_relational_notes/3.png" alt="image-20230620131530017" style="zoom:50%;" />

Solution: 

<img src="../../src/img/databases/db_relational_notes/4.png" alt="image-20230620131950188" style="zoom:50%;" />



**3NF**: all non-primary keys columns can be worked out only from the primary key column(s) and no other usual columns. Should avoid any **transitive** dependencies.

<img src="../../src/img/databases/db_relational_notes/5.png" alt="image-20230620134609990" style="zoom:50%;" />

Only primary key here is staffNo (because this table is all about the staff) For example, here we can make branchAdress from **staffNo**, and at the same time branchAdress from **branchNo**. 

A - staffNo, B - branchAdress, C - branchNo 
B depends on A, C depends on B, so C depends on A via B (transitive dependency).

Solution:

<img src="../../src/img/databases/db_relational_notes/6.png" alt="image-20230620135220972" style="zoom:50%;" />



#### Transactions

**Транзакція** – це неподільна з точки зору бази даних операція, котра виконується цілком, або не виконується зовсім і переводить базу даних з одного **узгодженого стану** в інший.

<img src="../../src/img/databases/db_relational_notes/7.png" alt="image-20230620184458642" style="zoom:50%;" />

Optimistic locking (оптимістичне блокування) - це підхід, при якому транзакції не блокують доступ до даних, а замість цього перевіряють, чи не змінилися ці дані в інших транзакціях під час їх виконання. Якщо дані не змінилися, тоді транзакція може продовжуватися. Якщо ж дані були змінені, тоді транзакція переривається.

Pessimistic locking (песимістичне блокування) - це підхід, при якому транзакції блокують доступ до даних, щоб інші транзакції не могли їх змінювати або зчитувати. Цей підхід використовується, коли очікується велика кількість конфліктних запитів до бази даних.

