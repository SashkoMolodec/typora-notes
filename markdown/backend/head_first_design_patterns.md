## Head First Design Patterns

[:arrow_backward:](backend_index)

[toc]

### Strategy pattern

**Strategy** - defines a family of algorithms, encapsulates each one, and makes them interchangeable. Strategy lets the algorithm vary independently from clients that use it.

>  NEW OO Principles:
>
> - Encapsulate what varies
> - Favor composition over inheritance
> - Program to interface, not implementations

<img src="./../../src/img/backend/head_first_patterns/1.png" alt="image-20221223222421961" style="zoom: 33%;" />



### Observable pattern

**Observable** - defines a one-to-many dependency between objects so that when one objects changes state, all its dependencies are notified and updated automatically.

> New OO Principle:
>
> - Strive for loosely coupled designs between objects that interact

When two objects are *loosely coupled*, they can interact, but they typically have very little knowledge of each other. How it implements in Observable pattern:

- First, the only thing the **subject** knows about an **observer** is that it implements a certain interface
- We can add new observers at any time. Because the only thing the subject depends on is a list of objects that implement the Observer interface, we can add new observers whenever we want.
- We never need to modify the subject to add new types of observers.
- We can reuse subjects or observers independently of each other.
- Changes to either the subject or an observer will not affect the other.

<img src="./../../src/img/backend/head_first_patterns/2.png" alt="image-20221223221813303" style="zoom: 33%;" />



### Decorator pattern

**Decorator** - Attach additional responsibilities to an object *dynamically*. Decorators provide a flexible alternative to subclassing for extending functionality. 

> NEW OO Principle:
>
> - Classes should be open for extension, but closed for modification

An abstract example:

<img src="./../../src/img/backend/head_first_patterns/3.png" alt="image-20221223222958891" style="zoom:50%;" />

Pitfalls:

- If you have **code that relies on the concrete component’s** type, decorators will break that code. As long as you only write code against the abstract component type, the use of decorators will remain transparent to your code. However, once you start writing code against concrete components, you’ll want to rethink your application design and your use of decorators.
- A lot of small classes, can be too much (like in java.io classes)
- The complexity creating needed component. Once you’ve got decorators, you’ve got to not only instantiate the component, but also wrap it with who knows how many decorators.

<img src="./../../src/img/backend/head_first_patterns/4.png" alt="image-20221223201410933" style="zoom:50%;" />



### Factory pattern

**The Factory Method Pattern** defines an interface for creating an object, but lets subclasses decide which class to instantiate. Factory Method lets a class defer instantiation to subclasses.

> New OO Principle:
>
> - **Dependency inversion principle**
>   Depend upon abstractions. Do not depend upon concrete classes. 
>   High-level components should not depend on our low-level components; rather, they should both depend on abstractions.
>   *Inversion* here works in the way that not only high-level component will depend from abstractions, but the low-level would also depend on abstractions.
>   <img src="./../../src/img/backend/head_first_patterns/5.png" alt="image-20221224175334148" style="zoom:33%;" />
>
> To avoid OO designs that violate Dependency Inversion:
>
> - No variable should hold a reference to a concrete class (If you use new, you’ll be holding a reference to a concrete class. Use a factory to get around that!)
> - No class should derive from a concrete class (If you derive from a concrete class, you’re depending on a concrete class. Derive from an abstraction, like an interface or an abstract class)
> - No method should override an implemented method of any of its base classes (If you override an implemented method, then your base class wasn’t really an abstraction to start with. Those methods implemented in the base class are meant to be shared by all your subclasses)

An example:

<img src="./../../src/img/backend/head_first_patterns/6.png" alt="image-20221224173009964" style="zoom: 40%;" />

<img src="./../../src/img/backend/head_first_patterns/7.png" alt="image-20221223232715185" style="zoom: 40%;" />

**The Abstract Factory Pattern** provides an interface for creating families of related or dependent objects without specifying their concrete classes.

