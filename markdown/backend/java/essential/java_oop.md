### 🅵 OOP in Java

[:arrow_backward:](../../backend_index)

[toc]

#### Encapsulation

Encapsulation describes the idea of bundling data and methods within one unit, like a class. This concept is also used to hide the internal representation, or a state of an object from the outside.



#### Inheritance

One of Java's biggest strengths is leveraging its inheritance model to simpify code.

##### Overriding methods

The compiler performs next checks:

1. Same signature.

2. Child class method at least as accesible as the parent method.

3. Child class method may not declare a checked exception that is new or broader than in the parent class method.

4. Must return the same or a subtype of the method in the parent class, known as a *covariant return types*.

5. The method defined in the child class must be marked as static if it is marked as static in a parent class (*hidden method*s). 

   > A *subtype* is the relationship between two types where one type inherits the other. A subclass is a subtype, but not all subtypes are subclasses.

   Example: 

   ```java
   public class Rhino {
   	protected CharSequence getName() {
   		return "rhino";
   	}
   	protected String getColor() {
   		return "grey, black, or white";
   	}
   }
   
   class JavanRhino extends Rhino {
   	public String getName() {
   		return "javan rhino";
   	}
   	public CharSequence getColor() { // DOES NOT COMPILE
   		return "grey";
   	}
   }
   ```

   Not all CharSequence values are String values (more broader) that's why it won't compile. A StringBuilder is a CharSequence but not a String.

##### Hiding variables

Java doesn't allow variables to be overridden. Variables can be hidden. A *hidden* variable occurs when a child class defines a variable with the same name as an inherited parent varaible.



#### Polymorphism

Polymorphism is the property of an object to take on many different forms. Object may be accessed using a reference with the same type as object, a superclass reference, or a reference that defines an interface the object implements.

Once the object has been assigned to a new reference type, only the methods and variables available to that reference type are callable on the object without an explicit cast.

##### Casting

1. Casting a reference from a subtype to a supertype doesn't require an explicit cast.
2. Casting a reference from a supertype to a subtype requires an explicit cast.
3. At runtime, an invalid cast results in ClassCastException.



#### Design Principles

A *design principle* is an established idea or best practice that facilitates the software design process.

- Is-a relationship (inheritance)
- Has-a relationship (composition)

#### Design Patterns

A *design pattern* is an established general solution to a commonly occurring software development problem.

##### Singleton

The *singleton* pattern is a creational pattern focused on creating only one instance of an object in memory within an application, sharable by all classes and threads within the application. The globally available object created by the singleton pattern is referred to as a singleton.

##### Immutable objects

The *immutable object* pattern is a creational pattern based on the idea of creating objects whose state does not change after they are created and can be easily shared  across multiple classes. Immutable objects go hand and hand with encapsulation, except that no setter methods exist that modify the object. Since the state of an immutable object never changes, they are inherently thread‐safe.

> 1. Use a constructor to set all properties of the object.  
> 2. Mark all of the instance variables private and final.
> 3. Don’t define any setter methods.
> 4. Don’t allow referenced mutable objects to be modified or accessed directly.
> 5. Prevent methods from being overridden. 



#### OOD

Original [here](https://betterprogramming.pub/solid-principles-with-almost-real-life-examples-in-java-b292a4e2c18b).

1. Single Responsibility
   Each class should have only one sole purpose, and not be filled with excessive functionality.

2.  Open-Closed Principle

   Classes should be open for extension, closed for modification.
   In other words, you should not have to rewrite an existing class for implementing new features.

3. Liskov-Substitution Principle
   A sub-class should be able to fulfill each feature of its parent class and could be treated as its parent class.

4. Interface Segregation Principle

   Interfaces should not force classes to implement what they can’t do. Large interfaces should be divided into small ones.

5. Dependency Inversion Principle

   Components should depend on abstractions, not on concretions.
