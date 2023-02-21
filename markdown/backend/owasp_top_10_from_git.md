### OWASP Top 10 from github

[toc] 

#### API1:2019 Broken Object Level Authorization

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **3** : Detectability **2**                       | Technical **3** : Business Specific                          |
| Attackers can exploit API endpoints that are vulnerable to broken object level authorization by manipulating the ID of an object that is sent within the request. This may lead to unauthorized access to sensitive data. This issue is extremely common in API-based applications because the server component usually does not fully track the client’s state, and instead, relies more on parameters like object IDs, that are sent from the client to decide which objects to access. | This has been the most common and impactful attack on APIs. Authorization and access control mechanisms in modern applications are complex and wide-spread. Even if the application implements a proper infrastructure for authorization checks, developers might forget to use these checks before accessing a sensitive object. Access control detection is not typically amenable to automated static or dynamic testing. | Unauthorized access can result in data disclosure to unauthorized parties, data loss, or data manipulation. Unauthorized access to objects can also lead to full account takeover. |

**Is the API Vulnerable?**

Object level authorization is an access control mechanism that is usually implemented at the code level to validate that one user can only access objects that they should have access to.

Every API endpoint that receives an ID of an object, and performs any type of action on the object, should implement object level authorization checks. The checks should validate that the logged-in user does have access to perform the requested action on the requested object.

Failures in this mechanism typically leads to unauthorized information disclosure, modification, or destruction of all data.

**Example Attack Scenarios**

**Scenario #1**

An e-commerce platform for online stores (shops) provides a listing page with the revenue charts for their hosted shops. Inspecting the browser requests, an attacker can identify the API endpoints used as a data source for those charts and their pattern `/shops/{shopName}/revenue_data.json`. Using another API endpoint, the attacker can get the list of all hosted shop names. With a simple script to manipulate the names in the list, replacing `{shopName}` in the URL, the attacker gains access to the sales data of thousands of e-commerce stores.

**Scenario #2**

While monitoring the network traffic of a wearable device, the following HTTP `PATCH` request gets the attention of an attacker due to the presence of a custom HTTP request header `X-User-Id: 54796`. Replacing the `X-User-Id` value with `54795`, the attacker receives a successful HTTP response, and is able to modify other users' account data.

**How To Prevent**

* Implement a proper authorization mechanism that relies on the user policies and hierarchy.
* Use an authorization mechanism to check if the logged-in user has access to perform the requested action on the record in every function that uses an input from the client to access a record in the database.
* Prefer to use random and unpredictable values as GUIDs for records’ IDs.
* Write tests to evaluate the authorization mechanism. Do not deploy vulnerable changes that break the tests.

**References**

**External**

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html



---



#### API2:2019 Broken User Authentication

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **2** : Detectability **2**                       | Technical **3** : Business Specific                          |
| Authentication in APIs is a complex and confusing mechanism. Software and security engineers might have misconceptions about what are the boundaries of authentication and how to implement it correctly. In addition, the authentication mechanism is an easy target for attackers, since it’s exposed to everyone. These two points makes the authentication component potentially vulnerable to many exploits. | There are two sub-issues: 1. Lack of protection mechanisms: APIs endpoints that are responsible for authentication must be treated differently from regular endpoints and implement extra layers of protection 2. Misimplementation of the mechanism: The mechanism is used / implemented without considering the attack vectors, or it’s the wrong use case (e.g., an authentication mechanism designed for IoT clients might not be the right choice for web applications). | Attackers can gain control to other users’ accounts in the system, read their personal data, and perform sensitive actions on their behalf, like money transactions and sending personal messages. |

**Is the API Vulnerable?**

Authentication endpoints and flows are assets that need to be protected. “Forgot password / reset password” should be treated the same way as authentication mechanisms.

An API is vulnerable if it:
* Permits [credential stuffing][1] whereby the attacker has a list of valid
  usernames and passwords.
