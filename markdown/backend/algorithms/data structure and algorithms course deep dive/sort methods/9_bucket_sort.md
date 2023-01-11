## Bucket Sort

[:arrow_backward:](../../algorithms_index)

- Uses hashing
- Makes assumptions about the data, that's why can sort in O($n$) time 
- Performs best when hashed values of items being sorted are evenly distributed, so there aren't many collisions (so we could reach O($n$))
- Not in-place
- Stability will depend on sort algorithm used to sot the buckets - ideally, we want stable sort
- Insertion sort if often used to sort the buckets, because it is fast when the number of items is small

##### Algorithm:

- Distribute the items into buckets based on their hashed values (scattering phase)
- Sort the items in each bucket
- Merge the buckets - concatenate them (gathering phase)
  Important note: the values in bucket X must be greater than the values in bucket X-1 and less than the values in bucket X+1

##### In action:

<video src="../../../../../src/video/bucket_sort_in_action.mp4"></video>

##### Implementation:

```java
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class BucketSort {
    public static void main(String[] args) {
        int[] intArray = {54, 46, 83, 66, 95, 92, 43};

        bucketSort(intArray);

    }

    private static void bucketSort(int[] input) {
        List<Integer>[] buckets = new List[10];
        for (int i = 0; i < buckets.length; i++) {
            buckets[i] = new ArrayList<Integer>();
        }

        // scattering phase
        for (int i = 0; i < input.length; i++) {
            buckets[hash(input[i])].add(input[i]);
        }

        // sorting
        for (List bucket : buckets) {
            Collections.sort(bucket);
        }

        // gathering
        int j = 0;
        for (int i = 0; i < buckets.length; i++) {
            for (int value : buckets[i]) {
                input[j++] = value;
            }
        }
    }

    private static int hash(int value) {
        return value / (int) 10;
    }
}
```