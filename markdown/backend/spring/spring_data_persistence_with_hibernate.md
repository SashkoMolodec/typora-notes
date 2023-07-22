## Java Persistence with Spring Data and Hibernate 

[:arrow_backward:](spring_index)

[toc]

##### Object/relational paradigm mismatch

- The problem of granularity
- The problem of inheritance
- The problem of identity
- The problem of associations
- The problem of data navigation

##### JPA vs Hibernate JPA vs Spring Data

The **JPA** specification defines the following:

- Facility for specifying mapping metadata - how persistent classes and their properties relate to the db schema. JPA relies heaviliy on Java annotations in domain mdel classes
- APIs for performing basic CRUD operations on instances of persisten classes, EntityManager for storing and loading data
- A JPQL language for specifying queries that refer to classes and properties of classes 
- How the persistence engine interacts with transactional instances to perform dirty checking, association fetching, and other optimization functions. JPA covers basic caching strategies

**Hibernate** implements JPA and supports all the standartized mappings, queries, and programming interfaces:

- *Productivity* - Hibernate eliminates much of the repetitive work
- *Maintanability* - Automated ORM with Hibernate reduces lines of code, making the system more understandable. Hibernate provides buffer between the domain model and the SQL schema, isolating each model from minor changes to the other
- *Performance* - Hand-coded persistence might be faster, but Hibernate allow the use of many optimizations *at all times*
- *Vendor independence* - Hibernate can help mitigate some of the risks associated with vendor lock-in.

**Spring Data** makes the implementation of the persistence layer even more efficient. Spring Data JPA sits on top of the JPA layer, Spring Data JDBC sits on top of JDBC. Benefits:

- *Shared infrastructure* - Spring Data Commons provides a metadata model for persisting Java classes and technology neutral repository interfaces. Provides capabilities to the other Spring Data projects.
- *Removes DAO implementations* - JPA implementations use the *data access object* (DAO) pattern and Speing Data JPA makes it possible to fully remove DAO implementations, to have code shorter
- *Automatic class creation* - Spring Data JPA will automatically create an implementation for the JpaRepository interface
- *Generated queries* - You may define a method on your repository interface following a naming pattern
- *Close to the database if needed* - Spring Data JDBC can communicate directly with the database and avoid the "magic" of Spring Data JPA. Allows you to interact with the database through JDBC, but it removes the boilerplate code by using the Spring framework facilities.

A Java persistence project can be implemented using three alternatives: **JPA, native Hibernate, and Spring Data JPA**.

**Spring Data JPA always requires a JPA provider** such as Hibernate or Eclipse Link.

- Using JPA, you can implement the configuration and bootstrapping of a persistence unit, and you can create the EntityManagerFactory entry point.
- You can call the EntityManager to interact with the database, storing and loading an instance of the persistent domain model class.
- Native Hibernate provides bootstrapping and configuration options, as well as the equivalent basic Hibernate APIs: SessionFactory and Session.
- You can switch between the JPA approach and Hibernate approach by unwrap- ping a SessionFactory from an EntityManagerFactory or obtaining an EntityManagerFactory from a Hibernate configuration.
- You can implement the configuration of a Spring Data JPA application by creating the repository interface, and then use it to store and load an instance of the persistent domain model class.
- Spring Data JPA is much slower, compared to JPA and native Hibernate when number of records increases



#### Hibernate n+1 problem 

Original [here](https://habr.com/ru/companies/otus/articles/529692/).

With JPA and Hibernate there are few ways to obtain it:

1. By default @ManyToOne and @OneToOne uses `FetchType.EAGER` by default, so when do not fetch element with explicit joins we will get n+1

   > Solutions:
   >
   > 1) Use `FetchType.LAZY` if you don't need some relation (that is annotated with @ManyToOne or @OneToOne)
   > 2) If you still need then in JPQL query use JOIN FETCH

2. Even if use Lazy loading (`FetchType.LAZY`) still may get n+1 if try to access those lazy fields from ORM object in Java code: 
   ```java
   comment.getPost().getTitle()
   // Post object was lazy, get n+1 after this 
   ```

3. When using @OneToOne with `FetchType.LAZY` we may get n+1 

   > While the unidirectional `@OneToOne` association can be fetched lazily, the parent-side of a bidirectional `@OneToOne` association is not. Even when specifying that the association is not `optional` and we have the `FetchType.LAZY`, the parent-side association behaves like a `FetchType.EAGER` relationship. And [EAGER fetching is bad](https://vladmihalcea.com/eager-fetching-is-a-code-smell/).
   >
   > More [here](https://vladmihalcea.com/the-best-way-to-map-a-onetoone-relationship-with-jpa-and-hibernate/).
   >
   > *...For every managed entity, the Persistence Context requires both the entity type and the identifier,*
   > *so the child identifier must be known when loading the parent entity, and the only way to find the associated `post_details` primary key is to execute a secondary query.*
   >
   > The best way to map a `@OneToOne` relationship is to use `@MapsId`.  This way, the `id` property serves as both Primary Key and Foreign Key.

4. Want to query the data and retreive it from second level cache, but it's not there, so fetch every item one by one.