* Permits attackers to perform a brute force attack on the same user account, without
  presenting captcha/account lockout mechanism.
* Permits weak passwords.
* Sends sensitive authentication details, such as auth tokens and passwords in
  the URL.
* Doesn’t validate the authenticity of tokens.
* Accepts unsigned/weakly signed JWT tokens (`"alg":"none"`)/doesn’t
  validate their expiration date.
* Uses plain text, non-encrypted, or weakly hashed passwords.
* Uses weak encryption keys.

## Example Attack Scenarios

## Scenario #1

[Credential stuffing][1] (using [lists of known usernames/passwords][2]), is a
common attack. If an application does not implement automated threat or
credential stuffing protections, the application can be used as a password
oracle (tester) to determine if the credentials are valid.

## Scenario #2

An attacker starts the password recovery workflow by issuing a POST request to
`/api/system/verification-codes` and by providing the username in the request
body. Next an SMS token with 6 digits is sent to the victim’s phone. Because the
API does not implement a rate limiting policy, the attacker can test all
possible combinations using a multi-threaded script, against the
`/api/system/verification-codes/{smsToken}` endpoint to discover the right token
within a few minutes.

## How To Prevent

* Make sure you know all the possible flows to authenticate to the API (mobile/
  web/deep links that implement one-click authentication/etc.)
* Ask your engineers what flows you missed.
* Read about your authentication mechanisms. Make sure you understand what and
  how they are used. OAuth is not authentication, and neither is API keys.
* Don't reinvent the wheel in authentication, token generation, password
  storage. Use the standards.
* Credential recovery/forget password endpoints should be treated as login
  endpoints in terms of brute force, rate limiting, and lockout protections.
* Use the [OWASP Authentication Cheatsheet][3].
* Where possible, implement multi-factor authentication.
* Implement anti brute force mechanisms to mitigate credential stuffing,
  dictionary attack, and brute force attacks on your authentication endpoints.
  This mechanism should be stricter than the regular rate limiting mechanism on
  your API.
* Implement [account lockout][4] / captcha mechanism to prevent brute force
  against specific users. Implement weak-password checks.
* API keys should not be used for user authentication, but for [client app/
  project authentication][5].

## References

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### External

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html



---



API3:2019 Excessive Data Exposure
=================================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **2** : Detectability **2**                       | Technical **2** : Business Specific                          |
| Exploitation of Excessive Data Exposure is simple, and is usually performed by sniffing the traffic to analyze the API responses, looking for sensitive data exposure that should not be returned to the user. | APIs rely on clients to perform the data filtering. Since APIs are used as data sources, sometimes developers try to implement them in a generic way without thinking about the sensitivity of the exposed data. Automatic tools usually can’t detect this type of vulnerability because it’s hard to differentiate between legitimate data returned from the API, and sensitive data that should not be returned without a deep understanding of the application. | Excessive Data Exposure commonly leads to exposure of sensitive data. |

## Is the API Vulnerable?

The API returns sensitive data to the client by design. This data is usually
filtered on the client side before being presented to the user. An attacker can
easily sniff the traffic and see the sensitive data.

## Example Attack Scenarios

### Scenario #1

The mobile team uses the `/api/articles/{articleId}/comments/{commentId}`
endpoint in the articles view to render comments metadata. Sniffing the mobile
application traffic, an attacker finds out that other sensitive data related to
comment’s author is also returned. The endpoint implementation uses a generic
`toJSON()` method on the `User` model, which contains PII, to serialize the
object.

### Scenario #2

