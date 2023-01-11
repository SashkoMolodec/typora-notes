### Concurrency API in Java

[:arrow_backward:](../../backend_index)

#### History

1. Java 1.0 had threads, locks and memory model - best thing at that time but too difficult to implement and use
2. Java 5 added industrtial-strength building blocks like thread pools and concurrent collections
3. Java 7 added the fork/join framework, making parralelsim more practical, but still difficult
4. Java 8 added streams API
5. Java 9 adds further structuring method for concurrency - reactive programming (good for highly concurrent systems)



The property of executing multiple threads and processes at the same time is *concurrency*.

- *Thread* - smallest unit of execution
- *Process* - group of associated threads, that execute in the same shared environment



> When a thread's allotted time is complete but the thread has not finished processing, a *context switch* occurs - the process of storing a thread's current state and later restoring it to continue execution (on other CPU, for example).

> A thread can interrupt or supersede another thread if it has a higher thread priority than the other thread. 



#### Creating threads

<img src="C:\Users\sanyk\AppData\Roaming\Typora\typora-user-images\image-20220706215411796.png" alt="image-20220706215411796" style="zoom:50%;" />



#### ExecutorService & Future methods

```java
void execute(Runnable command) // Executes a Runnable task at some point in the future

Future<?> submit(Runnable task) // (or <T>); Executes a Runnable task at some point in the future and returns a Future representing the task
    
<T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks) throws InterruptedException // Executes the given tasks, synchronously returning the results of all tasks as a Collection of Future objects, in the same order they were in the original collection
    
```

<img src="C:\Users\sanyk\AppData\Roaming\Typora\typora-user-images\image-20220706221308035.png" alt="image-20220706221308035" style="zoom:50%;" />

> As Future<V> is a generic class, the type V is determined by the return type of the Runnable method. Since the return type of Runnable.run() is void, the get() method always returns null.



#### Callable

Callable for short, which is similar to Runnable except that its call() method returns a value and can throw a checked exception.



#### ScheduledExecutorService

<img src="C:\Users\sanyk\AppData\Roaming\Typora\typora-user-images\image-20220706222738030.png" alt="image-20220706222738030" style="zoom:50%;" />



#### Thread Executors

<img src="C:\Users\sanyk\AppData\Roaming\Typora\typora-user-images\image-20220706222850122.png" alt="image-20220706222850122" style="zoom:50%;" />



#### Synchronizing Data Access

- The unexpected result of two tasks executing at the same time is referred to as a *race condition*
- *Deadlock* occurs when two or more threads are blocked forever, each waiting on the other
- *Starvation* occurs when a single thread is perpetually denied access to a shared resource
  or lock. The thread is still active, but it is unable to complete its work as a result of other
  threads constantly taking the resource that they trying to access
- *Livelock* occurs when two or more threads are conceptually blocked forever, although they are each still active and trying to complete their task
- *Atomic* is the property of an operation to be carried out as a single unit of execution
  without any interference by another thread
- Each atomic class includes numerous methods that are equivalent to many of the primitive built-in operators that we use on primitives, such as the assignment operator = and the increment operators ++

<img src="C:\Users\sanyk\AppData\Roaming\Typora\typora-user-images\image-20220706223646247.png" alt="image-20220706223646247" style="zoom:50%;" />

```java
private AtomicInteger sheepCount = new AtomicInteger(0);
	private void incrementAndReport() {
		System.out.print(sheepCount.incrementAndGet()+" ");
	}
```

- A *monitor* is a structure that supports mutual exclusion or the property that at most one thread is executing a particular segment of code at a given time (*lock*)
- A *memory consistency error* occurs when two threads have inconsistent views of
  what should be the same data. Conceptually, we want writes on one thread to be available
  to another thread if it accesses the concurrent collection after the write has occurred.



#### Concurrent Classes

You should use a concurrent collection class anytime that you are going to have multiple threads modify a collections object outside a synchronized block or method, even if you don’t expect a concurrency problem. On the other hand, if all of the threads are accessing an established immutable or read-only collection, a concurrent collection class is not required.

<img src="C:\Users\sanyk\AppData\Roaming\Typora\typora-user-images\image-20220706230358373.png" alt="image-20220706230358373" style="zoom:50%;" />



#### Parrallel Streams

> With a parallel stream, the JVM can create any number of threads to process the stream.



