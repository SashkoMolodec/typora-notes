### [Spring Boot Microservices and Spring Cloud. Build & Deploy](https://www.udemy.com/course/spring-boot-microservices-and-spring-cloud/#reviews)

Section 1: Introduction
59min

1. Source Code
1min
2. Course Overview
7min
3. A few suggestions
3min
4. What is a Microservice?
7min
5. Sample Microservices Architecture
7min
6. Download and Install Postman HTTP Client
5min
7. Postman Overview
9min
8. Resource and Collection URIs
11min
9. HTTP Methods: GET, POST, DELETE and PUT
4min
10. HTTP Headers: Accept and Content Type
4min

Section 2: Setting up Development Environment
9min
11. Install Java Platform(JDK)
6min
12. Download and Install Spring Tool Suite(STS)
3min

Section 3: Building RESTful Web Services - A Quick Start. (Optional)
2hr 11min
13. Introduction
1min
14. Creating a New Project
6min
15. Creating a new Spring project using Spring Boot Initializr
5min
16. Create Users Rest Controller class
3min
17. Adding Methods to Handle POST, GET, PUT, DELETE HTTP requests
3min
18. Running Web Service Application
5min
19. Reading Path Variables with @PathVariable annotaion
4min
20. Reading Query String Request Parameters
5min
21. Making Parameters Optional or Required
5min
22. Returning Java Object as Return Value
4min
23. Returning Object as JSON or XML Representation
6min
24. Set Response Status Code
5min
25. Reading HTTP POST Request Body. The @RequestBody annotation.
8min
26. Validating HTTP POST Request Body
9min
27. Store Users Temporary
5min
28. Handle HTTP PUT Request
9min
29. Handle HTTP Delete Request
5min
30. Handle an Exception
8min
31. Return Custom Error Message Object
6min
32. Handle a Specific Exception
3min
33. Throw and Handle You Own Custom Exception
4min
34. Catch More Than One Exception with One Method
3min
35. Dependency Injection: Create and Autowire a Service Layer Class
11min
36. Constructor Based Dependency Injection
6min
37. Run Web Service as a Standalone Application
5min

Section 4: Eureka Discovery Service - A Quick Start
11min
38. Introduction to Eureka Discovery Service
4min
39. Startup Eureka Service Discovery
6min
40. Troubleshooting
1min
41. Source code
1min

Section 5: Users Microservice - A Quick Start
14min
42. Introduction to Building a Users Microservice
2min
43. Users Microservice - Create new Spring Boot Project
4min
44. Enable Eureka Client
3min
45. Create Users Rest Controller
2min
46. Access Users Web Service Endpoint via Eureka Discovery Service
3min
47. Exercise - Create Account Management Microservice
1min

Section 6: Account Management Microservice - A Quick Start
8min
48. Introduction to Building an Account Management Microservice
2min
49. Create a new Spring Boot Project
4min
50. Access Account Management Microservice via Eureka Discovery Service
3min

Section 7: Zuul API Gateway - A Quick Start
13min
51. Important note
2min
52. Introduction to Zuul API Gateway
3min
53. Create a ZUUL API Gateway Project
4min
54. Access Microservices via API Gateway
4min

Section 8: Zuul as a Load Balancer - A Quick Start
15min
55. Important note
1min
56. Load Balancer - Introduction
1min
57. Starting Up More Microservices
9min
58. Trying How Load Balancer Works
5min

Section 9: Spring Cloud API Gateway
43min
59. Important Note
2min
60. Introduction
6min
61. Creating API Gateway Project
5min
62. Automatic Mapping of Gateway Routes
7min
63. Manually Configuring API Gateway Routes
8min
64. Trying how it works
4min
65. Rewriting URL Path
5min
66. Automatic &amp; Manual Routing
2min
67. Build-In Predicate Factories
4min
68. Gateway Filters
1min

Section 10: Spring Cloud API Gateway as a Load Balancer
13min
69. Starting Up More Microservices
9min
70. Trying How Load Balancer Works
4min

Section 11: H2 In-Memory Database
16min
71. H2 In-memory Database. Introduction.
3min
72. H2 Database Console Overview
8min
73. Adding Support for the H2 Database
5min

Section 12: Users Microservice - Implementing User Sign up
1hr 19min
74. Introduction
1min
75. Source Code
1min
76. Adding method to handle HTTP Post Request
1min
77. Implementing the Create User Request Model class
3min
78. Validating HTTP Request Body
4min
79. Application Layers
3min
80. Implementing Service Layer Class
2min
81. Create a Shared DTO Class
3min
82. Generate Unique Public User Id
2min
83. Adding Support for Spring Data JPA
2min
84. Implementing User Entity Class
6min
85. Implementing Spring Data JPA CRUD Repository
3min
86. Save User Details in Database
11min
87. Return Http Status Code
2min
88. Implementing Create User Response Model
5min
89. Add Spring Security to Users Microservice
1min
90. [Updated] Add WebSecurity Configuration
9min
91. [Updated] Encrypt User Password
6min
92. [Updated] Allow Requests from API Gateway Only
5min
93. Trying how it works
4min
94. [Updated] Adding Support to Return XML
4min

