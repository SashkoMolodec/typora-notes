### 🅴 Functional Programming

[:arrow_backward:](../../backend_index)

[toc]

The Java 8 feature of passing code to methods is reffered to as *functional-style programming*. 

##### Lambdas

Code with lambdas uses a concept called *deferred execution*, which means that code is specified now but will run later.

##### Common functional interfaces

| Functional interface | Return type | Method name  |
| -------------------- | ----------- | ------------ |
| Supplier<T>          | T           | get()        |
| Consumer<T>          | void        | accept(T, U) |
| BiConsumer           | void        | accept(T, U) |
| Predicate<T>         | boolean     | test(T)      |
| BiPredicate<T, U>    | boolean     | test(T, U)   |
| Function<T, R>       | R           | apply(T)     |
| BiFunction<T, U, R>  | R           | apply(T, U)  |
| UnaryOperator<T>     | T           | apply(T)     |
| BinaryOperator<T>    | T           | apply(T, T)  |

##### Optional instance methods

| Method                           | When Optional is empty                       | When Optional contains a value |
| -------------------------------- | -------------------------------------------- | ------------------------------ |
| get()                            | Throws an exception                          | Returns value                  |
| ifPresent(Consumer c)            | Does nothing                                 | Calls Consumer with value      |
| isPresent()                      | Returns false                                | Returns true                   |
| orElse(T other)                  | Returns other parameter                      | Returns value                  |
| orElseGet(Supplier s)            | Returns result of calling Supplier           | Returns value                  |
| orElseThrow() - added in Java 10 | Throws NoSuchElementException                | Returns value                  |
| orElseThrow(Supplier s)          | Throws exception created by calling Supplier | Returns value                  |



#### Streams

A *stream* is a sequence of data. A *stream pipeline* consists of the operations that run on a stream to produce result. With streams, data isn't generated up front - it is created when needed (*lazy evaluation*, delays execution unit necessary). Pipelines consist of:

- Source
- Intermediate operations (they won't run until the terminal operation runs)
- Terminal operation (stream ends at that point)



#### Common terminal operations

*Reductions* are a special type of terminal operation where evertyhing from the stream is combined into one object/primitive. 

##### count()s

The method determines number of elements in a finite stream. It is reduction because it looks at each element in the stream and returns a single value.

```java
Stream<String> s = Stream.of("monkey", "gorilla", "bonobo");
System.out.println(s.count()); // 3
```

##### min() and max()

Allows to pass a custom operator and find the smallest or largest value. Also reduction. 

```java
Stream<String> s = Stream.of("monkey", "ape", "bonobo");
Optional<String> min = s.min((s1, s2) -> s1.length()-s2.length());
min.ifPresent(System.out::println); // ape
```

##### findAny() and findFirst()

Return an element of the stream unless the stream is empty. It can terminate with an infinite stream (if to compare with one's above). These methods are terminal operations but not reductions (value returns without processing all of the elements).

```java
Stream<String> s = Stream.of("monkey", "gorilla", "bonobo");
Stream<String> infinite = Stream.generate(() -> "chimp");
s.findAny().ifPresent(System.out::println); // monkey (usually)
infinite.findAny().ifPresent(System.out::println); // chimp
```

##### allMatch(), anyMatch(), and noneMatch()

Find match based on a predicate you pass. These may or may not terminate for infinite streams. Not reduction.

```java
var list = List.of("monkey", "2", "chimp");
Stream<String> infinite = Stream.generate(() -> "chimp");
Predicate<String> pred = x -> Character.isLetter(x.charAt(0));
System.out.println(list.stream().anyMatch(pred)); // true
System.out.println(list.stream().allMatch(pred)); // false
System.out.println(list.stream().noneMatch(pred)); // false
System.out.println(infinite.anyMatch(pred)); // true
```

##### forEach()

Used for iteration, it is the only terminal operation with a return type of `void`.

```java
Stream<String> s = Stream.of("Monkey", "Gorilla", "Bonobo");
s.forEach(System.out::print); // MonkeyGorillaBonobo
```

##### reduce()

Combines a stream into a single object. There are 3 different methods:

```java
T reduce(T identity, BinaryOperator<T> accumulator)

Optional<T> reduce(BinaryOperator<T> accumulator)

<U> U reduce(U identity, BiFunction<U,? super T,U> accumulator,
BinaryOperator<U> combiner)
```

The *identity* is the initial value of the reduction, *accumulator* combines the current result with the current value in the stream. 

```java
Stream<String> stream = Stream.of("w", "o", "l", "f!");
int length = stream.reduce(0, (i, s) -> i+s.length(), (a, b) -> a+b);
System.out.println(length); // 5
```

First param - *initializer*, second is *accumulator* (analyze single stream element, return some value) and last *combiner* which combines any intermediate totals.

> The three-argument reduce() operation is useful when working with parralel streams because it allows the stream to be decomposed and reassembled by separate threads. 
>
> The third method signature is used when we are processing collections in parallel. It allows Java to create intermediate reductions and then combine them at the end.

> Reduce method is meant to combine two values and produce a new one; it’s an immutable reduction. In contrast, the collect method is designed to mutate a container to accumulate the result it’s supposed to produce.

##### collect()

Special type of reduction called a *mutable reduction*, more efficient because we use the same mutable object while accumulating.

```java
Stream<String> stream = Stream.of("w", "o", "l", "f");
TreeSet<String> set = stream.collect(
TreeSet::new,
TreeSet::add,
TreeSet::addAll);
System.out.println(set); // [f, l, o, w]
```

We could rewrite it using **Collectors** class:

```java
Stream<String> stream = Stream.of("w", "o", "l", "f");
TreeSet<String> set = stream.collect(Collectors.toCollection(TreeSet::new));
System.out.println(set); // [f, l, o, w]
```



#### Common intermediate operations

Intermediate operation produces a stream as its result. 

##### filter()

Method returns a Stream with elements that match a given expression.

```java
Stream<String> s = Stream.of("monkey", "gorilla", "bonobo");
s.filter(x -> x.startsWith("m"))
.forEach(System.out::print); // monkey
```

##### distinct()

Returns a stream with removed duplicates. Java calls *equals()* to determine whether the object are the same.

```java
Stream<String> s = Stream.of("duck", "duck", "duck", "goose");
s.distinct()
.forEach(System.out::print); // duckgoose
```

##### limit() and skip()

Can make s Stream smaller, or they could make a finite stream from infinite. 

```java
Stream<Integer> s = Stream.iterate(1, n -> n + 1);
s.skip(5)
.limit(2)
.forEach(System.out::print); // 67
```

##### map()

Mapping through each element and returning it just like map() in js.

```java
Stream<String> s = Stream.of("monkey", "gorilla", "bonobo");
s.map(String::length)
.forEach(System.out::print); // 676
```

##### flatMap()

Takes elements from the stream, create stream from each element and combine them into one stream. Helpful when need to remove empty elements from a stream or combine a stream of lists.

```java
List<String> zero = List.of();
var one = List.of("Bonobo");
var two = List.of("Mama Gorilla", "Baby Gorilla");
Stream<List<String>> animals = Stream.of(zero, one, two);

animals.flatMap(m -> m.stream())
.forEach(System.out::println);
```

Output:

```
Bonobo
Mama Gorilla
Baby Gorilla
```

##### sorted()

Returns a stream with the elements sorted. Uses natural ordering unless we specify a comparator. 

```java
Stream<String> s = Stream.of("brown bear-", "grizzly-");
s.sorted(Comparator.reverseOrder())
.forEach(System.out::print); // grizzly-brown bear-
```

It will do the job with calling a method `Comparator.reverseOrder()` (Comparator implements it, taking two String params and returns an int) but would fail if we used `Comparator::reverseOrder`, because it is method reference to a function that takes zero params and returns a Comparator (not compatible with the interface).

##### peek()

Useful for debugging, because we perform operation without actually changing the stream. It's like *forEach()* but intermediate version.



#### Using Optional with primitive streams

Rather then using Optional<Double> we can use OptionalDouble for returning primitive double, not wrapper Double. There are various methods (get, max, min, sum, average) for each concrete primitive that return specific OptionalDouble, OptionalInt or OptionalLong. Also there are different functional interfaces for primitives. 



#### Collector methods examples

Use a Collector to transform a stream into a traditional collection.

##### groupingBy()

```java
var ohMy = Stream.of("lions", "tigers", "bears");
Map<Integer, List<String>> map = ohMy.collect(
Collectors.groupingBy(String::length));
System.out.println(map); // {5=[lions, bears], 6=[tigers]}
```

##### partitionBy()

```java
var ohMy = Stream.of("lions", "tigers", "bears");
Map<Boolean, List<String>> map = ohMy.collect(
Collectors.partitioningBy(s -> s.length() <= 5));
System.out.println(map); // {false=[tigers], true=[lions, bears]}
```

##### mapping()

Get the first letter of the first animal alphabetically of each length:

```java
var ohMy = Stream.of("lions", "tigers", "bears");
Map<Integer, Optional<Character>> map = ohMy.collect(
	Collectors.groupingBy(
		String::length,
		Collectors.mapping(
			s -> s.charAt(0),
			Collectors.minBy((a, b) -> a -b))));
System.out.println(map); // {5=Optional[b], 6=Optional[t]}
```

