# Protocols After covering integration styles, exchange formats, query

We now turn our focus to the protocols that enable systems to communicate
effectively. Protocols define the rules for how data is exchanged between
different systems, ensuring that communication is standardized and reliable.
Each of these protocols has its own strengths, historical context, and specific
use cases. By understanding their theoretical foundations and practical
applications, we can appreciate their roles in the broader landscape of system
integration.

## Historical background of protocols

1. **Early Approaches: CORBA and RPC**

   Before the rise of **web-based protocols**, systems relied on protocols like
   **CORBA (Common Object Request Broker Architecture)** and **RPC (Remote
   Procedure Call)** to enable communication across different software
   components.

   - **RPC (1980s)**: **Remote Procedure Call (RPC)** are a method used for
     executing procedures (functions) on remote systems. In languages like **C**
     and **Java**, RPC allows developers to invoke functions on another machine,
     passing parameters and receiving return values as if the call was made
     locally. **Java RMI (Remote Method Invocation)** is one popular
     implementation of RPC, allowing Java objects to communicate across the
     network. However, RPC ios tightly coupled to specific implementations, and
     scaling becomes challenging in highly distributed systems.

   - **CORBA (1991)**: Developed by the **Object Management Group (OMG)**,
     CORBA was a key player in the early days of **distributed computing**. CORBA
     enables communication between systems written in different programming
     languages by defining a common interface through an Interface Definition
     Language (IDL). Using this interface, CORBA provides location transparency,
     allowing clients to invoke methods on remote objects as if they were local.
     It supports multiple transport protocols and focused on achieving high
     levels of interoperability across heterogeneous systems.

   Although powerful, both CORBA and RPC are complex to implement and
   maintain, especially in large-scale, heterogeneous environments. As the
   internet grew and web technologies matured, there was a need for simpler,
   more flexible protocols.

2. **SOAP (1998)**: SOAP emerged as the next step in creating a standardized,
   platform-independent protocol for **web services**. Developed by **Microsoft**
   and later standardized by the **World Wide Web Consortium (W3C)**, SOAP offered
   a formal way of structuring messages using **XML**. SOAP was designed to be
   transport-independent (working over **HTTP**, **SMTP**, etc.) and provided
   built-in support for **security**, **reliability**, and **transactionality**,
   making it ideal for enterprise applications.

   SOAP relies on **WSDL (Web Services Description Language)** to describe the
   operations and structure of the messages that can be exchanged, ensuring a
   contract-driven approach. SOAP's heavy reliance on XML and its rigorous
   specifications made it robust for secure environments, but also more complex
   to use, leading developers to seek lighter alternatives.

3. **REST (2000)**: In contrast to SOAP’s complexity, **REST** was introduced
   as a lightweight, scalable alternative, championed by **Roy Fielding** in his
   PhD thesis titled "Architectural Styles and the Design of Network-based
   Software Architectures" [1]. REST leverages the core principles of the
   World Wide Web and HTTP to provide a simpler and more flexible method
   for building web services. REST views data as **resources** that can be
   manipulated using standard HTTP methods (GET, POST, PUT,
   DELETE), with each resource being identified by a URI.

   REST focuses on stateless communication, where each client request
   contains all the information necessary to process the request, allowing for
   scalability and decoupling between client and server. REST’s popularity grew
   rapidly, especially in web development and the creation of APIs, due to
   its simplicity, use of lightweight formats like JSON, and ability to
   scale across distributed environments.

4. **OData (2007)**: **OData (Open Data Protocol)** was developed by
   Microsoft to extend the principles of REST by adding advanced querying
   capabilities. OData allows for data-driven communication over HTTP,
   providing a uniform method to query, manipulate, and expose data through
   RESTful APIs. With its ability to handle complex data models and relationships,
   OData quickly became a powerful tool in enterprise applications, such as
   Microsoft Dynamics and SAP.

   OData goes beyond basic REST operations by introducing query features like
   `$filter`, `$orderby`, and `$expand`, as well as metadata that describes the
   structure of the data. This makes OData particularly useful for systems
   where complex queries and large datasets need to be managed
   efficiently.

