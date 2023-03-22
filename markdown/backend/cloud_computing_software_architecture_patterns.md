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



### Scalability Patterns

#### Load Balancing

<img src="../../src/img/backend/microservices/image-20230317222610130.png" alt="image-20230317222610130" style="zoom:50%;" />

There may be a few instances of load balancers as well. If it fails it automatically restarts. Message brokers are also scalable.

Do not use message brokers as load balancers (not their main purpose). One of the exception is when the communication between users and services is async and receiver is not waiting for some message in response. 

Message brokers are used as internal communication between services. 

Implementation consideradtions:

- Which algorithm to use for routing requests to workers?
  - round robin (the load balancer is routing each incoming request sequentially to the next worker instance) - usually a default load balancing algorithm; doesn't work when we need to have some session between user and server (after user authentication, when sending large files in many request)
  - sticky session (as long as server healthy request will be handled only to it, achieved by a cookie on the client's device and each sent request); works great only for relatievely short sessions
  - least connections (route new requests to servers that have the least number of already established connections) 

- Auto-scaling
  - Use data collected from metrics for auto-scaling policy

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
- Scatter gather pattern is a great choise for high scalabilty

Important considerations:

- Workers can become unreachable/unavailable at any moment - need maintaining reliability despite external issues
- Decoupling dispatcher from workers:

<img src="../../src/img/backend/microservices/image-20230317225829579.png" alt="image-20230317225829579" style="zoom:50%;" />

- The time between the request and the result (maybe support for long running reports)

#### Execution Orchestrator

<img src="../../src/img/backend/microservices/image-20230317233014842.png" alt="image-20230317233014842" style="zoom:50%;" />

Extension of the Scatter Gather pattern. We don't have one operation to perform in parallel, but instead we have a sequence of operations (can be parallel or sequential).

Situation: user tries to register but in the middle of the process orchestrator dies, user resubmitted registration and other orchestrator took that process. When it calls User service it fails due to previous already complete steps. 
The solution is to save states so orchestrator could pick up tasks if any of other fails:
<img src="../../src/img/backend/microservices/image-20230318113059717.png" alt="image-20230318113059717" style="zoom:50%;" />

Common mistake - start adding business logic into the Orchestration service. If the Orchestration service becomes too smart it just becomes a monolith. So the scope of its work should stay within the boundaries of orchestration.

Drawbacks:

- Tight coupling between all the microservcies in the system - **distributed monolith anti-pattern**:

  - get problems of a monolith architecture
  - get issues of microservices architecture
  - get no benefits of microservices architecture

  Solution - Choreography software architectire pattern

  <img src="../../src/img/backend/microservices/image-20230318115116637.png" alt="image-20230318115116637" style="zoom:50%;" />

  

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

- No centrailized orchestrator -
  - A lot harder to troubleshoot (so need to write more integration tests)
  - A lot harder to trace the flow of events 

An example:

<img src="../../src/img/backend/microservices/image-20230318121200176.png" alt="image-20230318121200176" style="zoom:50%;" />

Choreography pattern is more suitable for:

- Simple flows
- Fewer services



### Performance Patterns

#### Map Reduce

