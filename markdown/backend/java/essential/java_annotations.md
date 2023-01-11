## :exclamation::cat: Annotations

[:arrow_backward:](../../backend_index)

[toc]

Annotations are all about metadata. *Metadata* is data that provides information about other data (e.g. some context). We can assign metadata attributes to classes, variables, and other Java types.

When declaring an annotation, any element without a default value is considered required. With default value an element becomes optional:

```java
public @interface Exercise {
	int hoursPerDay();
	int startHour() default 6;
}
```

- The default value of an annotation must be a non-null constant expression
- An annotation element type must be a:
  - `String`
  - `Class`
  - enum
  - another annotation
  - array of any of these types

- Annotation elements are implicitly abstract and public

- Annotations can include constant variables:

  ```java
  public @interface ElectricitySource {
  	public int voltage();
  	int MIN_VOLTAGE = 2;
  	public static final int MAX_VOLTAGE = 18;
  }
  ```

##### Creating a *value()* element

To achieve something like this

```java
@Injured("Broken Tail") public class Monkey {}
```

we create annotation like this

```java
public @interface Injured {
	String veterinarian() default "unassigned";
	String value() default "foot";
	int age() default 1;
}
```

following several rules:

- annotation must contain an element *value()*, which may be optional or required
- must not contain any other required element
- must not provide values for any other elements



#### @Target

Used to limit some annotation to be applicable to a particular set of types. Takes an array of `ElementType` as its *value()* element. Example values: `TYPE, FIELD, METHOD, PARAMETER, ANNOTATION_TYPE`.



#### @Retention

Annotations may be discarded by the compiler or at runtime (we specify it):

| RetentionPolicy value | Description                                                  |
| --------------------- | ------------------------------------------------------------ |
| SOURCE                | Used only in the source file, discarded by the compiler      |
| CLASS                 | Stored in the .class file but not available at runtime (default compiler behavior) |
| RUNTIME               | Stored in the .class file and available at runtime           |



#### @Inherited

When this annotation is applied to a class, subclasses will inherit the annotation found in the parent class.



#### @Repeatable

Used when want to specify an annotation more than once on a type. Generally, use it when to apply same annotation with different values. Steps for implementing:

1. Define containing annotation type value:

   ```java
   public @interface Risks {
   	Risk[] value();
   }
   ```

2. Specify @Repeatable in @Risk:

   ```java
   @Repeatable(Risks.class)
   public @interface Risk {
   	String danger();
   	int level() default 1;
   }
   ```

3. Use it:

   ```java
   @Risk(danger="Silly")
   @Risk(danger="Aggressive",level=5)
   @Risk(danger="Violent",level=10)
   private Monkey monkey;
   ```

> Prior to Java 8 with @Repeatable annotation, you would have had to use @Risks with @Risk annotation:
>
> ```java
> @Risks({
> 	@Risk(danger="Silly"),
> 	@Risk(danger="Aggressive",level=5),
> 	@Risk(danger="Violent",level=10)
> })
> private Monkey monkey;
> ```



#### @SafeVarags

Marker annotation indicates that method does not perform any potential unsafe operations on its varags parameter ("don't worry about the varags param, I promise everything is fine"). Can be applied only to constructors or method that cannot be overriden. 