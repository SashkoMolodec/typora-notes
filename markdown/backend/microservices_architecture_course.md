## Microservices Architecture - The Complete Guide

[:arrow_backward:](backend_index)

[toc]

Martin Fowler's definition of microservices:

>  In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. These services are built around business capabilities and independently deployable by fully automated deployment machinery. There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies.

### Before Microservices

#### Monolith architecture

 Pros:

- Easier to design
- Performance

Cons:

- Single technology platform
- With monolith, new deployment is always for the whole app
  - Forces rigorous testing for every deployment
  - Forces long development cycles
- Inneficient compute resources
  - Compute resources (CPU and RAM) are divided across all components
  - No way to give more resources to a specific component - only to all the monolith
- Large and complex - difficult to maintain
  - Every little change can affect other components (no isolation)
  - Testing not always detects all the bugs
  - Might make the system obsolete (no changes because devs are afraid to break something)



#### SOA (Service Oriented Architecture)

- Apps are services exposing functionality to the outside world
- Services expose metadata to declare their functionality
- Usually implemented using SOAP & WSDL and ESB

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/1.png" alt="img" style="zoom:45%;" />

Pros:

- Sharind Data & Functionality
- Polyglot between services - avoid platform dependencies

Cons:

- Complicated and expensive ESB
  - Can quickly become bloated and expensive (only large companies with big pockets could use it)
  - Tries to do everything
  - Very difficult to maintain
  - No tooling existed to support quick testing and deployment (everything manually)
  - No time saving was achieved



### Characteristscs of Microservices

Among all attributes (described bellow), the most important are Componentization, Organized around business capabilities, Decentralized governance, Decentralized data management (when possible), Infrastracture automation.

#### Componentization via Services

Components are the parts that together compose the software.

Modularity can be achieved using:

- Libraries - called directly within the process
- Services - called by out-of-process mechanism (Web API, RPC)

Motivation:

- Independent deployment   
- Well defined interface

#### Organized around business capabilities

Every service is handled by a single team.

- Motivation:
  - Quick development
  - Well-defined boundaries

#### Products not projects

The goal is not to deliver just a project (working code) but a workin product.

A product needs ongoing support and requires close relationship with the customer.

The team is responsible for the Microservice after the delivery too.

Motivation:

- Increase customer's satisfaction
- Change developers' mindset

#### Smart endpoints and dumb pipes

Microservices systems use "dumb pipes" - simple protocols (usually HTTP)

Important notes:

- Direct connections between services is not a good idea
- Better use discovery service or a gateway
- More protocols were introduced (GraphQL, rRPC), some of them quite complex

Motivation:

- Accelerate development
- Make the app easier to maintain

#### Decentralized governance

In traditional projects there is a standard for almost anything. With microservices each time makes its own decisions based on dev platform, db to use, logs to create and more.

Each team is fully responseible for its service. 

Multi dev platform is called *Polyglot*.

Motivation:

- Enables making the optimal technological decisions for the specific service

#### Decentralized data management 

WIth microservices each service has its own database. This is the most controversial attribute of microservices and not always possible. It raises problem such as distributed transactions, data duplicaiton. **Don't insist on it and decide on a case-by-base basis.**

Motivation:

- Right tool for the right task - having the right db is important
- Encourages isolations (less dependant on data from other services)

#### Infrastracture Automation

Tooling grealy helps in deployment using:

- Automated Testing
- Automated Deployment

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/2.png" alt="Знімок екрана 2023-03-01 о 15.41.49" style="zoom:70%;" />

For microservices automation is essential.

Motivation:

- Short deployment cycles

#### Design for failure

Motivation:

- Increase system's reliability

The code must assume failure can happen and handle it gracefully

- Catch the exception
- Retry (some network issue)
- Log the extension

Extensive logging and montioring should be in place.

#### Evolutionary Design

The move to microserices should be gradual. Start small and upgrade each part separately.



### Problems solved by Microservices

- Single technology platform
  with decentralized governance
- Inneficient compute resources
  with componentization
- Inflexible deployment
  with componentization and decentralized data management
- Large and complex
  with componentization, decentralized data management, organized around business capabilities
- Complicated and expensive ESB
  with smart endpoints and dumb pipes (use application gateway & discovery & other APIs as GraphQL, gRPC)
- Lack of tooling
  with Infrastracture automation



### Designing Microservices Architecture

Plan more, code less.

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/3.png" alt="image-20230301162902496" style="zoom:40%;" />



#### Mapping the components

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/4.png" alt="Знімок екрана 2023-03-01 о 17.00.53" style="zoom:45%;" />

Mapping should be based on:

- Business requirements
- Functional autonomy
  - The maximum functionality that does not involve other business requirements
  - There will still be gray areas, so there will such things as duplicate data and interservice communication - need to have them as little as possible
