## Merge Sort

[:arrow_backward:](../../algorithms_index)

- Divide and conquer algorithm (NOT an in-place)

- O($nlogn$) time complexity

- Recursive algorithm

- Two phases: **splitting** and **merging**

- Stable algorithm

- Splitting is logical. We don't create new arrays

  

##### Splitting phase

- Divide the unsorted array into 2 parts (left array and right)
- Split the left and right arrays into two arrays each and recursively do this until arrays with one element each - they will be sorted

<video src="../../../../../src/video/merge_sort_in_action_1.mp4"></video>

##### Merging phase

- Merge every left/right pair of sibling arrays into sorted array recursively until we'll have a single sorted array
- Set `i` to the first index of the left array, and `j` to the first index of the right array; compare left[i] to right[j] and if left is smaller, we add it to the temp array and increment `i`. if right is smaller, we add it to the temp array and increment `j`

<video src="../../../../../src/video/merge_sort_in_action_2.mp4"></video>

##### Implementation:

```java
import java.util.Arrays;

public class MergeSort {

    public static void main(String[] args) {

        int[] intArray = {20, 35, -15, 7, 55, 1, -22};

        mergeSort(intArray, 0, intArray.length);

        System.out.println(Arrays.toString(intArray));
    }

    public static void mergeSort(int[] input, int start, int end) {
        if (end - start < 2) {
            return;
        }

        int mid = (start + end) / 2;
        mergeSort(input, start, mid);
        mergeSort(input, mid, end);
        merge(input, start, mid, end);
    }

    private static void merge(int[] input, int start, int mid, int end) {
        // if the last element in the left partition is smaller than first in the right
        // then we ended because left and right partitions are sorted
        if (input[mid - 1] <= input[mid]) {
            return;
        }

        int i = start;
        int j = mid;
        int tempIndex = 0;

        int[] temp = new int[end - start];
        while (i < mid && j < end) {
            temp[tempIndex++] = input[i] <= input[j] ? input[i++] : input[j++];
        }
        // if we have left some elements in the right array then we can leave them
        // because everything in the right is greater than in sorted temp array,
        // and when overriding temp over original the remaining (that we
        // didn't include in temp array) will stay untouched which is correct
        // { 32, 34 }, { 33, 36 } unsorted -> 36 at index = 3 in orig array
        // { 32, 33, 34, 36} sorted -> 36 at index = 3 when sorted.

        // but it won't work in case with remaining elements from left array, so we
        // need to copy them to original input array at the end after temp array.
        // {7, 55}, {1, -22}
        // after while iterations we have {-22, 1, 7} and we need to add 55 at the end,
        // but we won't add this element to temp array but rather c original input for
        // better optimization.
        System.arraycopy(input, i, input, start + tempIndex, mid - i);

        // copy sorted temp array over input array
        System.arraycopy(temp, 0, input, start, tempIndex);
    }
}
```
