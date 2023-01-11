## Modern Java in Action

[:arrow_backward:](java_index)

#### Functional programming vs Imperative 

No shared mutable data and the ability to pass methods to functions-code-to other methods are the cornerstones of what's described as *functional programming*.

In the imperative programming you typically describe a program in terms of a sequence of statements that mutate state.



#### Function as a new value

Java 8 adds functions as new forms of value. Why do we need this? 

To help answer this, we’ll note that the whole point of a programming language is to manipulate values, which, following historical programming-language tradition, are therefore called first-class values (or citizens, in the terminology borrowed from the 1960s civil rights movement in the United States). Other structures in our programming languages, which perhaps help us express the structure of values but which can’t be passed around during program execution, are second-class citizens. Values as listed previously are first-class Java citizens, but various other Java concepts, such as methods and classes, exemplify second-class citizens. Methods are fine when used to define classes, which in turn may be instantiated to produce values, but neither are values themselves. Does this matter? Yes, it turns out that being able to pass methods around at runtime, and hence making them first-class citizens, is useful in programming, so the Java 8 designers added the ability to express this directly in Java.



#### Passing code with behavior parameterization

*Behaviour parametrization* means the ability to tell a method to *take* multiple behaviors as parameters and use them internally to accomplish different behaviors.

**Since Java 8 introduced lambdas** (finally), it is now possible to parameterize method’s behavior with anonymous functions.

> Passing behavior as a parameter can help relieve the pain of change.



> The signature of the abstract method of a functional interface is called a *function descriptor*.



#### Restrictions on local variables for stream

Instance variables are stored on the heap, whereas local variables live on the stack. If a lambda could access the local variable directly and the lambda was used in a thread, then the thread using the lambda could try to access the variable after the thread that allocated the variable had deallocated it. Hence, Java implements access to a free local variable as access to a copy of it, rather than access to the original variable.



### Code examples

Sort using *comparing*

```java
Comparator<Apple> c = Comparator.comparing((Apple a) -> a.getWeight());

import static java.util.Comparator.comparing;
inventory.sort(comparing(apple -> apple.getWeight()));
```

Composing stuff

```java
Predicate<Apple> redAndHeavyAppleOrGreen = redApple
    .and(apple -> apple.getWeight() > 150)
    .or(apple -> GREEN.equals(a.getColor()));

Function<String, String> addHeader = Letter::addHeader;
Function<String, String> transformationPipeline = addHeader
    .andThen(Letter::checkSpelling)
    .andThen(Letter::addFooter);
```

Slicing using a predicate (Java 9 feature)

```java
// stop once you found a dish that is greater than (or equal to) 320 calories
List<Dish> slicedMenu1 = specialMenu.stream()
    .takeWhile(dish -> dish.getCalories() < 320)
    .collect(toList());

// finding the elements that have greater than 320 calories
List<Dish> slicedMenu2 = specialMenu.stream()
    .dropWhile(dish -> dish.getCalories() < 320)
    .collect(toList());
```



### Streams

Stream is a sequence of elements from a source that supports data-processing operations.

- *Sequence of elements*—Like a collection, a stream provides an interface to a sequenced set of values of a specific element type. Collections are about data; streams are about computations.
- *Source*—Streams consume from a data-providing source such as collections,
  arrays, or I/O resources.
- *Data-processing operations*—Streams support database-like operations and common
  operations from functional programming languages to manipulate data,
  such as filter, map, reduce, find, match, sort, and so on.



#### External vs internal iteration

Using the Collection interface requires iteration to be done by the user (for example, using for-each); this is called *external iteration*. The Streams library, by contrast, uses *internal iteration*—it does the iteration for you and takes care of storing the resulting stream value somewhere.



#### Using flatMap

How could you return a list of all the unique characters for a list of words? For example, given the list of words ["Hello," "World"] you’d like to return the list ["H," "e," "l," "o," "W," "r," "d"].

```java
List<String> uniqueCharacters =
words.stream()
    .map(word -> word.split("")) // Converts each word into an array of its individual letters
    .flatMap(Arrays::stream) // Flattens each generated stream into a single stream
    .distinct()
    .collect(toList());

//All the separate streams that were generated when using map(Arrays::stream) get amalgamated—flattened into a single stream.
```



#### Reduce

```java
Optional<Integer> min = numbers.stream().reduce(Integer::min); // or max
```



#### Stream operations: stateless vs. stateful

Operations like `map` and `filter` take each element from the input stream and produce zero or one result in the output stream. These operations are in general *stateless*: they don’t have an internal state.

But operations like `reduce`, `sum`, and `max` need to have internal state to accumulate the result. In this case the internal state is small. In our example it consisted of an int or double. The internal state is of *bounded* size no matter how many elements are in the stream being processed.

By contrast, some operations such as `sorted` or `distinct` seem at first to behave like `filter` or `map`—all take a stream and produce another stream (an intermediate operation)—but there’s a crucial difference. Both sorting and removing duplicates from a stream require knowing the previous history to do their job. For example, sorting requires all the elements to be buffered before a single item can be added to the output stream; the storage requirement of the operation is *unbounded*. This can be
problematic if the data stream is large or infinite. We call these operations *stateful* operations.



#### Streams and I/O

> Streams are AutoCloseable so there’s no need for try-finally.

```java
try(Stream<String> lines = Files.lines(Paths.get("data.txt"), Charset.defaultCharset())){ uniqueWords = lines.flatMap(line -> Arrays.stream(line.split(" ")))
    .distinct()
    .count();
}
catch(IOException e){
}
```



#### Fibonacci with streams

```java
Stream.iterate(new int[]{0, 1}, t -> new int[]{t[1], t[0]+t[1]})
    .limit(20)
    .forEach(t -> System.out.println("(" + t[0] + "," + t[1] +")"));
```

