## Binary Search

[:arrow_backward:](../algorithms_index)

- Data must be sorted
- O($\log n$) - keeps dividing the array in half
- Chooses the element in the middle of the array and compares it against the search value (if equal then we're done, if greater then search the left half of array, if less then search the right half)



##### Implementation:

```java
package search;

public class BinarySearch {

    public static void main(String[] args) {

        int[] intArray = {-22, -15, 1, 7, 20, 35, 55};

        System.out.println(iterativeBinarySearch(intArray, -15));
        System.out.println(recursiveBinarySearch(intArray, 35, 0, intArray.length));
    }

    public static int iterativeBinarySearch(int[] input, int value) {
        int start = 0;
        int end = input.length;

        while (start < end) {
            int midpoint = (start + end) / 2;
            if (input[midpoint] == value) {
                return midpoint;
            }
            // search right part of the array
            else if (input[midpoint] < value) {
                start = midpoint + 1;
                // left part
            } else {
                end = midpoint;
            }
        }
        return -1;
    }

    // {-22, -15, 1, 7, 20, 35, 55} want to find 35
    public static int recursiveBinarySearch(int[] input, int value, int start, int end) {
        if (start >= end) {
            return -1;
        }
        int midpoint = (start + end) / 2;

        if (input[midpoint] == value) {
            return midpoint;
        } else if (input[midpoint] < value) {
            return recursiveBinarySearch(input, value, midpoint + 1, end);
        } else {
            return recursiveBinarySearch(input, value, start, midpoint);
        }
    }
}
```