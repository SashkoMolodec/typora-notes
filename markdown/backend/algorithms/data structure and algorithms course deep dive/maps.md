## Maps

[:arrow_backward:](../algorithms_index)

Maps do not exactly store single elements as do other collections but rather a collection of key-value pairs. *Map* interface doesn't extends *Collection* interface.

[toc]

Simple implementation in Java can be found [here](https://github.com/SashkoMolodec/algorithms_java/blob/master/src/hashtables/SimpleHashtable.java).

### HashMap

* **Two unequal objects** in Java can have the **same hash code**
* Adoesllows to have *null* as a key and as a value (it becomes the first element of the underlying array) + no hashing operation
* For the map to work properly, we need to implement `equals()` and `hashCode()` for a class that is key 
* Collision occurs when more than one value has the same hash (values will be stored in a same bucket)
* Hash maps store both key and value in the bucket location as a *Map.Entry* object
* During a *put* operation, when we use a key that was already used previously to store a value, it return the previous value associated with the key
* Iterators are fail-fast. If any structural modification is made on the map, after the iterator was created, a concurrent exception will be thrown (we only can *remove* with iterator itself)

When trying to put a value, *HashMap* stores it in bucket (`hashcode()` determines to which). The number of all buckets is called capacity. To retrieve the value, *HashMap* calculates the bucket using the same `hashcode()` , iterates through the objects found there and use key's `equals()` method to find the exact match.

##### Time complexity for HashMap

| Operation                    | Time complexity                                              |
| ---------------------------- | ------------------------------------------------------------ |
| `get()`, `put()`, `remove()` | O($1$) - but if there are few values in one bucket then O($n$) because iterating (but there is optimization, see the quote below) |

> As of Java 8, when bucket contains 8 or more values, the data structure inside that bucket changes from a list to a balanced tree. This improves the performance to be O($\log n$).



##### Load Factor

- Tells us how full a hash table is
- Load factor = $\frac{\# \ of \ items}{capacity} =\frac{size}{capacity}$
- Load factor is used to decide when to resize the array backing the hash table (when it's exceeded then **rehashing** occurs)
- Don't want load factor too low (lots of empty space)
- Don't want load factor too high (will increase the likelihood of collisions)
- Can play a role in determining the time complexity for retrieval

> **Rehashing** it's when another internal array is created with twice the size of the initial one and all entries are moved over to new bucket locations in the new array.

##### Capacity

The capacity is doubled if 75% (load factor) of the buckets become non-empty. The default value for the load factor if 75%, and default initial capacity is 16.

- A **low initial capacity** reduces memory but increases the frequency of rehashing (which is very expensive). So if to anticipate many entries then set high initial capacity
- if to set **high initial capacity** then need to pay cost in iteration time



##### The hash function

```java
static final int hash(Object key) {
    int h;
    return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
}
```

We use hash code from the key object to compute a final hash.



### LinkedHashMap

The *LinkedHashMap* class is very similar to *HashMap* in most aspects. However, the linked hash map is based on both hash table and linked list to enhance the functionality of hash map.

It maintains a doubly-linked list running through all its entries in addition to an underlying array of default size 16.



### TreeMap

*TreeMap*, unlike a hash map and linked hash map, does not employ the hashing principle anywhere since it does not use an array to store its entries.

*TreeMap* implements *NavigableMap* interface and bases its internal working on the principles of [red-black trees](https://www.baeldung.com/cs/red-black-trees).

> **First of all**, a red-black tree is a data structure that consists of nodes; picture an inverted mango tree with its root in the sky and the branches growing downward. The root will contain the first element added to the tree.
>
> The rule is that starting from the root, any element in the left branch of any node is always less than the element in the node itself. Those on the right are always greater. What defines greater or less than is determined by the natural ordering of the elements or the defined comparator at construction as we saw earlier.
>
> This rule guarantees that the entries of a treemap will always be in sorted and predictable order.
>
> **Secondly**, a red-black tree is a self-balancing binary search tree. This attribute and the above guarantee that basic operations like search, get, put and remove take logarithmic time *O(log n)*.
>
> Being self-balancing is key here. As we keep inserting and deleting entries, picture the tree growing longer on one edge or shorter on the other. This would mean that an operation would take a shorter time on the shorter branch and longer time on the branch which is furthest from the root, something we would not want to happen.
>
> Therefore, this is taken care of in the design of red-black trees. For every insertion and deletion, the maximum height of the tree on any edge is maintained at *O(log n)* i.e. the tree balances itself continuously.



### ConcurrentHashMap

Source [here](https://www.baeldung.com/java-concurrent-map).

> The table buckets are initialized lazily, upon the first insertion. Each bucket can be independently locked by locking the very first node in the bucket. Read operations do not block, and update contentions are minimized.
>
> The number of segments required is relative to the number of threads accessing the table so that the update in progress per segment would be no more than one most of time. That's why constructors, compared to *HashMap*, provides the extra *concurrencyLevel* argument to control the number of estimated threads to use.

> Retrieval operations generally do not block in *ConcurrentHashMap* and could overlap with update operations. So for better performance, they only reflect the results of the most recently completed update operations, as stated in the [official Javadoc](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html).



### ConcurrentSkipListMap

As a supplement for *ConcurrentMap*, *ConcurrentNavigableMap* (interface) supports total ordering of its keys (in ascending order by default) and is concurrently navigable.

For cases when ordering of keys is required, we can use *ConcurrentSkipListMap*, a concurrent version of *TreeMap*. *ConcurrentSkipListMap* can be seen a scalable concurrent version of *TreeMap*.