<img src="./../../src/img/backend/head_first_patterns/8.png" alt="image-20221224183746708" style="zoom:40%;" />

Abstract Factory vs Factory method vs Simple Factory:

- Simple Factory, while not a bona fide design pattern, is a simple way to decouple your clients from concrete classes.

- Factory Method relies on inheritance: object creation is delegated to subclasses, which implement the factory method to create objects.

  The intent of Factory Method is to allow a class to defer instantiation to its subclasses.

- Abstract Factory relies on object composition: object creation is implemented in methods exposed in the factory interface.

  The intent of Abstract Factory is to create families of related objects without having to depend on their concrete classes.



### Singleton Pattern

**The Singleton Pattern** ensures a class has only one instance, and provides a global point of access to it.



### Command Pattern

**The Command Pattern** encapsulates a request as an object, thereby letting you parametrize clients with different requests, queue or log requests, and support undoable operations.

<img src="./../../src/img/backend/head_first_patterns/9.png" alt="image-20221230010711489" style="zoom:40%;" />

<img src="./../../src/img/backend/head_first_patterns/10.png" alt="image-20221230020011151" style="zoom:40%;" />

- A Command object is at the center of this decoupling (receiver from invoker) and encapsulates a receiver with an action (or set of actions)
- An invoker makes a request of a Command object by calling its execute() method, which invokes those actions on the receiver
- Invokers can be parametrized with Commands, even dynamically at runtime
- In practice, it's not uncommon for "smart" Command objects to implement the request themselves rather than delegating to a receiver
- Commands may also be used to implement logging and transactional systems, threads



### The Adapter and Facade Patterns 

**The Adapter** pattern converts the interface of a class into another interface clients expect. Lets classes work together that couldn't otherwise because of incompatible interfaces.

- **Object adapter** that uses *composition*:

<img src="./../../src/img/backend/head_first_patterns/11.png" alt="image-20230102222819903" style="zoom:33%;" />

<img src="./../../src/img/backend/head_first_patterns/12.png" alt="image-20230102223059660" style="zoom:40%;" />

Real world Java API example:  

<img src="./../../src/img/backend/head_first_patterns/13.png" alt="image-20230102223258350" style="zoom:42%;" />

> Enumeration is used in legacy classes like Vector, Hashtable

- **Class adapter** that uses *multiple inheritance* :

  <img src="./../../src/img/backend/head_first_patterns/14.png" alt="image-20230102222935130" style="zoom:41%;" />

> New OO Principle:
>
> **Principle of Lease Knowledge** : Talk only to your friends
> The principle guides us to reduce the interactions between objects to just a few close "friends". It prevents us from creating designs that have a large number of classes coupled together so that changes in one part of the system cascade to other parts. If there are a lot of dependencies between many classes, it would be a fragile system that is hard to maintain.
>
> Guidelines for this:
>
> Inside any method of some object, invoke only methods that belong to:
>
> - The object itself
> - Objects passes in as a parameter to the method
> - Any object the method creates or instantiates
> - Any components of the object
>
> And do not call methods on objects that were returned from calling other methods!!



**The Facade Pattern** provides a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use.

<img src="./../../src/img/backend/head_first_patterns/15.png" alt="image-20230102223610731" style="zoom:45%;" />

<img src="./../../src/img/backend/head_first_patterns/16.png" alt="image-20230102224225036" style="zoom:55%;" />



### The Template Method Pattern

**The Template Method Pattern** defines the skeleton of an algorithm in a method, deferring some steps to subclasses. Template Method lets subclasses redefine certain steps of an algorithm without changing the algorithm's structure.

