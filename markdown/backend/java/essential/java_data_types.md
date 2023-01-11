### 🅹 Data types in Java

[:arrow_backward:](../../backend_index)

[toc]

#### Primitive Types

| Keyword | Type                        | Example |
| ------- | --------------------------- | ------- |
| boolean | true or false               | true    |
| byte    | 8-bit integral value        | 123     |
| short   | 16-bit integral value       | 123     |
| int     | 32-bit integral value       | 123     |
| long    | 64-bit integral value       | 123L    |
| float   | 32-bit floating-point value | 123.45f |
| double  | 64-bit floating-point value | 123.456 |
| char    | 16-bit Unicode value        | 'a'     |

- All of the numeric types are signed. It means they reserve on of their bits to cover a negative range. For example, byte ranges from -128 to 127. Not 128 because impossible to put 1 at start to obtain a positive value:

  > 10000000 = -128
  >
  > 011111111 = 127

- primary difference between **short** and **char** is that short is *signed*, which means it splits its range across the positive and negative integers. Alternatively, char is *unsigned*, which means range is strictly positive including 0. So it can hold values from 0 to 255.

##### Number formats:

- *base*, since there 10 numbers (0-9)
- *octal* (digits 0-7), which uses `0` as a prefix (e.g. 017)
- *hexadecimal* (digits 0-9 and letters A-F/a-f), uses `0x` or `0X` as a prefix (e.g. 0xFF, 0xff, 0XFf). it is case insensitive so same values.
- *binary* (0, 1), uses `0` followed by `b` or `B` (0b10, 0B10)



#### Identifiers

- Can begin with a letter, a $ symbol or a _ symbol
- Since Java 9, a single underscore _ is not allowed as identifier, but you can use double underscore



#### Var

Starting in Java 10, there is an option of using keyword var instead of the type for a **local variables**. The formal feature name is *local variable type inference*. 

- for local variable type inference you need to assign value right away because compiler doesn't know what type var should be:

  ```java
  // does not compile
  public void doesThisCompile() {
  	var question;
  	question = 1;
  }
  ```

- Java does not allow var in multiple variable declarations (`var a = 2, b = 3`)

- null is not allowed to be assigned (but actually can be after some concrete assign)

- cannot be used in constructor parameters, method parameters, instance or cl