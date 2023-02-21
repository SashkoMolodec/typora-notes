## Effective Java

:arrow_backward:

[toc]

### Concurrency



#### Item 78: Synchronize access to shared mutable data (synchronized, volatile)

> A mutex (or mutual exclusion) is **the simplest type of synchronizer – it ensures that only one thread can execute the critical section of a computer program at a time**. To access a critical section, a thread acquires the mutex, then accesses the critical section, and finally releases the mutex.

The `synchronized` keyword ensures that only a single thread can execute a method or block at one time. 

- Not only does synchronization prevent threads from observing an object in an inconsistent state, but it ensures that each thread entering a synchronized method or block sees the effects of all previous modifications that were guarded by the same lock.

- The language specification guarantees that reading or writing a variable is *atomic* unless the variable is of type `long` or `double` (even if multiple threads modify the variable concurrently and without synchronization), but there is a problem. It guarantees that when reading a field it won't be some random value BUT it does not guarantee that a value written by one thread will be visible to another.
  **Synchronization is required for reliable communication between threads as well as for mutual exclusion.**

  > Doing `a = 28` (with `a` being an `int`) is an atomic operation. But doing `a++` is not an atomic operation because it requires a read of the value of `a`, an incrementation, and `a` write to `a` of the result.
  > `AtomicInteger` solves this issue by providing atomic operations.

  > *Memory model* of the language specifies when changes made by one thread become visible to others.

- **Synchronization is not guaranteed to work unless both read and write operations are synchronized.**
  <img src="./../../../src/img/java/effective/2.png" alt="image-20230220233120637" style="zoom:45%;" />
  Here we provided `synchronized ` not for mutual exclusion but only for the communication purposes. Less verbose and with better performance would be to use `volatile` modifier. It performs no mutual exclusion but it guarantees that any thread that reads the field will see the most recently written value.
  <img src="./../../../src/img/java/effective/1.png" alt="image-20230220234302053" style="zoom:45%;" />

- It is acceptable for one thread to modify a data object for a while and then to share it with other threads, synchronizing only the act of sharing the object reference. Other threads can then read the object without further synchronization so long as it isn’t modified again. Such objects are said to be *effectively immutable*. Transferring such an object reference from one thread to others is called *safe publication*. Ways to safely publish an object reference:

  - store in static field as part of class initialization
  - volatile field
  - final field
  - field that is accessed with normal locking
  - put it into a concurrent collection

  

## To read Item 79 and so on....