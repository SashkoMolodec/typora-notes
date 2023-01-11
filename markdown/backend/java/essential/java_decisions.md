### 🅰 Java Making Decisions

[:arrow_backward:](../../backend_index)

[toc]

#### Switch Control Flow

Supported data types:

- int and Integer
- byte and Byte
- short and Short
- char and Charecter
- String
- enum values
- var

boolean, long, float, double and their wrappers are not supported by switch statements.

```java
final int getCookies() { return 4; }
void feedAnimals() {
	final int bananas = 1;
	int apples = 2;
	int numberOfAnimals = 3;
	final int cookies = getCookies();
	switch (numberOfAnimals) {
		case bananas:
		case apples: // DOES NOT COMPILES
		case getCookies(): // DOES NOT COMPILE
		case cookies : // DOES NOT COMPILE
		case 3 * 5 :
	}
}
```

The `bananas` variable is marked final, and its value is known at compile time, so it is valid. The `apples` variable is not constant, so it is not permitted. The next two case statememnts with `getCookies()` and `cookies` do not compile because methods are not evaluated until runtime. The last case compiles, as expressions are allowed as case values. 
**Wrappers are not constants** so we can't put the in case statements. 

> My thoughts about an inability to put non-constants in case statements is because at compile time we don't know what method result should be and we can easily end up with identical cases, which is bad.



#### Do/while, while

- Use a while loop when the code will execute zero or more times
- Use a do/while loop when the code will execute one or more times



#### For loops

##### Optional labels

A label is an optional pointer to the head of a statement that allows the app flow to manage for loop, like continuing or break from it:

```java
int[][] myComplexArray = { {5,2,1,3},{3,9,8,9},{5,7,12,7} };
OUTER_LOOP: for(int[] mySimpleArray : myComplexArray) {
	INNER_LOOP: for(int i=0; i<mySimpleArray.length; i++) {
		System.out.print(mySimpleArray[i]+"\t");
	}
	System.out.println();
}
```

