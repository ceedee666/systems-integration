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

## oData

## References

[^1] Roy Thomas Fielding, Architectural styles and the design of network-based
software architectures. Irvine: University of California, 2000.
[Online](https://ics.uci.edu/~fielding/pubs/dissertation/top.htm).
