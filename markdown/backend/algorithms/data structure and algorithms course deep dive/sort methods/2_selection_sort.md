## Selection Sort

[:arrow_backward:](../../algorithms_index)

- In-place algorithm
- O($n^2$) time complexity;
- Doesn't require as much swapping as bubble sort;
- Unstable algorithm;



##### Algorithm in action:

<video controls src="../../../../../src/video/selection_sort_in_action.mp4"></video>

##### Implementation:

```java
import java.util.Arrays;

public class SelectionSort {

    public static void main(String[] args) {

        int[] intArray = {20, 35, -15, 7, 55, 1, -22};

        for (int lastUnsortedIndex = intArray.length - 1; lastUnsortedIndex > 0; lastUnsortedIndex--) {
            int maxIndex = 0;
            for (int i = 1; i <= lastUnsortedIndex; i++) {
                if (intArray[maxIndex] < intArray[i]) {
                    maxIndex = i;
                }
            }
            swap(intArray, maxIndex, lastUnsortedIndex);
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

