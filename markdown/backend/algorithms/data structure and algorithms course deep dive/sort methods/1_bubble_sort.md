## Bubble Sort

[:arrow_backward:](../../algorithms_index)

- In-place algorithm (logically partitioning without a need to create new arrays);

- O($n^2$) time complexity  (e.g. 100 steps to sort 10 items);

- Algorithm degrades quickly.

  

##### Algorithm in action:

<video controls src="../../../../../src/video/bubble_sort_in_action.mp4"></video>

##### Implementation:

```java
import java.util.Arrays;

public class BubbleSort {
    public static void main(String[] args) {

        int[] intArray = {20, 35, -15, 7, 55, 1, -22};

        for (int lastUnsortedIndex = intArray.length - 1; lastUnsortedIndex > 0; lastUnsortedIndex--) {
            for (int i = 0; i < lastUnsortedIndex; i++) {
                if (intArray[i] > intArray[i + 1]) {
                    swap(intArray, i, i + 1);
                }
            }
        }
        System.out.println(Arrays.toString(intArray));

    }

    public static void swap(int[] array, int i, int j) {
        if (i == j) return;
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}
```