## Heap Sort

[:arrow_backward:](../../algorithms_index)

- Time complexity in worst case O(nlogn)
- We know the root has the largest value
- Swap root with last element in the array
- Heapify the tree, but exclude the last node (because it's in correct position)
- After heapify, second largest element is at the root
- Rinse and repeat



##### In action:

<video controls src="../../../../../src/video/heap_sort_in_action.mp4"></video>