### Overview of SOAP, REST, and OData

- **SOAP**: SOAP is a formal protocol designed for secure, reliable,
  and transactional communication in enterprise environments. It uses XML
  for messaging and relies on WSDL to define the operations and message
  formats. SOAP is often used in industries where compliance, security, and
  reliability are paramount, such as finance, healthcare, and
  government services.

- **REST**: REST is an architectural style that leverages the web and HTTP
  to build scalable, lightweight services. It emphasizes simplicity,
  statelessness, and resource-based interaction through URIs. REST is commonly
  used in modern web APIs, and its flexibility allows for the exchange of
  data in various formats, such as JSON and XML.

- OData: OData extends REST by adding more advanced querying and data
  manipulation features. It provides built-in support for metadata and
  exposes complex data models, allowing clients to query and retrieve relational
  data over HTTP. OData is commonly used in data-centric systems where rich
  querying capabilities are needed, such as enterprise applications and
  business intelligence tools.

In the following we will explore REST and OData in more detail.

## REST: Representational State Transfer

**REST (Representational State Transfer)** is an architectural style that
defines a set of constraints for designing distributed systems, particularly
web services. REST was introduced by **Roy Fielding** in his PhD dissertation
[1] in 2000, where he outlined how the principles of the World Wide Web (WWW)
could be applied to the design of scalable, maintainable, and flexible
distributed systems. Today, REST is the foundation for a vast majority of
modern Web APIs, due to its simplicity, flexibility, and scalability.

### Key Principles of REST

REST is defined by a set of guiding principles that distinguish it from other
approaches like SOAP or CORBA. These principles are fundamental for
understanding how RESTful services work and why they are widely adopted.

1. **Client-Server Architecture**: REST enforces a **separation of concerns**
   between the client and the server. The client is responsible for the user
   interface, while the server handles the data and logic. This separation allows
   both client and server to evolve independently, improving scalability and
   maintainability.

2. **Statelessness**: Each request from the client to the server must contain
   all the information needed to understand and process the request. The server
   does not store any client context between requests. This makes the system more
   scalable because it simplifies the server's responsibility.

3. **Cacheability**: Responses from the server must define whether they are
   cacheable. When a response is marked as cacheable, clients and
   intermediaries can reuse the response data for subsequent requests, reducing
   the need for repeated interactions and improving performance.

4. **Uniform Interface**: The uniform interface simplifies the consumption of
   services. It consists of the following aspects:

   1. **Resource-Based**: In REST, everything is treated as a **resource** that
      can be identified using a
      [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) (Uniform
      Resource Identifier). A resource could be anything — a document, an image, a
      user, a product, or any other entity that needs to be accessed. These
      resources are manipulated using standard HTTP methods:

      - **GET**: Retrieve a representation of the resource.
      - **POST**: Create a new resource.
      - **PUT**: Update an existing resource.
      - **DELETE**: Remove a resource.

   2. **Representation**: Clients interact with resources using their
      representation. A resource is represented in different formats (such as
      **JSON**, **XML**, **HTML**). The client requests a specific representation,
      and the server delivers it using [content
      negotiation](https://en.wikipedia.org/wiki/Content_negotiation) (e.g.,
      specifying the `Accept` header).
   3. **HATEOAS (Hypermedia as the Engine of Application State)**: RESTful
      services should be **self-descriptive**. This means that clients interact
      with the service by following **hyperlinks** provided in the responses,
      enabling dynamic discovery of resources and actions. HATEOAS ensures that
      the client can navigate through the application by exploring the hypermedia
      controls.

