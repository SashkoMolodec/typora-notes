## Shell Sort

[:arrow_backward:](../../algorithms_index)

- Variation of Insertion sort (doesn't require as much shifting so usually performs better)

- In-place algorithm

- Difficult to define complexity because it will depend on the gap. Worst case: O($n^2$), but it can be much better

- At the beginning the algorithm does some work (using gap > 1), then becomes insertion sort with gap equals 1. By that time the array has been partially sorted, so there's less shifting required 

- Unstable algorithm

  

##### Knuth sequence

Gap is calculated using $(3^k-1)/2$ formula. This calculated value should be as close as possible to the array length, without being greater than it.

| k    | Gap (interval) |
| ---- | -------------- |
| 1    | 1              |
| 2    | 4              |
| 3    | 13             |
| 4    | 40             |

For example we have an array of 20 items so choosing $k=3$ will suit best.

<video controls src="../../../../../src/video/shell_sort_in_action.mp4"></video>

##### Algorithm:

- Calculate the gap (or interval) $k$ (in video we simplified in to $k$ = `array.length` / 2) 
- Shell sort starts out using a larger gap (insertion sort uses gap = 1) value and as the algorithm runs, the gap is reduced

- On each iteration, we'll divide the gap value by 2 
- Do comparison as with usual insertion sort but compare element at interval $k$ (compare `intArray[currentIndex-gap]`)

##### In action:

<video src="../../../../../src/video/shell_sort_in_action.mp4"></video>

##### Implementation:

```java
import java.util.Arrays;

public class ShellSort {

    public static void main(String[] args) {

        int[] intArray = {20, 35, -15, 7, 55, 1, -22};

        for (int gap = intArray.length / 2; gap > 0; gap /= 2) {

            for (int i = gap; i < intArray.length; i++) {
                int newElement = intArray[i];

                int j = i;
                while (j >= gap && intArray[j - gap] > newElement) {
                    intArray[j] = intArray[j - gap];
                    j -= gap;
                }
                intArray[j] = newElement;

            }
        }
        System.out.println(Arrays.toString(intArray));
    }
}
```