An IOT-based surveillance system allows administrators to create users with
different permissions. An admin created a user account for a new security guard
that should only have access to specific buildings on the site. Once the
security guard uses his mobile app, an API call is triggered to:
`/api/sites/111/cameras` in order to receive data about the available cameras
and show them on the dashboard. The response contains a list with details about
cameras in the following format:
`{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
While the client GUI shows only cameras which the security guard should have
access to, the actual API response contains a full list of all the cameras in
the site.

## How To Prevent

* Never rely on the client side to filter sensitive data.
* Review the responses from the API to make sure they contain only legitimate
  data.
* Backend engineers should always ask themselves "who is the
  consumer of the data?" before exposing a new API endpoint.
* Avoid using generic methods such as `to_json()` and `to_string()`.
  Instead, cherry-pick specific properties you really want to return
* Classify sensitive and personally identifiable information (PII) that
  your application stores and works with, reviewing all API calls returning such
  information to see if these responses pose a security issue.
* Implement a schema-based response validation mechanism as an extra layer of
  security. As part of this mechanism define and enforce data returned by all
  API methods, including errors.


## References

### External

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html



---



API4:2019 Lack of Resources & Rate Limiting
===========================================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **2**                          | Prevalence **3** : Detectability **3**                       | Technical **2** : Business Specific                          |
| Exploitation requires simple API requests. No authentication is required. Multiple concurrent requests can be performed from a single local computer or by using cloud computing resources. | It’s common to find APIs that do not implement rate limiting or APIs where limits are not properly set. | Exploitation may lead to DoS, making the API unresponsive or even unavailable. |

## Is the API Vulnerable?

API requests consume resources such as network, CPU, memory, and storage. The
amount of resources required to satisfy a request greatly depends on the user
input and endpoint business logic. Also, consider the fact that requests from
multiple API clients compete for resources. An API is vulnerable if at least one
of the following limits is missing or set inappropriately (e.g., too low/high):

* Execution timeouts
* Max allocable memory
* Number of file descriptors
* Number of processes
* Request payload size (e.g., uploads)
* Number of requests per client/resource
* Number of records per page to return in a single request response

## Example Attack Scenarios

### Scenario #1

An attacker uploads a large image by issuing a POST request to `/api/v1/images`.
When the upload is complete, the API creates multiple thumbnails with different
sizes. Due to the size of the uploaded image, available memory is exhausted
during the creation of thumbnails and the API becomes unresponsive.

### Scenario #2

We have an application that contains the users' list on a UI with a limit of
`200` users per page. The users' list is retrieved from the server using the
following query: `/api/users?page=1&size=200`. An attacker changes the `size`
parameter to `200 000`, causing performance issues on the database. Meanwhile,
the API becomes unresponsive and is unable to handle further requests from this
or any other clients (aka DoS).

The same scenario might be used to provoke Integer Overflow or Buffer Overflow
errors.

## How To Prevent

* Docker makes it easy to limit [memory][1], [CPU][2], [number of restarts][3],
  [file descriptors, and processes][4].
* Implement a limit on how often a client can call the API within a defined
  timeframe.
* Notify the client when the limit is exceeded by providing the limit number and
  the time at which the limit will be reset.
* Add proper server-side validation for query string and request body
  parameters, specifically the one that controls the number of records to be
  returned in the response.
* Define and enforce maximum size of data on all incoming parameters and
  payloads such as maximum length for strings and maximum number of elements in
  arrays.


## References

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### External

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf



---



API5:2019 Broken Function Level Authorization
=============================================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **2** : Detectability **1**                       | Technical **2** : Business Specific                          |
| Exploitation requires the attacker to send legitimate API calls to the API endpoint that they should not have access to. These endpoints might be exposed to anonymous users or regular, non-privileged users. It’s easier to discover these flaws in APIs since APIs are more structured, and the way to access certain functions is more predictable (e.g., replacing the HTTP method from GET to PUT, or changing the “users” string in the URL to "admins"). | Authorization checks for a function or resource are usually managed via configuration, and sometimes at the code level. Implementing proper checks can be a confusing task, since modern applications can contain many types of roles or groups and complex user hierarchy (e.g., sub-users, users with more than one role). | Such flaws allow attackers to access unauthorized functionality. Administrative functions are key targets for this type of attack. |

## Is the API Vulnerable?

The best way to find broken function level authorization issues is to perform
deep analysis of the authorization mechanism, while keeping in mind the user
hierarchy, different roles or groups in the application, and asking the
following questions:

* Can a regular user access administrative endpoints?
* Can a user perform sensitive actions (e.g., creation, modification, or
  erasure) that they should not have access to by simply changing the HTTP
  method (e.g., from `GET` to `DELETE`)?
* Can a user from group X access a function that should be exposed only to users
  from group Y, by simply guessing the endpoint URL and parameters (e.g.,
  `/api/v1/users/export_all`)?

Don’t assume that an API endpoint is regular or administrative only based on the
URL path.

While developers might choose to expose most of the administrative endpoints
under a specific relative path, like `api/admins`, it’s very common to find
these administrative endpoints under other relative paths together with regular
endpoints, like `api/users`.

## Example Attack Scenarios

### Scenario #1

During the registration process to an application that allows only invited users
to join, the mobile application triggers an API call to
`GET /api/invites/{invite_guid}`. The response contains a JSON with details
about the invite, including the user’s role and the user’s email.

An attacker duplicated the request and manipulated the HTTP method and endpoint
to `POST /api/invites/new`. This endpoint should only be accessed by
administrators using the admin console, which does not implement function level
authorization checks.

The attacker exploits the issue and sends himself an invite to create an
admin account:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Scenario #2

An API contains an endpoint that should be exposed only to administrators -
`GET /api/admin/v1/users/all`. This endpoint returns the details of all the
users of the application and does not implement function-level authorization
checks. An attacker who learned the API structure takes an educated guess and
manages to access this endpoint, which exposes sensitive details of the users of
the application.

## How To Prevent

Your application should have a consistent and easy to analyze authorization
module that is invoked from all your business functions. Frequently, such
protection is provided by one or more components external to the application
code.

* The enforcement mechanism(s) should deny all access by default, requiring
  explicit grants to specific roles for access to every function.
* Review your API endpoints against function level authorization flaws, while
  keeping in mind the business logic of the application and groups hierarchy.
* Make sure that all of your administrative controllers inherit from an
  administrative abstract controller that implements authorization checks based
  on the user’s group/role.
* Make sure that administrative functions inside a regular controller implements
  authorization checks based on the user’s group and role.

## References

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### External

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html



---



API6:2019 - Mass Assignment
===========================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **2**                          | Prevalence **2** : Detectability **2**                       | Technical **2** : Business Specific                          |
| Exploitation usually requires an understanding of the business logic, objects' relations, and the API structure. Exploitation of mass assignment is easier in APIs, since by design they expose the underlying implementation of the application along with the properties’ names. | Modern frameworks encourage developers to use functions that automatically bind input from the client into code variables and internal objects. Attackers can use this methodology to update or overwrite sensitive object’s properties that the developers never intended to expose. | Exploitation may lead to privilege escalation, data tampering, bypass of security mechanisms, and more. |

## Is the API Vulnerable?

Objects in modern applications might contain many properties. Some of these
properties should be updated directly by the client (e.g., `user.first_name` or
`user.address`) and some of them should not (e.g., `user.is_vip` flag).

An API endpoint is vulnerable if it automatically converts client parameters
into internal object properties, without considering the sensitivity and the
exposure level of these properties. This could allow an attacker to update
object properties that they should not have access to.

Examples for sensitive properties:

* **Permission-related properties**: `user.is_admin`, `user.is_vip` should only
  be set by admins.
* **Process-dependent properties**: `user.cash` should only be set internally
  after payment verification.
* **Internal properties**: `article.created_time` should only be set internally
  by the application.

## Example Attack Scenarios

### Scenario #1

A ride sharing application provides a user the option to edit basic information
for their profile. During this process, an API call is sent to
`PUT /api/v1/users/me` with the following legitimate JSON object:

```json
{"user_name":"inons","age":24}
```

The request `GET /api/v1/users/me` includes an additional credit_balance
property:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

The attacker replays the first request with the following payload:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Since the endpoint is vulnerable to mass assignment, the attacker receives
credits without paying.

### Scenario #2

A video sharing portal allows users to upload content and download content in
different formats. An attacker who explores the API found that the endpoint
`GET /api/v1/videos/{video_id}/meta_data` returns a JSON object with the video’s
properties. One of the properties is `"mp4_conversion_params":"-v codec h264"`,
which indicates that the application uses a shell command to convert the video.

The attacker also found the endpoint `POST /api/v1/videos/new` is vulnerable to
mass assignment and allows the client to set any property of the video object.
The attacker sets a malicious value as follows:
`"mp4_conversion_params":"-v codec h264 && format C:/"`. This value will cause a
shell command injection once the attacker downloads the video as MP4.

## How To Prevent

* If possible, avoid using functions that automatically bind a client’s input
  into code variables or internal objects.
* Whitelist only the properties that should be updated by the client.
* Use built-in features to blacklist properties that should not be accessed by
  clients.
* If applicable, explicitly define and enforce schemas for the input data
  payloads.

## References

### External

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html



---



API7:2019 Security Misconfiguration
===================================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **3** : Detectability **3**                       | Technical **2** : Business Specific                          |
| Attackers will often attempt to find unpatched flaws, common endpoints, or unprotected files and directories to gain unauthorized access or knowledge of the system. | Security misconfiguration can happen at any level of the API stack, from the network level to the application level. Automated tools are available to detect and exploit misconfigurations such as unnecessary services or legacy options. | Security misconfigurations can not only expose sensitive user data, but also system details that may lead to full server compromise. |

## Is the API Vulnerable?

The API might be vulnerable if:

* Appropriate security hardening is missing across any part of the application
  stack, or if it has improperly configured permissions on cloud services.
* The latest security patches are missing, or the systems are out of date.
* Unnecessary features are enabled (e.g., HTTP verbs).
* Transport Layer Security (TLS) is missing.
* Security directives are not sent to clients (e.g., [Security Headers][1]).
* A Cross-Origin Resource Sharing (CORS) policy is missing or improperly set.
* Error messages include stack traces, or other sensitive information is
  exposed.

## Example Attack Scenarios

### Scenario #1

An attacker finds the `.bash_history` file under the root directory of the
server, which contains commands used by the DevOps team to access the API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

An attacker could also find new endpoints on the API that are used only by the
DevOps team and are not documented.

### Scenario #2

To target a specific service, an attacker uses a popular search engine to search
for  computers directly accessible from the Internet. The attacker found a host
running a popular database management system, listening on the default port. The
host was using the default configuration, which has authentication disabled by
default, and the attacker gained access to millions of records with PII,
personal preferences, and authentication data.

### Scenario #3

Inspecting traffic of a mobile application an attacker finds out that not all
HTTP traffic is performed on a secure protocol (e.g., TLS). The attacker finds
this to be true, specifically for the download of profile images. As user
interaction is binary, despite the fact that API traffic is performed on a
secure protocol, the attacker finds a pattern on API responses size, which he
uses to track user preferences over the rendered content (e.g., profile images).

## How To Prevent

The API life cycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment.
* A task to review and update configurations across the entire API stack. The
  review should include: orchestration files, API components, and cloud services
  (e.g., S3 bucket permissions).
* A secure communication channel for all API interactions access to static
  assets (e.g., images).
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments.

Furthermore:

* To prevent exception traces and other valuable information from being sent
  back to attackers, if applicable, define and enforce all API response payload
  schemas including error responses.
* Ensure API can only be accessed by the specified HTTP verbs. All other HTTP
  verbs should be disabled (e.g. `HEAD`).
* APIs expecting to be accessed from browser-based clients (e.g., WebApp
  front-end) should implement a proper Cross-Origin Resource Sharing (CORS)
  policy.

## References

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### External

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)



---



API8:2019 Injection
===================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **2** : Detectability **3**                       | Technical **3** : Business Specific                          |
| Attackers will feed the API with malicious data through whatever injection vectors are available (e.g., direct input, parameters, integrated services, etc.), expecting it to be sent to an interpreter. | Injection flaws are very common and are often found in SQL, LDAP, or NoSQL queries, OS commands, XML parsers, and ORM. These flaws are easy to discover when reviewing the source code. Attackers can use scanners and fuzzers. | Injection can lead to information disclosure and data loss. It may also lead to DoS, or complete host takeover. |

## Is the API Vulnerable?

The API is vulnerable to injection flaws if:

* Client-supplied data is not validated, filtered, or sanitized by the API.
* Client-supplied data is directly used or concatenated to SQL/NoSQL/LDAP
  queries, OS commands, XML parsers, and Object Relational Mapping (ORM)/Object
  Document Mapper (ODM).
* Data coming from external systems (e.g., integrated systems) is not validated,
  filtered, or sanitized by the API.

## Example Attack Scenarios

### Scenario #1

Firmware of a parental control device provides the endpoint
`/api/CONFIG/restore` which expects an appId to be sent as a multipart
parameter. Using a decompiler, an attacker finds out that the appId is passed
directly into a system call without any sanitization:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

The following command allows the attacker to shut down any device with the same
vulnerable firmware:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Scenario #2

We have an application with basic CRUD functionality for operations with
bookings. An attacker managed to identify that NoSQL injection might be possible
through `bookingId` query string parameter in the delete booking request. This
is how the request looks like: `DELETE /api/bookings?bookingId=678`.

The API server uses the following function to handle delete requests:

```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

