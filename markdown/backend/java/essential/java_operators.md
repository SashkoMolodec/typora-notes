### 🅰 Java operators

[:arrow_backward:](../../backend_index)

[toc]

#### Operator precedence order

Listed below in decreasing order:

| Operator                          | Symbols and examples                               |
| --------------------------------- | -------------------------------------------------- |
| Post-unary                        | expression++, expression--                         |
| Pre-unary                         | ++expression, --expression                         |
| Other unary                       | -. !, ~, +, (type)                                 |
| Multiplication/ division/ modulus | *, /, %                                            |
| Add/ substract                    | +, -                                               |
| Shift                             | <<, >>, >>>                                        |
| Relational                        | <, >, <=, >=, instanceof                           |
| Equal to/not equal to             | ==, !=                                             |
| Local                             | &, ^(XOR), \|                                      |
| Short-circuit logical             | &&, \|\|                                           |
| Ternary                           | boolean expr ? expr1: expr2                        |
| Assignment                        | =, +=, -=, *=, /=, %=, &=, ^=, \|=, <<=, >>=, >>>= |

> XOR is true only if one value is true and the other is false.

##### Compound operators

Apart from just being shorthand, they can save us from having to explicitly cast a value. An example: 

```java
long goat = 10;
int sheep = 5;
sheep = sheep * goat; // DOES NOT COMPILE
```

This could be fixed with adding explicit cast to (int), but there's a better way using the compound assignment operator:

```java
long goat = 10;
int sheep = 5;
sheep *= goat;
```



#### Numeric promotion rules

- If two values have different data types, Java will promote one of the values to the larger of the two data types

- `byte`, `short`, `char` are first promoted to `int` when used with any binary (unary, like ++ is excluded) arithmetic operator, even when there are no `int`'s at all 

  ```java
  short mouse = 10;
  short hamster = 3;
  short capybara = mouse * hamster; // DOES NOT COMPILE
  ```

  

#### Overflow and Underflow

*Overflow* is when a number is so large that it will no longer fit within the data type, so the system "wraps around" to the lowest negative value:

```java
System.out.print(2147483647+1); // -2147483648
```

*Underflow* is when the number is too low to fit in the data type, such as storing -200 in a byte field.