Section 13: Users Microservice - Implementing User Login
50min
95. Introduction
1min
96. Source code
1min
97. Implementing LoginRequestModel
1min
98. [Updated]AuthenticationFilter. Implementing attemptAuthentication()
5min
99. Register Authentication Filter with HTTP Security
3min
100. Implementing loadUserByUsername() method
11min
101. successfullAuthentication(): Get User Details.
7min
102. successfullAuthentication(): Adding JWT Dependencies
2min
103. sucessfullAuthentication(): Generate JWT
7min
104. Configure API Gateway route to /login
3min
105. [Updated] Trying how /login works
5min
106. [Updated] Customize User Authentication URL
5min

Section 14: Enable Spring Security in Zuul API Gateway
27min
107. Important note
1min
108. Introduction to Spring Security on API Gateway
2min
109. Adding Support for Spring Security and JWT Tokens
1min
110. Enable Web Security in Zuul
4min
111. Allow Access to Registration and Login Urls
5min
112. Implementing Authorization Filter
9min
113. Accessing Protected Microservices with Access Token
5min

Section 15: Spring Cloud API Gateway - Creating a Custom Filter.
39min
114. Introduction
3min
115. Using Header Predicate
4min
116. Adding Support for JWT Token Validation
2min
117. Creating AuthorizationFilter class
4min
118. Assign Custom Filter to a Gateway Route
1min
119. Signup and Login Routes
3min
120. Reading Authorization HTTP Header
8min
121. Validating JWT Access Token
7min
122. Accessing Protected Microservices with Access Token
7min

Section 16: Spring Cloud API Gateway Global Filters
34min
123. Introduction
1min
124. Creating Global Pre Filter
4min
125. Accessing Request Path and HTTP Headers
4min
126. Trying how Pre Filter Works
4min
127. Creating Global Post Filter
3min
128. Trying how the Post Filter works
3min
129. Defining Filters in a Single Class
7min
130. Ordering Global Filters
7min
131. Trying how ordered filters work
2min

Section 17: Spring Cloud Config Server - Git Backend
28min
132. Introduction to Spring Cloud Config Server
4min
133. Create Your Own Config Server
3min
134. Create Private GitHub Repository
2min
135. Naming Property Files Served by Config Server
3min
136. Configure Config Server to Access Private GitHub Repository
3min
137. Adding Properties File to Git Repository
3min
138. Configure Users Microservice to be a Client of Config Server
7min
139. Make Zuul Gateway a Client of Config Server
2min

Section 18: Spring Cloud Bus - A Quick Start
26min
140. Introduction to Spring Cloud Bus
4min
141. Add Spring Cloud Bus &amp; Actuator Dependencies
2min
142. Enable the /bus-refresh URL Endpoint
2min
143. Download and Run Rabbit MQ
3min
144. Rabbit MQ Default Connection Details
2min
145. Trying how Spring Cloud Bus Works
9min
146. Change default Rabbit MQ Password
3min

Section 19: Spring Cloud Config - File System Backend
10min
147. Introduction to Spring Cloud Config File System as a Backend
1min
148. Setting up File System Backend
5min
149. Previewing Values Returned by Config Server
2min
150. Trying how Microservices work
3min

Section 20: Spring Cloud Config - Configuration for Multiple Microservices
10min
151. Introduction
3min
152. Shared and a Microservice specific properties
7min

Section 21: Spring Boot Actuator - A Quick Start
18min
153. Introduction to Spring Boot Actuator
2min
154. Add Spring Boot Actuator to API Gateway
5min
155. Trying How It Works
5min
156. Enable Actuator for Users Microservice
6min

Section 22: Using MySQL Instead of In-Memory Database
44min
157. Introduction
1min
158. Download and Install MySQL
3min
159. Start MySQL Server and Login
6min
160. Create MySQL Database And a New User
6min
161. Downloading and Installing MySQL Workbench
3min
162. Connect to MySQL Database using MySQL WorkBench
5min
163. MySQL WorkBench brief overview
4min
164. Configure MySQL Database Access Details
10min
165. Use H2 Console to Access MySQL Database
3min
166. Copy MySQL properties to a Config Server
2min

Section 23: Encryption and Decryption
29min
167. Introduction to Encryption and Decryption of Configuration Properties
3min
168. A note about Java Cryptography Extension(JCE)
1min
169. Add Java Cryptography Extension
6min
170. Symmetric Encryption of Properties
9min
171. Creating a Keystore for Asymmetric Encryption
5min
172. Asymmetric Encryption of Properties
5min

Section 24: Microservices Communication
1hr 9min
173. Introduction to Microservices Communication
4min
174. Albums Microservices Source Code
1min
175. Clone Source Code of Albums Microservice
2min
176. A walk through an Albums Microservice
6min
177. Implementing Get User Details
6min
178. Make Users Microservice call Albums Microservice
10min
179. Trying how it works
4min
180. Feign Web Service Client - Introduction
2min
181. Enable Feign in Spring Boot Project
2min
182. Create Feign Client
5min
183. Using Feign Client
2min
184. Trying How Feign Client Works
3min
185. Enable HTTP Requests Logging in Feign Client
6min
186. Handle FeignException
5min
187. Handle Response Errors with Feign Error Decoder
13min