- Data entitites
  - Service is designed around well-specified data entities (for e.g. orders, items)
  - Data can be related to other entities just by ID
- Data autonomy
  - Underlying data is an atomic unit
  - Service does not depend on data from other services to function properly

##### Edge cases

#1: Retrieve all customers from NYC with total number of orders for each customer. Various approaches to resolve:

- Data duplication. Store number of orders in customers database
- Services query. Services talk to each other. The problem is that is load the network and the service.
- Aggregation Service. Add another, third service, that aggregates the result of the queries. 
  - The benefit is that data and service are not mixed (orders deals with orders only and same with customers)

Stick to data duplication approach, because very little data and field is read only.

#2: Retrieve a very huge list of all the orders in the system (service cannot handle it). 
We need to find out what's the purpose of this query. If for reporting, than better to use not service but some report engine, that could bypass the service API and directly talk with a database.

##### Cross-cutting services

- Services that provide system-wide utilites and are not tied to single service.
  - Logging 
  - Caching 
  - User management
- MUST be part of the mapping



#### Defining Communication Patterns

Main patterns described bellow.

##### 1-to-1 Sync

A service calls another service and waits for the response - called a *synchronous request*. Used mainly when the first service needs the response to continue processing. 
<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/5.png" alt="image-20230301172624819" style="zoom:40%;" />

Pros:

- Immediate response (no need to wait unknown time for triggering response - our called does that)
- Error handling (much easier)
- Easy to implement

Cons: 

- Performance (makes dependant on other services we may not have any control)

Direct communication is bad:

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301173213469.png" alt="image-20230301173213469" style="zoom:45%;" />

If some service will break it will affect others. Solutions are Service discovery:

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301173604920.png" alt="image-20230301173604920" style="zoom:45%;" />

Or Gateway:

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301173728760.png" alt="image-20230301173728760" style="zoom:45%;" />

Implementing discovery service is easier but gateway can provide more services such as monitoring, authorization, authentication and more. For now, it's becoming a more popular choice.

##### 1-to-1 Async

A service calls another service and continues working. Doesn't wait for response - **Fire and Forget**. User mainly when the first service wants to pass a message to the other service.

Pros:

- Performance

Cons:

- Needs more setup
  <img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301174258566.png" alt="image-20230301174258566" style="zoom:35%;" />
- Difficult error handling

##### Pub-Sub / Event Driven

A service wants to notify other services about something. The service has no idea how many services listen to it.

- Uses Fire and Forget pattern
- Used mainly when the first service wants to notify about an important event in the system

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301174851185.png" alt="image-20230301174851185" style="zoom:35%;" />

Pros:

- Performance
- Notify multiple services at once

Cons 

- Needs more setup
- Difficult error handling
- Might cause load



#### Selecting Technology Stack

Development platform:

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301175410665.png" alt="image-20230301175410665" style="zoom:45%;" />

Data store:

- Relational database
- NoSQL database
  - Emphasis on scale and performance
  - Schema-less
  - Data is usually stored in JSON (mongoDB most popular)
  - User for storing logs and telemetry data
- Cache
  - Stores in-memory data for fast access
  - Distributes data across nodes
  - Uses proprietary protocol (very fast)
  - Stores serializable objects
  - Redis - defacto a standard
- Object store  
  - Stores un-structured, large data (documents, photos, files)
  - Amason S3, Microsoft Azure, MINIO

​	

#### Design an Architecture

Use software architectural patterns to design each service.



### Deploying Microservices

 **CI/CD** - the full automation of the integration and delivery stages.

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301195248749.png" alt="image-20230301195248749" style="zoom:50%;" />

- Faster realease cycle 
- Reliability
- Reporting

**Containers**

A thin packaging model (software, dependencies, conf files), can be copied between machines.

- Predictability - the same package is deployed from the dev machine to the test to prod
- Performance - goes up in seconds vs minutes in VM (containers do not need to start any OS, it uses host one)
- Density - one server can run thousands of containers vs dozens of VMs

The only reason not to use containers is isolation - containers share the same OS, so isolation is lighter than VM.

**Containers management**

Kubernetes - de-facto standard for container management. 



### Testing Microservices

Main challenges:

- Testing state across services
- Non-functional dependent services

**Integration tests**

- Test the service's functionality using its end API
- Cover (almost) all code paths in the service
- Some paths might include accessing external objects:
  - DB, other services

Three types of **test doubles**:

- Fake
  - Implements a shortcut to the external services (implemented in-process, some in-memory db)
  - Requires code change in the code
- Stub
  - Holds hard-coded data
  - Usually replaces data stored in a DB
- Mock
  - Verifies access was made
  - Hold no data
  - No code change required

##### End-to-End tests

