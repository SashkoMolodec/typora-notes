## Counting Sort

[:arrow_backward:](../../algorithms_index)

- O($n$) - can achieve this because we're making assumptions about the data we're sorting
- NOT an in-place algorithm
- Doesn't use comparisons
- Counts the number of occurrences of each value and write the values in sorted order to the input array
- Only works with non-negative discrete values (can't work with floats, strings) and they should be defined within a specific range
- If we want the sort to be stable, we have to do some extra steps



##### Algorithm in action:

<video controls src="../../../../../src/video/counting_sort_in_action.mp4"></video>

##### Implementation:

```java
import java.util.Arrays;

public class CountingSort {

    public static void main(String[] args) {

        int[] intArray = {2, 5, 9, 8, 2, 8, 7, 10, 4, 3};

        countingSort(intArray, 1, 10);

        System.out.println(Arrays.toString(intArray));
    }

    public static void countingSort(int[] input, int min, int max) {

        int[] countArray = new int[(max - min) + 1];

        for (int i=0; i<input.length; i++) {
            // translate if we had 10-20 range elements to zero based (0-10)
            countArray[input[i] - min]++;
        }

        int j = 0;
        for(int i = min; i<=max; i++) {
            while (countArray[i-min] > 0) {
                input[j++] = i;
                countArray[i-min]--;
            }
        }

    }
}
```
