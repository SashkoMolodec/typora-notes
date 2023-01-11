## Spring Data

[:arrow_backward:](../spring_index)

The Spring Data project is a large umbrella project comprising several subprojects, which are focused on different data persistence.

[toc]

### JDBC

JDBC is a interface that communicate with a database. It uses vendor-supplied API.

### JPA

JPA serves as a layer of abstraction that hides the low-level JDBC calls from the developer and allows to bind java objects to database entities (ORM).

### JDBC vs JPA

##### Database interactions

JDBC allows us to write SQL commands to read data from and update data to a relational database. JPA allows to construct **database-driven Java programs object-oriented semantics** with mapping annotations.

##### Managing associations

With JDBC we need to write out the full SQL query, while with JPA, we use annotations to create one-to-one, one-to-many, many-to-one and many-to-many  associations. 

##### Database dependency

JDBC is database-dependent. JPA is database-agnostic, meaning that the same code can be used in a variety of databases.

##### Exceptions Handling

JDBC throws checked exceptions, such as *SQLException* which we need to handle. JPA framework uses only uncheked exceptions, like Hibernate.

##### Performance

It depends who does the coding: JPA or local developer. When writing SQL queries incorrectly, JDBC performance can be very bad. So preferably use JPA. 

##### Transaction Management

In JDBC, transactions are handled explicitly by using commit and rollback. In JPA, transaction management is implicitly provided. 