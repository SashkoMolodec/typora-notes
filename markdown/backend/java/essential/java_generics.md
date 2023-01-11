### 🆁 Generics

[:arrow_backward:](../../backend_index)

[toc]

##### Naming conventions for generics

- `E` for an element
- `K` for a map ley
- `V` for a map value
- `N` for a number
- `T` for a generic data type
- `S`, `U`, `V`, and so forth for multiple generics types

##### Type erasure

The compiler replaces all references to `T` in some class with an `Object` type. It allows our code to be compatible with older versions of Java that do not contain generics. The compiler also add the relevant casts.
There are some limitations connected to type erasure. You can't:

- Calling a constructor (`new T()` would be `new Object()`)
- Creating an array of that generic type (at runtime we'll have only `Object`'s)
- Calling `instanceof` (same as previous)
- Using a primitive type as generic (but can use wrappers)
- Creating a static variable as generic (type is linked to the instance of the class)

##### Method with generic 

When you have a method declare a generic parameter type, it is independent of the class generics. Everything is cool with the next example:

```java
public class Crate<T> {
	public <T> T tricky(T t) {
		return t;
	}
}

public static String createName() {
	Crate<Robot> crate = new Crate<>();
		return crate.tricky("bot");
}
```



#### Bounding Generic types

A *wiildcard generic type* is represented with a `?`. Types of bounds:

| Type                         | Syntax         | Example                                                      |
| ---------------------------- | -------------- | ------------------------------------------------------------ |
| Unbounded wildcard           | ?              | List<?> a = new ArrayList<String>();                         |
| Wildcard with an upper bound | ? extends type | List<? extends Exception> a = new ArrayList<RuntimeException>(); |
| Wildcard with a lower bound  | ? super type   | List<? super Exception> a = new ArrayList<Object>();         |

When we work with **upper bounds or unbounded wildcards** the list becomes logically immutable and therefore cannot be modified:

```java
static class Sparrow extends Bird { }
static class Bird { }

public static void main(String[] args) {
	List<? extends Bird> birds = new ArrayList<Bird>();
	birds.add(new Sparrow()); // DOES NOT COMPILE
	birds.add(new Bird()); // DOES NOT COMPILE
}
```

We can't add a Sparrow to List<? extends Bird>, and the next doesn't compile because we can't add a Bird to List<Sparrow>. Both scenarios are equally possible, so neither is allowed.

With a **lower bound**, everything is safe so changing list works:

```java
public static void addSound(List<? super String> list) {
    Object obj = list.get(0); // String won't work
	list.add("quack");
}

List<String> strings = new ArrayList<String>();
strings.add("tweet");
List<Object> objects = new ArrayList<Object>(strings);
addSound(strings);
addSound(objects);
```

We are telling Java that the list will be a list of String objects or a list of some objects that are a superclass of String.

##### Understanding generic supertypes

```java
3: List<? super IOException> exceptions = new ArrayList<Exception>(); // could be List<IOException>, List<Exception> or List<Object>
4: exceptions.add(new Exception()); // DOES NOT COMPILE, we could have a List<IOException> and an Exception wouldn't fit there
5: exceptions.add(new IOException()); // COMPILE
6: exceptions.add(new FileNotFoundException()); // COMPILE, FileNotFoundException extends IOException
```

> Батю добавити в лист синка завжди проблема, бо синок знає чогось більше й батько не знає як треба буде поводитись. А навпаки, синка в батін лист добавити простіше, бо син як правило перейняв все у батька і може поводитись як він.



#### Comparable

- Implement it on object with generics (in older Java needs casting from `Object` class)

- The number 0 is returned when objects are equal
- A negative number is returned when the current object is smaller than the argument
- A positive number is returned when the current object is larger than the argument
- *compareTo()* should be consistent with *equals()*, so when `0` then `true`

#### Comparator

Use it when want to sort object in different ways at different times. An example:

```java
Comparator<Duck> byWeight = (d1, d2) -> d1.getWeight()-d2.getWeight();
```

Can rewrite it using method reference and static `Comparator.comparing()` interface method:

```java
Comparator<Duck> byWeight = Comparator.comparing(Duck::getWeight);
```

Using chaining when sorting by few parameters:

```java
Comparator<Squirrel> c = Comparator.comparing(Squirrel::getSpecies)
    .thenComparingInt(Squirrel::getWeight);
```