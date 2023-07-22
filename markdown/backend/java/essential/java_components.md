### 🆅  Java Environment Components

[:arrow_backward:](../../backend_index)

[toc]

#### JDK

The Java Development Kit (JDK) contains the minimum software to do Java development. Key pieces:

- compiler (javac), which converts .java files to .class files
- launcher java, which creates the virtual machine and executes program
- archiver (jar) command, which can package files together
- API documentation (javadoc) command for generating documentation

The javac program generates instructions in a *bytecode* format. Then java launches the Java Virtual Machine (JVM) and runs .class files.

> In previous version of Java, you could download a Java Runtime Environment (JRE) instead of the full JDK. JRE was used only for running a program. In Java 11, the JRE is no longer available as a stand-alone download.



#### Compiling & executing

To compile and execute code:

```java
javac Zoo.java
java Zoo
```

Starting from Java 11 we can achieve it with one line of code:

```
java Zoo.java
```

This feature is called *single-file-source-code*. The name tells that it can be used only if the program is one file. If two .java files then still need to use javac. Apart from that, this type of compiling/executing is in memory so no .class file is created.

To compile many files with directories/subdirectories we use paths and wildcards: 

```
javac dir1/*.java dir2/*.java dir3/dir4/*.java dir3/dir5/*.java dir6/*src/*.java
```

To run with packages:

```
java -cp classes packageb.ClassB
java -classpath classes packageb.ClassB
java --class-path classes packageb.ClassB
```

##### Compiling with JAR files

>  JAR - Java archive, zip file of mainly Java class files. 

On Windows:

```
java -cp ".;C:\temp\someOtherLocation;c:\temp\myJar.jar"
myPackage.MyClass
```

- the period (.) indicates you want to include the current directory in the classpath
- we separate parts of the classpath with semicolons (;)

##### Create a JAR file

In current directory:

```
jar -cvf myNewFile.jar .
jar --create --verbose --file myNewFile.jar .
```



#### psvm

- A nonstatic `main()` method is invisible from the point of view of the JVM so it throws an exception



