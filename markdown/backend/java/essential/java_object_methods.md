## 🅾 Object Methods

[:arrow_backward:](../../backend_index)

[toc]

#### hashCode() 

##### Contract between hashCode() and equals()

- Whenever it is invoked on the same object more than once during an execution of a Java application, the `hashCode()` must consistently return the same integer, provided no information used in `equals` comparisons on the object is modified.
  This integer need not remain consistent between the two executions of the same application or program.

- **If two objects are equal** according to the `equals()` method, then calling the `hashCode()` on each of the **two objects must produce the same integer** result.

- It is **not required that if two objects are unequal** according to the [`equals()`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#equals-java.lang.Object-), then calling the `hashCode()` on each of the **both objects must produce distinct integer** results.
  However, the programmer should be aware that producing distinct integer results for unequal objects may improve the performance of hash tables.

Overriding the `hashCode()` is generally necessary whenever equals() is overridden to maintain the general contract for the `hashCode()` method, which states that **equal objects must have equal hash codes**.

##### Default implementation

We cannot see the implementation in Java code because it is written in C++ and it's part of the JVM, so it's **dependent on it's version**. There is a special function called `get_next_hash` that offers six methods based on the value of some `hashCode` variable:

```
0. A randomly generated number.
1. A function of memory address of the object.
2. A hardcoded 1 (used for sensitivity testing.)
3. A sequence.
4. The memory address of the object, cast to int.
5. Thread state combined with xorshift (https://en.wikipedia.org/wiki/Xorshift)
```

According to OpenJDK 8, 9, it uses `5` option as for default. On previous versions, both OpenJDK 6 and 7 use the `0` method, a random number generator (*Original [link.](https://srvaroa.github.io/jvm/java/openjdk/biased-locking/2017/01/30/hashCode.html)*).

Fifth option, using Marsaglia XOR-Shift algorithm, has nothing to do with memory. You can run VM multiple times and the hashCode will remain the same. This algorithm starts with a seed (always the same, unless some other code does not alter it) and works from that.

##### InteliJ implementation

```java
 @Override
    public int hashCode() {
        int result = str != null ? str.hashCode() : 0;
        result = 31 * result + numb;
        return result;
    }
```

##### Objects from java.util implementation

```java
@Override
    public int hashCode() {
        return Objects.hash(str, numb);
    }
```

```java
public static int hash(Object... values) {
        return Arrays.hashCode(values);
    }
```

```java
public static int hashCode(Object[] a) {
        if (a == null)
            return 0;

        int result = 1;

        for (Object element : a)
            result = 31 * result + (element == null ? 0 : element.hashCode());

        return result;
    }
```



#### equals()

##### InteliJ implementation

```java
@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Test test = (Test) o;

        if (numb != test.numb) return false;
        return str != null ? str.equals(test.str) : test.str == null;
    }
```

##### Objects from java.util implementation

```java
 @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Test test = (Test) o;
        return numb == test.numb && Objects.equals(str, test.str);
    }
```



#### toString()

