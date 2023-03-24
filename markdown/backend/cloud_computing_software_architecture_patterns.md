## Cloud Computing Software Architecture Patterns

[:arrow_backward:](backend_index)

[toc]

**Benefits** of Cloud Computing Pattern:

- Access to (virtually) infinite:

  - Computation
  - Storage
  - Network вау вау

  Infrastructure as a Service (**IaaS**)

- Without the IaaS every company would have to hire specialists and build infrastructure

- Cloud's pricing model charges **only** for services we use and hardware we reserve

- Removes entry barrier for new companies

- Tools/features to improve: 

  - Performance
  - Scalability
  - Reliability

  For example multi-region, multi-zone deployment

Two major **disadvantages**:

- We don't own our system's infrastructure
- Cloud infrastructure is out of our direct control



---

### Scalability Patterns

#### Load Balancing

<img src="../../src/img/backend/microservices/image-20230317222610130.png" alt="image-20230317222610130" style="zoom:50%;" />

There may be a few instances of load balancers as well. If it fails it automatically restarts. Message brokers are also scalable.

Do not use message brokers as load balancers (not their main purpose). One of the exception is when the communication between users and services is async and receiver is not waiting for some message in response. 

Message brokers are used as internal communication between services. 

Implementation considerations:

- Which algorithm to use for routing requests to workers?
  - round robin (the load balancer is routing each incoming request sequentially to the next worker instance) - usually a default load balancing algorithm; doesn't work when we need to have some session between user and server (after user authentication, when sending large files in many request)
  - sticky session (as long as server healthy request will be handled only to it, achieved by a cookie on the client's device and each sent request); works great only for relatievely short sessions
  - least connections (route new requests to servers that have the least number of already established connections) 

- Auto-scaling
  - Use data collected from metrics for auto-scaling policy



---

#### Pipes and Filters

<img src="../../src/img/backend/microservices/image-20230317222533220.png" alt="image-20230317222533220" style="zoom:50%;" />

Problems solved by Pipes and Filters pattern:

- Tight coupling - can't use different languages for different tasks
  <img src="../../src/img/backend/microservices/image-20230317200002234.png" alt="image-20230317200002234" style="zoom:50%;" />
- Hardware restrictions - each task my require different hardware (extra CPU, extra memory, fast network, GPU)
- Low Scalability - each task may requre a different number of instances

The entire pipeline can run optimally in terms of:

- Performance
- Cost
- Will be highly scalable 

Used extensively for processing streams of data about user activity (digital advertising), data from IOT, image and video processing.
<img src="../../src/img/backend/microservices/image-20230317201231970.png" alt="image-20230317201231970" style="zoom:50%;" />

Important considerations:

- Involves additional overhead and complexity
- Each filter need to be stateless, and should be provided enough information as part of its input
- Not a good fit for "transactions" (where atomicity and consistency are important)



---

#### Scatter Gather

<img src="../../src/img/backend/microservices/image-20230317222501692.png" alt="image-20230317222501692" style="zoom:50%;" />

Example of search services:

<img src="../../src/img/backend/microservices/image-20230317223432069.png" alt="image-20230317223432069" style="zoom:50%;" />

<img src="../../src/img/backend/microservices/image-20230317223556386.png" alt="image-20230317223556386" style="zoom:50%;" />

Generally 3 use cases:

- Internal instances of the same service with access to different data
- Different services with different functionality
- External services that belong to other companies

Observations:

- Number of workers is transparent to the user
- Users are not aware of whether the workers are internal or external
- Scatter gather pattern is a great choice for high scalability

Important considerations:

- Workers can become unreachable/unavailable at any moment - need maintaining reliability despite external issues
- Decoupling dispatcher from workers:

<img src="../../src/img/backend/microservices/image-20230317225829579.png" alt="image-20230317225829579" style="zoom:50%;" />

- The time between the request and the result (maybe support for long running reports)



---

#### Execution Orchestrator

<img src="../../src/img/backend/microservices/image-20230317233014842.png" alt="image-20230317233014842" style="zoom:50%;" />

Extension of the Scatter Gather pattern. We don't have one operation to perform in parallel, but instead we have a sequence of operations (can be parallel or sequential).

Situation: user tries to register but in the middle of the process orchestrator dies, user resubmitted registration and other orchestrator took that process. When it calls User service it fails due to previous already complete steps. 
The solution is to save states so orchestrator could pick up tasks if any of other fails:
<img src="../../src/img/backend/microservices/image-20230318113059717.png" alt="image-20230318113059717" style="zoom:50%;"/>



Common mistake - start adding business logic into the Orchestration service. If the Orchestration service becomes too smart it just becomes a monolith. So the scope of its work should stay within the boundaries of orchestration.

Drawbacks:

- Tight coupling between all the microservices in the system - **distributed monolith anti-pattern**:

  - get problems of a monolith architecture
  - get issues of microservices architecture
  - get no benefits of microservices architecture

  Solution - Choreography software architecture pattern

  <img src="../../src/img/backend/microservices/image-20230318115116637.png" alt="image-20230318115116637" style="zoom:50%;" />

  

---

#### Choreography

<img src="../../src/img/backend/microservices/image-20230318114612375.png" alt="image-20230318114612375" style="zoom:50%;" />

Follow the analogy of a sequence of steps in a dance - perform theirs steps when it's their turn to complete the entire flow of operations as a group.

- Communication is async (without any central entity. ), we can easily:
  - Make changes to the system
  - Add/Remove services

- Scale any flow to many services
- Scale our organization easily

> Function as a service - they don't consume any resources untill someone triggers their execution. Turn on, get the job done, turn off.

Downsides: 

- No centralized orchestrator -
  - A lot harder to troubleshoot (so need to write more integration tests)
  - A lot harder to trace the flow of events 

An example:

<img src="../../src/img/backend/microservices/image-20230318121200176.png" alt="image-20230318121200176" style="zoom:50%;" />

Choreography pattern is more suitable for:

- Simple flows
- Fewer services



---

### Performance Patterns

#### Map Reduce

<img src="../../src/img/image-20230322182516143.png" alt="image-20230322182516143" style="zoom:120%;" />

 Use cases:

- Machine learning
- Filtering and analyzing logs
- Inverted index construction
- Web link graph traversal
- Distributed sort
- Distributed search

Classic example - count word occurrences across many text files:
<img src="../../src/img/image-20230323110853837.png" alt="image-20230323110853837" style="zoom:50%;" />

<img src="../../src/img/image-20230323110928052.png" alt="image-20230323110928052" style="zoom:50%;" />

Other example:

![map_reduce_example](../../src/img/map_reduce_example.gif)

> The process of transferring data from the mappers to reducers is **shuffling**.  It is also the process by which the system performs the sort. Then it transfers the map output to the reducer as input. This is the reason shuffle phase is necessary for the reducers.

Map reduce programming model allows to:

- reuse the same software architecture
- scale the processing of a task
- run computations in parallel by many workers

The result:

- processing of massive amounts of data in short time



---

#### Saga

How do we manage data consistency across microservices within a distributed transaction? 

<img src="../../src/img/image-20230323115002067.png" alt="image-20230323115002067"  />

Saga pattern can be implemented using:

- Execution Orchestrator pattern
- Choreography pattern

With either of the impl we can execute transactions:

- that span multiple services
- without a centralized database

 

---

#### Transactional Outbox

![image-20230323125057106](../../src/img/image-20230323125057106.png)

- The update action to Users db (blue) and message action to Outbox db (green) are always a single transaction
- The Message Relay Service monitors the Outbox database and as soon as the new message appears in that table, it takes that message and sends it to the message broker and marks as send or just deletes it

Transactional Outbox:

- Solvers the problem of losing data/messages
- Guarantees that for each database update we trigger the appropriate event

Issues and considerations:

- Duplicate events

  - ***At Least Once*** - Delivery Semantics
    <img src="../../src/img/image-20230323131417684.png" alt="image-20230323131417684" style="zoom:50%;" />
  - **Idempotent** operations (not breaking anything if called multiple times) - don't need any special handling

- No support for Transactions (if our microservice is using some noSQL database, such a document store)

  - Solved by adding fields to the original database document (this operation would be typically an atomic)
    <img src="../../src/img/image-20230323131717241.png" alt="image-20230323131717241" style="zoom:50%;" />
    <img src="../../src/img/image-20230323131821820.png" alt="image-20230323131821820" style="zoom:50%;" />
    When Relay service finds an outbox in the user, it sends the event to message queue and removes the outbox field from user in the table.

- Ordering of Events

  Solution - sequence id should be bigger then previous for ability to sort the events when Message Relay service performs a query
  <img src="../../src/img/image-20230323132217488.png" alt="image-20230323132217488" style="zoom:50%;" />



---

#### Materialized View

<img src="../../src/img/image-20230323142233708.png" alt="image-20230323142233708" style="zoom:80%;" />

An example:

![image-20230323143301882](../../src/img/image-20230323143301882.png)

 Important considerations:

- Additional space for Materialized View
  - Trade Offs
    - Additional space for high performance
    - In the cloud - cost for high performance
- Where to store the Materialized View?
  - In the same db as the original data (can be feature out-of-box with some automatic updates)
    <img src="../../src/img/image-20230323144226489.png" alt="image-20230323144226489" style="zoom:50%;" />
    downside - may not be the most optimal for reading and querying data
  - Store in a separate, read-optimized database 
    <img src="../../src/img/image-20230323144518586.png" alt="image-20230323144518586" style="zoom:50%;" />
    need to take extra care and effort to keep the materialized view up to date with the original data



---

#### CQRS

<img src="../../src/img/image-20230323155040343.png" alt="image-20230323155040343" style="zoom:80%;" />

When we perform some action on the data stored in db we can split them in 2 types:

- Command - an action we perform that results in data mutation (add, update , delete)
- Query - only read data and returns to the caller 

We may pick the best db technology for the command type operations and the same for query type (so they may differ):
<img src="../../src/img/image-20230323155457248.png" alt="image-20230323155457248" style="zoom:50%;" />

Synchronization through sending events:

<img src="../../src/img/image-20230323155705842.png" alt="image-20230323155705842" style="zoom: 80%;" />

1. We may implement this with message broker, but are we sure about the single transaction when updating the command db and query db? The answer to that is to use **transactional outbox pattern**:
   <img src="../../src/img/image-20230323160043997.png" alt="image-20230323160043997" style="zoom: 50%;" />  
   The message broker will not delete the event until the query service successfully consumes it and updates its database, we are guaranteed that we will not lose any update.
2. Function as a service
   <img src="../../src/img/image-20230323160438605.png" alt="image-20230323160438605" style="zoom: 50%;" />

Issues/Drawbacks:

- We can only guarantee Eventual Consistency between the Command and Query dbs, but not strict consistency

  > Strong consistency means the latest data is returned, but, due to internal consistency methods, it may result with higher latency or delay. With eventual consistency, results are less consistent (not the latest) early on, but they are provided much faster with low latency.

- Overhead and complexity (separated services and synchronization part)

Online store example:

<img src="../../src/img/image-20230323161633374.png" alt="image-20230323161633374" style="zoom:80%;" />

With that event message we update the noSQL Reviews collection. If the checking review count exceeds some number then we calculate product rating and insert it in Product Ratings collections.
We have the possibility for scaling out the Query Service part as the load will be much higher.



---

#### CQRS + Materialized View for Microservices Architecture

<img src="../../src/img/image-20230323162307135.png" alt="image-20230323162307135" style="zoom:80%;" />

FaaS approach:

<img src="../../src/img/image-20230323174202944.png" alt="image-20230323174202944" style="zoom:80%;" />

Cloud function will update the materialized view - eventually consistent.

An example:

<img src="../../src/img/image-20230323174621831.png" alt="image-20230323174621831" style="zoom:80%;" />

Using CQRS + Materialized View we were able to solve an important problem in microservices architecture:

- Joining data from multiple microservices with separate databases

By using:

- Materialized View, we placed the joined data in a separate table
- CQRS, we stored the materialized view in separate read optimized database. Each behind its own microservice
- Event Driven Architecture, we keep the external Materialized View up-to-date with the original data



---

#### Event Sourcing

In certain situations we need to know the current statue and every previous state. Reasons are for visualization, auditing, corrections.

<img src="../../src/img/image-20230323180131027.png" alt="image-20230323180131027" style="zoom:80%;" />

An example:

<img src="../../src/img/image-20230323181519206.png" alt="image-20230323181519206" style="zoom:80%;" />

We may also provide insights such as advice for better spending habits or recommend other products.

Where to store events:

- DB - each in separate record 
- Storing events in message broker

Problem we solve:

<img src="../../src/img/image-20230323182136654.png" alt="image-20230323182136654" style="zoom:80%;" />

all updates with each other and slow down as well as all the readers of that table.

<img src="../../src/img/image-20230323182232697.png" alt="image-20230323182232697" style="zoom:80%;" />

**Strategies** for replaying events:

- Snapshots
  <img src="../../src/img/image-20230323182430217.png" alt="image-20230323182430217" style="zoom:50%;" />
- CQRS pattern
  <img src="../../src/img/image-20230323182624102.png" alt="image-20230323182624102" style="zoom:80%;" />
  Very popular, because we get **history** and **auditing**, we get fast and efficient writes, we get fast and efficient reads.



---

### Extensibility Patterns

#### Sidecar

<img src="../../src/img/image-20230324083420025.png" alt="image-20230324083420025" style="zoom:80%;" />

Issues with a shared library:

- Scalability
- Incompatibility of inconsistency between different languages
  - different data types
  - bugs in different versions of implementations

The main application is isolated from a sidecar process but at the same time they both run on same host - for a fast, reliable communication. They both have access to the same internal server resources.

Sidecar Pattern extends the functionality of a service

- No need to reimplement in every programming language
- No need to deploy as a service on additional hardware

Sidecar benefits:

- Isolation between the sidecar and the core application
- Has access to the same resources
- Low overhead of interprocess communication

##### Ambassador Sidecar

Ambassador is a special sidecar that is responsible for sending all the network requests on behalf of the service - like a proxy, but it runs on the same host as the core application.

<img src="../../src/img/image-20230324084916882.png" alt="image-20230324084916882" style="zoom:50%;" />

Troubleshoot transactions:

<img src="../../src/img/image-20230324085048826.png" alt="image-20230324085048826" style="zoom:80%;" /> 



---

#### Anti-Corruption Adapter/Later

<img src="../../src/img/image-20230324100710581.png" alt="image-20230324100710581" style="zoom:80%;" />

2 scenarios:

- Migration between architectures
- Running 2 systems permanently side-by-side

Overhead

- Anti-Corruption will always have some
  - Performance overhead (latency) 
  - Additional cost (may develop FaaS solution)



---

#### BFFs - Backends For Frontends

<img src="../../src/img/image-20230324145756365.png" alt="image-20230324145756365" style="zoom:65%;" />

<img src="../../src/img/image-20230324150150559.png" alt="image-20230324150150559" style="zoom: 80%;" />

Challenges:

- Multiple backends - How to avoid duplicating shared functionality?
  - Shared libraries (if not so much code with no changing, requires coordination between teams)
  - Separate shared service with clear defined scope
    <img src="../../src/img/image-20230324150803064.png" alt="image-20230324150803064" style="zoom:50%;" />

- How many types of Backend For Frontends?



---

### Reliability, Error Handling and Recovery Patterns

#### Throttling and Rate Limiting

<img src="../../src/img/image-20230324154511586.png" alt="image-20230324154511586" style="zoom:80%;" />

Throttling - set requests limited by Period of Time

> Limits on the bandwidth and set mb or gb of data that can be either sent or read from our system at a given period.

When exceeds a limit send a response with 429 - Too Many Requests.

Considerations:

- Customer base throttling vs Global (API level) throttling
- External throttling vs Service based throttling



---

#### Retry

Retry pattern attempts to recovery from **system** error - delays, timeouts, failures.

<img src="../../src/img/image-20230324181312200.png" alt="image-20230324181312200" style="zoom:80%;" />

Considerations: 

- Which errors to retry?
  - Short
  - Temporary (some 503)
  - Recoverable 
- What delay/backoff strategy to use?
  - Fixed delay
    <img src="../../src/img/image-20230324182625047.png" alt="image-20230324182625047" style="zoom:50%;" />
  - Incremental delay 
    <img src="../../src/img/image-20230324182655706.png" alt="image-20230324182655706" style="zoom:50%;" />
  - Exponential Backoff
    <img src="../../src/img/image-20230324182739578.png" alt="image-20230324182739578" style="zoom:50%;" />

> Retry storm - a situation that can cause unrecoverable cascading failure in the system 
> <img src="../../src/img/image-20230324182236842.png" alt="image-20230324182236842" style="zoom:50%;" />
>
> It will cause more timeouts and errors which will result in more retries and so on. This way we can easily get to a point where the entire service goes down and can't recover. 
>
> As we try to bring it back up, it gets bombarded with more and more retry requests, which newly started instances are not yet ready to handle.
>
> Solution - add a delay between subsequent retries.

- Adding randomization / Jitter between retries
  To make the retry traffic to healthy instances less spiky (imagine request load graph)
- How many times / how long to retry?
- Is the operation idempotent?
  Retrying idempotent op is safe, non-idempotent - not safe
- Where to implement the retry logic?
  - Use shared library code
  - Ambassador sidecar pattern
    <img src="../../src/img/image-20230324183418566.png" alt="image-20230324183418566" style="zoom:50%;" />



---

#### Circuit Breaker