- Touch all services
- Test for end state
- Require code
- Usually used for main scenarios only



### Service Mesh

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301212127855.png" alt="image-20230301212127855" style="zoom:50%;" />

Software components that sit near the service and manage all service-to-service communication

- Provides all communication services

- The service interacts with the service mesh only

Mesh services:

- Protocol conversion
- Communication security
- Authentication
- Reliability (timeouts, retries, health check, circuit breaking)
- Monitoring
- Service Discovery
- Testing (A/B testing, traffic splitting)
- Load balancing

>  Circuit Breaker prevents cascading failures when a service fails.
> <img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301211503636.png" alt="image-20230301211503636" style="zoom:50%;" />
>
> Here, the blue service won't throw timeout failure as a result of the green services problem.

Use Service Mesh **only if**:

- Have a lot of services which communicate with each other
- Complex communication requirement with various protocols or brittle network

#### Service Mesh types

**In-Process**

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301212327234.png" alt="image-20230301212327234" style="zoom:50%;" />

The service mesh is the part of the services process. No inter-process communication is required to use it.
Pros:

- Performance

Products: DDS Foundation (used in military).

**Sidecar**

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301212504138.png" alt="image-20230301212504138" style="zoom:50%;" />

The mesh component is not placed in services process. 

Pros:

- Platform agnostic (could be implemented in any language)
- Code agnostic
- Far more popular then in-process 

Products: Istio, Linkerd and Maesh.



### Logging & Monitoring

#### Logging

- Recording the system's activity
- Audit
- Documenting errors

Problems:

- Separate, different formats
- Not aggregated
- Can't be analyzed

How to handle: write to a central logging service - unified, aggregated, can be analyzed

**Correlation ID**

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230301232817033.png" alt="image-20230301232817033" style="zoom:50%;" />

**Transport**

- Preferably Queue
- Balanced the load
- No performance hit on the client side
- Use RabbitMQ or Apache Kafka

#### Monitoring

- Provides simplifived view of the system status
- Alerting when needed  

**Infrastracture monitoring**

- Monitors the server
- CPU / RAM / Disk / Network
- Alerts when infrastracture problem is detected
- Data source: agent on the machine

**Application monitoring**

- Monitors the app
- Looks at metrics published by app
  - Requests / min, Orders / day, etc.
- Alerts when app problem detected

- Data source: app logs, event log




### When Not to Use Microservices

- Small systems with low complexity should usually be a monolith, because microservices add complexity
  - If the service mapping results in 2-3 services - microservices are probably not the right option
- When there is no way to separate logic or data - microservices will not help (would create a strongly coupled system what microservices try to avoid)
  - If almost all requests for data span more than one service - there's a problem 
- Microservices systems have performance overhead
  - If the system is VERY performance sensitive - think twice (SLA is in the low-miliseconds or even microseconds)
- Quick-and-Dirty Systems; if you need a small, quick system, now - don't go with microservices
  - It takes a good amount of time to implement microservices
- No planned updates, for example in embedded systems
  - Microservices main strength is in the short update cycle
    No updates == No microservices



### Microservices and the Organization

Microservices require different mindset, traditional organizations will have hard time succeeding with it.

**Conway's Law**

> "Any organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure".

The problem with traditional team is that when there are multiple teams (backend team, frontend team) - no one takes responsibility for the whole product (because each team develops only certain layer). Teams are horizontal and there is **no wholistic view on the product**.

The ideal team is responsible for all aspects of the service.

> "Every internal team should be small enough that it can be fed with two pizzas" - Jeff Bezos.

Generally, it should be small (3-7).

POC (Proof of concept) - go small, quick win.



### Breaking Monolith to Microservices

Motivation:

- Shorten update cycle
- Modularize the system
- Save costs (sotfware, may be legacy and expensive, and hardware)
  - Big bloated teams
- Modernize the system (the change to microservices is gradual and managed)
- Being attractive (for developers)

Strategies to break the monolith:

##### New modules as services

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230302173810776.png" alt="image-20230302173810776" style="zoom:35%;" />

Pros:

- Easy to implement
- Minimum code changes

Cons: 

- Takes time
- End result is not pure microservices architecture

##### Separate existing modules to services

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230302174142339.png" alt="image-20230302174142339" style="zoom:35%;" />

Pros:

- End result is pure Microservices architecture

Cons:

- Takes time 
- A lot of code changes (take legacy code and convert to microservice)
- Regression testing required

##### Complete rewrite 

<img src="/Users/okravch/my/typora-notes/src/img/backend/microservices/image-20230302174604417.png" alt="image-20230302174604417" style="zoom:35%;" />

Pros:

- End result is pure Microservices architecture
- Opportunity for modernization

Cons:

- Takes time (a lot on planning)
- Rigorous testing required



 