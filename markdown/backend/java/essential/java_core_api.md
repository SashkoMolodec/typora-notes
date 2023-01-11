### :pray: Java Core API

[:arrow_backward:](../../backend_index)

[toc]

#### String

String and StringBuilder classes are implemented using an *array* of characters (implements CharSequence interface). 

##### String methods

- *length()* returns the number of charecters

- *charAt()* queries the string to find out what charecter is at specific index. It will throw an exception if index is out of bound:

  ```java
  String string = "animals";
  System.out.println(string.charAt(6)); // s
  System.out.println(string.charAt(7)); // throws exception:
  // java.lang.StringIndexOutOfBoundsException: String index out of range: 7
  ```

- *indexOf()* finds the first index that matches desired value, we can pass string or int (we pass as a char); won't throw exception but return -1 can't find a match

- *substring()* returns parts of the string

- *toLowerCase()*, *toUpperCase()*, original string stays the same as strings are immutable

- equals(), equalsIgnoreCase()

- *startsWith()*, *endsWith()*

- *replace()*, we can pass char or String

  ```java
  String replace(char oldChar, char newChar)
  String replace(CharSequence target, CharSequence replacement)
  ```

- *contains()*, accepts CharSequence (regular string)

- *trim()*, *strip()*, *stripLeading()*, and *stripTailing()* are for removing blank spaces:
  - strip() and trim() remove whitespace from the beginning and end of a String (as well removes \t, \n, \r);
  - strip() is new in Java 11, same as trim(), but it supports Unicode (can remove following: `char ch = '\u2000';`)
  - stripLeading() removes whitespace only from the beginning, stripTrailing() method does the opposite

- *intern()* returns the value from the string pool if it is there, otherwise add the value to the string pool

##### String pool

The *string pool*, or *intern pool*, is a location in the JVM that collects all these string. When doing comparison like `"Hello" == "Hello"` it will return true because two literals are pooled, taken from the same location in memory. 
If our String will be defined at runtime then they won't be added to the string pool, so placed in some other location in memory and `==` won't do the job. However, we can fix this problem using *intern()* method:

```java
String name2 = new String("Hello World").intern();
System.out.println(name == name2); // true
```



#### StringBuilder

Unlike the String class, StringBuilder is mutable. When creating it, we can specify capacity:

```java
StringBuilder sb2 = new StringBuilder("animal");
StringBuilder sb3 = new StringBuilder(10);
```

##### StringBuilder methods

- *chartAt()*, *indexOf()*, *length()*, *substring()* works the same as in the String class

- *append()*, *insert()*

- *delete()* is opposite to insert(), *deleteCharAt()* deletes only one charecter

- *replace()*, signature is as follows:

  ```java
  StringBuilder replace(int startIndex, int endIndex, String
  newString)
  ```

  How to use it:

  ```java
  StringBuilder builder = new StringBuilder("pigeon dirty");
  builder.replace(3, 6, "sty");
  System.out.println(builder); // pigsty dirty
  ```

  First it deletes the charecters starting with index 3 and ending right before index 6, then Java inserts to the value "sty" in that position

- *reverse()*, reverses the charecters

- *toString()*

##### StringBuffer

It works the same as StringBuilder except it support threads. But generally, for single thread using StringBuilder is wiser. 

> Whenever an operation occurs like appending or inserting this class **synchronizes** only on the StringBuffer performing the operaition, not on the source.



#### Arrays

More about arrays from the data structures course [here](../../algorithms\data structure and algorithms course deep dive\arrays.md).

**Arrays methods (not all mentioned)**:

- *compare()* is used to determine which array is "smaller". There are several rules:

  - negative number means the first array is smaller than the second
  - zero means the arrays are equal
  - positive number means the first array is larger than the second

  How to compare arrays of different lengths:

  - if both arrays are the same lengths and same values, returns zero
  - if all the elements are the same but the second array has extra elements at the end, returns a negative number; 
    if first array has extra elements then returns a positive number
  - if the first element that differs is smaller in the first array, return a negative number; if larger then returns positive number

  What "smaller" means:

  - null is smaller than any other value
  - For numbers we have normal numeric order
  - For strings: one is smaller by prefixes, numbers are smaller than letters and uppercase is smaller than lowercase

- *mismatch()* returns -1, if the arrays are equal, otherwise it returns the first index where they differ

- *sort()* uses a [Dual-Pivot Quicksort](../../algorithms/data structure and algorithms course deep dive/sort methods/6_quick_sort.md), which offers O(nlog(n)) perfomance on many data sets that cause other quicksorts to degrade to quadratic perfomance, and is typically faster than traditional (one-pivot) Quicksort implementation

##### Backed arrays

When convert ArrayList to an array then changing ArrayList content won't affect array values (because the copy of it is just created). However, **converting an array to ArrayList** means that ArrayList becomes a *backed list* because the array changes with it. Consider an example:

```java
String[] array = { "hawk", "robin" }; // [hawk, robin]
List<String> list = Arrays.asList(array); // returns fixed size list
System.out.println(list.size()); // 2
list.set(1, "test"); // [hawk, test]
array[0] = "new"; // [new, test]
System.out.print(Arrays.toString(array)); // [new, test]
list.remove(1); // throws UnsupportedOperationException
```

We are not allowed to change the size of the list so it throws exception.

##### Sorting implementations

The [Quicksort](../../../backend/algorithms/data structure and algorithms course deep dive/sort methods/6_quick_sort.md) is used by Arrays.sort for sorting primitive collections because stability isn't required (you won't know or care if two identical ints were swapped in the sort).

[MergeSort](../../../backend/algorithms/data structure and algorithms course deep dive/sort methods/5_merge_sort.md) or more specifically Timsort is used by Arrays.sort for sorting **collections of objects**. Stability is required. Quicksort does not provide for stability, Timsort does (offers guaranteed *n log(n)* performance).



#### Wrappers

- Each wrapper has a constructor that works the same as valueOf() but isn't recommended. The valueOf() allows **object caching** (similar to String that could be shared when the value is the same)

- They can be stored as null
- When autoboxing null to some primitive it throws NullPointerException (since calling any method on null throws that exception)