The attacker intercepted the request and changed `bookingId` query string
parameter as shown below. In this case, the attacker managed to delete another
user's booking:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## How To Prevent

Preventing injection requires keeping data separate from commands and queries.

* Perform data validation using a single, trustworthy, and actively maintained
  library.
* Validate, filter, and sanitize all client-provided data, or other data coming
  from integrated systems.
* Special characters should be escaped using the specific syntax for the target
  interpreter.
* Prefer a safe API that provides a parameterized interface.
* Always limit the number of returned records to prevent mass disclosure in case
  of injection.
* Validate incoming data using sufficient filters to only allow valid values for
  each input parameter.
* Define data types and strict patterns for all string parameters.

## References

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### External

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html



---



API9:2019 Improper Assets Management
====================================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **3**                          | Prevalence **3** : Detectability **2**                       | Technical **2** : Business Specific                          |
| Old API versions are usually unpatched and are an easy way to compromise systems without having to fight state-of-the-art security mechanisms, which might be in place to protect the most recent API versions. | Outdated documentation makes it more difficult to find and/or fix vulnerabilities. Lack of assets inventory and retire strategies leads to running unpatched systems, resulting in leakage of sensitive data. It’s common to find unnecessarily exposed API hosts because of modern concepts like microservices, which make applications easy to deploy and independent (e.g., cloud computing, k8s). | Attackers may gain access to sensitive data, or even takeover the server through old, unpatched API versions connected to the same database. |