Section 25: Microservices communication - Hystrix Circuit Breaker
22min
188. Introduction
3min
189. Configure Project to use Hystrix Circuit Breaker
4min
190. Trying How Hystrix Circuit Breaker &amp; Feign work
3min
191. Error Handling with Feign Hystrix FallbackFactory
11min

Section 26: Microservices communication. Resilience4j - Circuit Breaker.
40min
192. Introduction
8min
193. Removing Hystrix Circuit Breaker
3min
194. Adding Resilience4j
3min
195. Actuator /health Endpoint
3min
196. Feign Client &amp; Circuit Breaker Fallback method
4min
197. Circuit Breaker configuration properties
7min
198. Configure Access to Actuator endpoints
5min
199. Monitoring Circuit Breaker events in Actuator
7min

Section 27: Microservices communication. Resilience4j - Retry.
12min
200. @Retry annotation
2min
201. Aspect Order
3min
202. Configuration properties
3min
203. Trying how it works
4min

Section 28: Distributed Tracing with Sleuth and Zipkin
20min
204. Introduction to Distributed Tracing with Sleuth and Zipkin
3min
205. Add Spring Cloud Sleuth to Users Microservice
4min
206. Checking Trace ID and Span ID in a Console
5min
207. Startup Zipkin Server
2min
208. View Traces in Zipkin
5min

Section 29: Aggregating Log Files with ELK Stack
44min
209. Introduction to Aggregating Log Files with ELK Stack
2min
210. Configure Microservices to Log into a File
3min
211. Download Logstash
2min
212. Configure Logstash to Read Log Files
9min
213. [New]Download and Run Elasticsearch with Security Enabled
6min
214. [New]Configure Elasticsearch Security in Logstash
5min
215. Run Search Query
7min
216. [Updated]Download, Install and Run Kibana
5min
217. [Updated]View Aggregated Logs in Kibana
6min

Section 30: Secure Eureka Dashboard
25min
218. Source code
1min
219. Configure Spring Security to Eureka Server
2min
220. [Updated] Enable Web Security
5min
221. Configure Eureka Clients to use Username and Password
3min
222. Configure Eureka Service URL in Config Server
4min
223. Move Username and Password to Config Server
4min
224. Encrypting Username and Password
6min

Section 31: Running Microservices in Docker Containers to AWS EC2
3hr 9min
225. Introduction to Running Microservices in Docker Containers
8min
226. Start up a new Linux Server on AWS EC2
15min
227. Connect to EC2 Instance
5min
228. Docker Commands Used in this Video Course
1min
229. Install Docker on AWS EC2
2min
230. Docker Hub Introduction
2min
231. Run RabbitMQ Docker Container
9min
232. Basic Docker Commands: Run, Stop, Start, Remove Containers and Images
7min
233. Create Config Server Docker Image
10min
234. Publish Config Server Docker Image to Docker Hub
4min
235. Run Config Server on EC2 from Docker Hub
10min
236. Start New EC2 Instance for Eureka
3min
237. Build Docker Image for Eureka Discovery Service
4min
238. Run Eureka in Docker container
11min
239. Elastic IP address for EC2 Instance
5min
240. Create Zuul Api Gateway Docker Image
5min
241. Run Zuul Api Gateway in Docker Container
8min
242. Run Elastic Search in Docker container
6min
243. Run Kibana in Docker Container
7min
244. Run Kibana and Elastic Search on the same Network
5min
245. Docker Image for Albums Microservice
4min
246. Run Albums Microservice Docker Image on EC2
11min
247. Logstash Docker Image for Albums Microservice
9min
248. Run Logstash in Docker container
5min
249. Run MySQL in Docker Container
9min
250. Make MySQL Docker Container Persist Data on EC2
3min
251. Build Users Microservice Docker Image
4min
252. Run Users Microservice in Docker container
10min
253. Run Logstash for Users Microservice
8min

Section 32: Multiple Environments: Dev, Prod.
26min
254. Introduction
5min
255. Preparing Configuration for another environment
9min
256. Creating Beans Based on Spring Boot @Profile used
12min
257. Running Docker Container for Different Environments
1min

Section 33: Downstream Microservice and Method-Level Security
40min
258. Introduction
7min
259. Pass Authorization Header to Downstream Microservice
1min
260. Add AuthorizationFilter to Users Microservice
6min
261. Configure HttpSecurity
3min
262. Trying how it works
3min
263. Introduction to Method-Level security
5min
264. Enable Method-Level Security
2min
265. @PreAuthorize annotation example
4min
266. Trying how @PreAuthorize annotation works
3min
267. @PostAuthorize annotation example
7min

Section 34: What's next
2min
268. Bonus lecture
2min