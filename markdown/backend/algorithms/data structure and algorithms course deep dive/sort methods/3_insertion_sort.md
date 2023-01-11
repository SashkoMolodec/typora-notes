## Insertion Sort

[:arrow_backward:](../../algorithms_index)

- In-place algorithm
- O($n^2$) time complexity
- Stable algorithm
- Usually performs about half as many comparisons as selection sort (it only scans as many elements as it needs in order to place the k+1st element)
- If array **is almost sorted** then we might get nearly O($n$)



##### Algorithm in action:

<video controls src="../../../../../src/video/insertion_sort_in_action.mp4"></video>

##### Implementation:

```java
import java.util.Arrays;

public class InsertSort {

    public static void main(String[] args) {

        int[] intArray = {20, 35, -15, 7, 55, 1, -22};

        for (int firstUnsortedIndex = 1; firstUnsortedIndex < intArray.length; firstUnsortedIndex++) {
            int newElement = intArray[firstUnsortedIndex];

            int i;
            for (i = firstUnsortedIndex; i > 0 && intArray[i - 1] > newElement; i--) {
                intArray[i] = intArray[i - 1];
            }
            intArray[i] = newElement;

        }

        System.out.println(Arrays.toString(intArray));
    }
}
```