## Is the API Vulnerable?

The API might be vulnerable if:

* The purpose of an API host is unclear, and there are no explicit answers to
  the following questions:
  * Which environment is the API running in (e.g., production, staging, test,
    development)?
  * Who should have network access to the API (e.g., public, internal, partners)?
  * Which API version is running?
  * What data is gathered and processed by the API (e.g., PII)?
  * What's the data flow?
* There is no documentation, or the existing documentation is not updated.
* There is no retirement plan for each API version.
* Hosts inventory is missing or outdated.
* Integrated services inventory, either first- or third-party, is missing or
  outdated.
* Old or previous API versions are running unpatched.

## Example Attack Scenarios

### Scenario #1

After redesigning their applications, a local search service left an old API
version (`api.someservice.com/v1`) running, unprotected, and with access to the
user database. While targeting one of the latest released applications, an
attacker found the API address (`api.someservice.com/v2`). Replacing `v2` with
`v1` in the URL gave the attacker access to the old, unprotected API,
exposing the personal identifiable information (PII) of over 100 Million users.

### Scenario #2

A social network implemented a rate-limiting mechanism that blocks attackers
from using brute-force to guess reset password tokens. This mechanism wasn’t
implemented as part of the API code itself, but in a separate component between
the client and the official API (`www.socialnetwork.com`).
A researcher found a beta API host (`www.mbasic.beta.socialnetwork.com`) that
runs the same API, including the reset password mechanism, but the rate limiting
mechanism was not in place. The researcher was able to reset the password of any
user by using a simple brute-force to guess the 6 digits token.

