## Stacks

[:arrow_backward:](../algorithms_index)

- Abstract data type
- LIFO - Last in, first out
- push - adds an item as the top item on the stack
- pop - removes the top item on the stack
- peek - gets the top item on the stack without popping it
- Ideal backing data structure: linked list



##### Time Complexity

- O($1$) for push, pop, peek, when using a linked list
- When push with array then O($n$), because the array may have to be resized
- If you know the maximum number of items that will ever be on the stack, an array can be a good choice
- If memory is tight, an array might be a good choice
- Linked list is ideal for stacks



##### Stacks implementation (Array):

```java
import lists.Employee;
import java.util.EmptyStackException;

public class ArrayStack {
    private Employee[] stack;
    private int top;

    public ArrayStack(int capacity) {
        stack = new Employee[capacity];
    }

    public void push(Employee employee) {
        if (top == stack.length) {
            // need to resize the backing array
            Employee[] newArray = new Employee[2 * stack.length];
            System.arraycopy(stack, 0, newArray, 0, stack.length);
            stack = newArray;
        }
        stack[top++] = employee;
    }

    public Employee pop() {
        if (isEmpty()) {
            throw new EmptyStackException();
        }

        Employee employee = stack[--top];
        stack[top] = null;
        return employee;
    }

    public Employee peek() {
        if (isEmpty()) {
            throw new EmptyStackException();
        }
        return stack[top - 1];
    }

    public int size() {
        return top;
    }

    public boolean isEmpty() {
        return top == 0;
    }

    public void printStack() {
        for (int i = top - 1; i >= 0; i--) {
            System.out.println(stack[i]);
        }
    }
}
```

