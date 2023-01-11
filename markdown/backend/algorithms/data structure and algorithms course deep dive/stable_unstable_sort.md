## Stable vs Unstable sort

[:arrow_backward:](../algorithms_index)

If a sort is unstable then the relative order of duplicate items will not be preserved:

<img src="../../../../src/img/algorithms/unstable_sort_9.png" alt="unstable_sort_9" style="zoom: 33%;" />

"Black" 9 is now before "white" 9 as on picture above. In case of stable sort the relative order won't change:

<img src="../../../../src/img/algorithms/stable_sort_9.png" alt="stable_sort_9" style="zoom:33%;" />



##### Stable Bubble sort

The Bubble sort we have implemented has a special check for duplicate values in `swap` method: `if (i == j) return;`
So this algorithm is stable.
