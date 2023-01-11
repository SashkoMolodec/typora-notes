## Maps

[:arrow_backward:](../algorithms_index)

Maps do not exactly store single elements as do other collections but rather a collection of key-value pairs. *Map* interface doesn't extends *Collection* interface.

[toc]

Simple implementation in Java can be found [here](https://github.com/SashkoMolodec/algorithms_java/blob/master/src/hashtables/SimpleHashtable.java).

### HashMap

* **Two unequal objects** in Java can have the **same hash code**
* Allows to have *null* as a key and as a value (it becomes the first element of the underlying array) + no hashing operation
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



### TreeMap