5. **Layered System**: REST allows a layered architecture, where different
   components (e.g., proxy servers, load balancers) can be added between the
   client and server. This abstraction provides intermediary servers that can
   improve performance, security, and scalability without affecting the
   client-server interaction.

### RESTful API Example

Consider a REST API for a product catalog:

- **GET /products**: Retrieve a list of products.
- **GET /products/1**: Retrieve the product with ID 1.
- **POST /products**: Create a new product by sending the product details in the request body.
- **PUT /products/1**: Update the product with ID 1 by sending the updated product data in the request body.
- **DELETE /products/1**: Delete the product with ID 1.

Here’s an example of an HTTP request and response for **GET /products/1**:

**Request:**

```http
GET /products/1 HTTP/1.1
Host: api.example.com
Accept: application/json
```

**Response:**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "Mountain Bike",
  "price": 1200,
  "category": "Sports"
}
```

This request retrieves the product with ID 1, represented in **JSON** format.

### Exercise: Interacting with RESTful APIs

In this exercise, you will interact with real-world REST APIs to perform GET,
POST, PUT, and DELETE requests using tools such as
[Postman](https://www.postman.com/), [httpie](https://httpie.io/), or a web
browser.

#### Step 1: Exploring REST APIs with GET Requests

Use the public REST API offered by [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
to retrieve data.

1. **Accessing a Public API**:

   - Visit the following URL in your browser or Postman to retrieve a list of
     posts: `http GET https://jsonplaceholder.typicode.com/posts`
   - In Postman or httpie: `bash http GET
https://jsonplaceholder.typicode.com/posts`

2. **Retrieving a Specific Resource**: Retrieve a specific post by appending
   the ID of the post:

   `http GET https://jsonplaceholder.typicode.com/posts/1`

#### Step 2: Creating a New Resource with POST

1. **Using POST to Add a New Post**:

   - In Postman or httpie, create a new post:

   ```bash
   http POST https://jsonplaceholder.typicode.com/posts \
   title="New Post" \
   body="This is the content of the new post" userId=1
   ```

   - This will create a new resource and return the new post as a response.

2. **Viewing the Created Resource**:
   - After creating the post, retrieve it using a `GET` request: `http GET
https://jsonplaceholder.typicode.com/posts/{id} p`

#### Step 3: Updating a Resource with PUT

1. **Updating a Post**:

   - In Postman or httpie, update an existing post:

   ```bash
   http PUT https://jsonplaceholder.typicode.com/posts/1 \
   title="Updated Title" body="Updated content" userId=1
   ```

2. **Verifying the Update**:
   - Retrieve the updated post and verify that the changes have been applied.

#### Step 4: Deleting a Resource with DELETE

1. **Deleting a Post**:

   - Use the `DELETE` method to remove a specific post:

   ```bash
   http DELETE https://jsonplaceholder.typicode.com/posts/1
   ```

2. **Confirming Deletion**:
   - Attempt to retrieve the deleted post, and the server should return a `404
Not Found` error.

#### Advanced: Exploring REST API Documentation

Many RESTful APIs offer detailed documentation that explains available
endpoints, parameters, and data models. Explore the documentation for:

- **GitHub API**: [GitHub REST API](https://docs.github.com/en/rest)
- **OpenWeatherMap API**: [OpenWeatherMap API Docs](https://openweathermap.org/api)

## OData: Open Data Protocol

While REST has become the dominant architectural style for building web APIs
due to its simplicity, scalability, and flexibility, it does have some
limitations, particularly when dealing with data-centric applications. As
enterprise systems grow in complexity, the need for more advanced data
querying, relationships between entities, and dynamic interaction between
clients and services has exposed gaps in REST's capabilities.

OData (Open Data Protocol) was developed to address some of the shortcomings of
REST, particularly in scenarios where more sophisticated data handling is
required. OData extends the principles of REST and adds standardized querying,
metadata exposure, and data manipulation capabilities that make it better
suited for enterprise environments.

### Shortcomings of REST

1. **Limited Querying Capabilities**: One of the major limitations of REST in
   data-driven applications is its lack of standardized querying mechanisms.
   While REST allows you to retrieve resources using HTTP GET requests, it doesn't
   provide a built-in way to filter, sort, or paginate data across complex
   datasets. Developers often resort to custom query parameters (e.g.,
   `?filter=...`, `?sort=...`), leading to inconsistent implementations and
   additional overhead in building and maintaining APIs.

   - **OData's Solution**: OData introduces a powerful **query language** on
     top of REST. This query language allows clients to filter, sort, and
     paginate data using standardized URI conventions, such as:
     - `$filter`: Filter results (e.g., `$filter=price gt 100`).
     - `$orderby`: Sort results (e.g., `$orderby=name desc`).
     - `$top` and `$skip`: Paginate results (e.g., `$top=10&$skip=20`).
     - `$expand`: Retrieve related entities (e.g., `$expand=category`).

   These standardized options eliminate the need for custom query logic and
   provide a consistent way to interact with data services.

2. **Lack of Standard Metadata Exposure**: REST APIs do not natively expose
   metadata describing the structure of the resources they serve. In many
   cases, developers must rely on external documentation to understand the
   available endpoints, fields, and relationships between resources. This limits
   the ability of clients to dynamically discover and interact with the API.

   - **OData's Solution**: OData services expose a **metadata document**
     (`$metadata`) that provides a detailed description of the data model,
     including entity types, relationships, and data types. This metadata is
     machine-readable, allowing clients to dynamically generate code or queries
     based on the service’s structure without requiring hardcoded knowledge. For
     example: `http GET /odata/v1/$metadata` This self-describing nature of
     OData services makes them more flexible and adaptable to changes in the data
     model over time.

3. **Handling Relationships Between Resources**: REST APIs generally treat
   resources as independent entities. While it is possible to model relationships
   between resources in REST (e.g., linking products to categories), there is no
   standardized way to retrieve related entities in a single request. This often
   leads to **over-fetching** (retrieving more data than needed) or
   **under-fetching** (requiring multiple requests to gather all relevant data).

   - **OData's Solution**: OData allows you to **expand related entities** in
     a single request using the `$expand` query option. This feature enables
     clients to retrieve not only the main resource but also its related data
     without the need for additional requests. For example, you can retrieve
     products and their associated categories in one call: `http GET
/odata/v1/Products?$expand=category` This reduces the number of
     round-trips between the client and server, improving performance and
     reducing complexity in client-side code.

4. **Inconsistent Pagination and Sorting**: In REST, there is no standard way
   to paginate or sort results across different APIs. While many APIs implement
   pagination using query parameters like `?page=1&size=20`, there is no
   uniformity, which leads to inconsistent behavior across APIs. Sorting is also
   handled inconsistently, often requiring custom query strings.

   - **OData's Solution**: OData introduces a standardized approach to
     pagination using the `$top` and `$skip` parameters. These options enable
     clients to consistently retrieve subsets of data across different services.
     Similarly, `$orderby` provides a consistent mechanism for sorting results
     based on any field, such as sorting products by price or name: `http GET
/odata/v1/Products?$orderby=price desc`

5. **Batching Multiple Requests**: REST APIs generally handle one request at a
   time. In cases where clients need to perform multiple actions (e.g., creating,
   updating, and deleting resources), they must make multiple HTTP calls, which
   can be inefficient. Each call involves network latency and resource
   consumption, especially in scenarios with high-volume operations.

   - **OData's Solution**: OData supports **batch requests**, allowing clients
     to group multiple requests into a single HTTP call. This reduces the number
     of round-trips and optimizes communication, particularly in scenarios where
     multiple related operations need to be performed together. For example, a
     client can batch several product updates into one request: `http POST
/odata/v1/$batch`

### Key Problems Solved by OData

In summary, **OData** addresses several critical shortcomings of **REST** in
data-driven applications:

- **Standardized Query Language**: OData provides a unified, powerful query
  language that allows clients to filter, sort, and paginate data consistently
  across different APIs.
- **Metadata Exposure**: OData's `$metadata` endpoint allows clients to
  dynamically understand the data model, enabling better adaptability and
  reducing the need for extensive external documentation.
- **Handling Complex Relationships**: OData simplifies working with related
  entities by allowing clients to expand related data in a single request.
- **Consistent Pagination and Sorting**: OData introduces consistent URI
  conventions for pagination (`$top`, `$skip`) and sorting (`$orderby`), ensuring
  uniform behavior across services.
- **Batching**: OData supports batch requests, reducing network overhead and
  improving performance in scenarios where multiple operations need to be
  processed.

---

### Practical Exercise: Querying and Manipulating Data with OData

In this exercise, students will interact with a public **OData service** to explore how OData improves on REST by providing powerful querying and data manipulation capabilities.

#### Tools to Use:

- **Postman**: A popular API testing tool that supports OData.
- **httpie**: A command-line tool for interacting with OData services.
- **Browser**: Simple OData queries can be performed directly in a web browser.

#### Step 1: Exploring an OData Service

Use the **TripPin OData Service** provided by Microsoft to practice querying and manipulating data.

- **Service Root URL**:
  ```http
  GET https://services.odata.org/TripPinRESTierService/(S(lgcsd54pv5tw2wtewk0rzauf))/People
  ```

1. **Retrieve All People**:  
   Retrieve a list of all people:

   ```http
   GET https://services.odata.org/TripPinRESTierService/(S(lgcsd54pv5tw2wtewk0rzauf))/People
   ```

2. **Filter by Last Name**:  
   Retrieve people whose last name is "Smith":

   ```http
   GET https://services.odata.org/TripPinRESTierService/(S(lgcsd54pv5tw2wtewk0rzauf))/People?$filter=LastName eq 'Smith'
   ```

3. **Paginate Results**:  
   Retrieve the first 5 people:

   ```http
   GET https://services.odata.org/TripPinRESTierService/(S(lgcsd54pv5tw2wtewk0rzauf))/People?$top=5
   ```

4. **Expand Related Entities**:  
   Retrieve people along with their trips:
   ```http
   GET https://services.odata.org/TripPinRESTierService/(S(lgcsd54pv5tw2wtewk0rzauf))/People?$expand=Trips
   ```

#### Step 2: Creating a New Person with POST

1. **Create a New Person**:  
   Use Postman or httpie to add a new person:
   ```bash
   http POST https://services.odata.org/TripPinRESTierService/(S(lgcsd54pv5tw2wtewk0rzauf))/People \
   FirstName="Jane" LastName="Doe" UserName="janedoe"
   ```

#### Step 3: Batch Requests

1. **Batch Multiple Requests**:  
   Submit multiple requests (e.g., creating and updating several people) in a single batch request.

---

#### Further Reading and Tutorials

- **OData Official Documentation**: Learn more about OData’s standardized query options and features. [OData.org](https://www.odata.org/)
- **TripPin OData Service**: An interactive OData service to explore OData features. [TripPin OData Service](https://www.odata.org/blog/trippin/)
- **ASP.NET OData Tutorial**: Learn how to build your own OData API using ASP.NET. [ASP.NET OData Documentation](https://docs.microsoft.com/en-us/odata/)

---

This exercise gives students a hands-on understanding of how OData extends REST to solve real-world problems, particularly in **data-centric applications**. By exploring advanced querying and manipulation features, students will see how OData enables more powerful and flexible interactions with complex data models

## References

[^1] Roy Thomas Fielding, Architectural styles and the design of network-based
software architectures. Irvine: University of California, 2000.
[Online](https://ics.uci.edu/~fielding/pubs/dissertation/top.htm).
