### 🅴  Java Exceptions

[:arrow_backward:](../../backend_index)



<img src="../../../../src/img/java/essential/java_exceptions_1.jpg" alt="java_exceptions_1" style="zoom:80%;" />



##### **RuntimeException classes:**

- ArithmeticException

- ArrayIndexOutOfBoundsException

- ClassCastException

- IllegalArgumentException

- NullPointerException

- NumberFormatException

> IllegalArgumentException and NumberFormatException are typically thrown by the programmer, whereas the others are typically thrown by the JVM.

**Checked Exception classes:**

- IOExceptions
- FileNotFoundException

**Error classes:**

- ExceptionInitializerError
- StackoverflowError
- NoClassDefFoundError



#### Try-with-resources

Java includes *try-with-resources* statement to automatically close all resources opened in a try clause. It's also called *automatic resourse management*. An example:

```java
public void readFile(String file) {
	try (FileInputStream is = new FileInputStream("myfile.txt")) {  // Read file data
  	} catch (IOException e) {
 e.printStackTrace();
 	}
 }
```

> Behind the scenes, the compiler replaces a try-with-resources block with `try` and `finally` block. There is still posibility to create own finally block but need to be aware that the implicit (which generates automatically) will be called first.

- One or more resources can be opened in the try clause. They are closed in the *reverse* order from which they were created

  > Java requires classes used in try-with-resources implement the AutoClosable interface, which includes a `void close()` method

- `catch` block is optional

- Resources scope ends on try block (are closed), so you won't be able to use resource object in catch or finally block