> New OO Principle:
>
> **The Hollywood Principle**: Don't call us, we'll call you.
>
> With the Hollywood Principle. we allow low-level components to hook themselves into the system, but the high-level components determine then they are needed, and how. High-level components give the low-level components the "don't call us, we'll call you" treatment. 
>
> <img src="./../../src/img/backend/head_first_patterns/17.png" alt="image-20230105170550838" style="zoom:45%;" />
>
> <img src="./../../src/img/backend/head_first_patterns/19.png" alt="image-20230105170617661" style="zoom:45%;" />

 

An abstract example:

<img src="./../../src/img/backend/head_first_patterns/18.png" alt="image-20230105170044285" style="zoom:48%;" />

Usage of hook:

<img src="./../../src/img/backend/head_first_patterns/20.png" alt="image-20230105170218251" style="zoom:48%;" />



Array sorting using the Template pattern with *composing* (in example Comparable) but not *inheritance*:

<img src="./../../src/img/backend/head_first_patterns/21.png" alt="image-20230105171023307" style="zoom:45%;" />

- We'll need to have our object to implement Comparable in order to complete the algorithm in mergeSort()
- It's a composition, because we are using the Arrays object to sort our array 
- That's similar to Strategy, but with the Strategy the class that we compose with, implements the entire algorithm. The algorithm that Arrays implements for sort() is incomplete: it needs a class to implement compareTo() method, so more like a Template



### The Iterator Pattern

**The Iterator Pattern** provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.

It also places the task of traversal on the iterator object, not on the aggregate (object that we traverse), which simplifies the aggregate interface and implementation, and places the responsibility where it should be.

> New OO Principle: 
>
> A class should have only one reason to change.
>
> - We say that a module or class has **high cohesion** when it is designed around a set of related functions, and we say it has **low cohesion** when it is designed around a set of unrelated functions. 
>
> - Cohesion is a more general concept that SRP (Single Responsibility), but are closely related. Classes that adhere to the principle tend to have high cohesion that take on multiple responsibilities and have low cohesion.
> - Every responsibility of a class is an area of potential change. More than one responsibility means more than one area of change. Need to keep each class to a single responsibility.

<img src="./../../src/img/backend/head_first_patterns/22.png" alt="image-20230109193741678" style="zoom:45%;" />



>  The **Iterable** interface provides a means of getting an iterator and enables Java enhanced for loop.
>
> <img src="./../../src/img/backend/head_first_patterns/23.png" alt="image-20230109195130466" style="zoom:47%;" />



### The Composite Pattern

**The Composite Pattern** allows you to compose objects into tree structures to represent part-whole hierarches. Composite lets clients treat individual objects and compositions of objects uniformly. 

Using a composite structure, we can apply the same operations over both composites and individual objects. In other words, in most cases we can <u>ignore</u> the differences between compositions of objects and individual objects. 

<img src="./../../src/img/backend/head_first_patterns/24.png" alt="image-20230109195942348" style="zoom: 49%;" />

An implementation example. We want to print the whole menu, that consists of submenus (Pancake, Diner, Cafe) and subsub (Dessert):

<img src="./../../src/img/backend/head_first_patterns/25.png" alt="image-20230109200810152" style="zoom:50%;" />

<img src="./../../src/img/backend/head_first_patterns/26.png" alt="image-20230109200041228" style="zoom:50%;" />

<img src="./../../src/img/backend/head_first_patterns/27.png" alt="image-20230109200607334" style="zoom:47%;" />

> - MenuComponent abstract class throws UnsuportedOperationException in all methods. When implementing the class we override only methods we need.
> - When composite reaches leaf recursion ends.

We could say that we are violating the SRP because The Composite Pattern manages a hierarchy AND it performs operations related to Menus. We trade it for *transparency*. By allowing the Component interface to contain the child management operations *and* the leaf operations, a client can treat both composites and leaves uniformly. 

We still may loose a bit of *safety*, because of some unexpected method calls. Can resolve this by separating interfaces, so inappropriate method calls would be handled at compile time. But in that case we need to use instanceof's and conditionals, that breaks transparency. 