## How To Prevent

* Inventory all API hosts and document important aspects of each one of them,
  focusing on the API environment (e.g., production, staging, test,
  development), who should have network access to the host (e.g., public,
  internal, partners) and the API version.
* Inventory integrated services and document important aspects such as their
  role in the system, what data is exchanged (data flow), and its sensitivity.
* Document all aspects of your API such as authentication, errors, redirects,
  rate limiting, cross-origin resource sharing (CORS) policy and endpoints,
  including their parameters, requests, and responses.
* Generate documentation automatically by adopting open standards. Include the
  documentation build in your CI/CD pipeline.
* Make API documentation available to those authorized to use the API.
* Use external protection measures such as API security firewalls for all exposed versions of your APIs, not just for the current production version.
* Avoid using production data with non-production API deployments. If this is unavoidable, these endpoints should get the same security treatment as the production ones.
* When newer versions of APIs include security improvements, perform risk analysis to make the decision of the mitigation actions required for the older version: for example, whether it is possible to backport the improvements without breaking API compatibility or you need to take the older version out quickly and force all clients to move to the latest version.

## References

### External

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/



---



API10:2019 Insufficient Logging & Monitoring
============================================

| Threat agents/Attack vectors                                 | Security Weakness                                            | Impacts                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| API Specific : Exploitability **2**                          | Prevalence **3** : Detectability **1**                       | Technical **2** : Business Specific                          |
| Attackers take advantage of lack of logging and monitoring to abuse systems without being noticed. | Without logging and monitoring, or with insufficient logging and monitoring, it is almost impossible to track suspicious activities and respond to them in a timely fashion. | Without visibility over on-going malicious activities, attackers have plenty of time to fully compromise systems. |

## Is the API Vulnerable?

The API is vulnerable if:

* It does not produce any logs, the logging level is not set correctly, or log
  messages do not include enough detail.
* Log integrity is not guaranteed (e.g., [Log Injection][1]).
* Logs are not continuously monitored.
* API infrastructure is not continuously monitored.

## Example Attack Scenarios

### Scenario #1

Access keys of an administrative API were leaked on a public repository. The
repository owner was notified by email about the potential leak, but took more
than 48 hours to act upon the incident, and access keys exposure may have
allowed access to sensitive data. Due to insufficient logging, the company is
not able to assess what data was accessed by malicious actors.

### Scenario #2

A video-sharing platform was hit by a “large-scale” credential stuffing attack.
Despite failed logins being logged, no alerts were triggered during the timespan
of the attack. As a reaction to user complaints, API logs were analyzed and the
attack was detected. The company had to make a public announcement asking users
to reset their passwords, and report the incident to regulatory authorities.

## How To Prevent

* Log all failed authentication attempts, denied access, and input validation
  errors.
* Logs should be written using a format suited to be consumed by a log
  management solution, and should include enough detail to identify the
  malicious actor.
* Logs should be handled as sensitive data, and their integrity should be
  guaranteed at rest and transit.
* Configure a monitoring system to continuously monitor the infrastructure,
  network, and the API functioning.
* Use a Security Information and Event Management (SIEM) system to aggregate and
  manage logs from all components of the API stack and hosts.
* Configure custom dashboards and alerts, enabling suspicious activities to be
  detected and responded to earlier.

## References

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### External

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html