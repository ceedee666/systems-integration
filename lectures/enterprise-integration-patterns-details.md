# Enterprise integration patterns in detail

<!--toc:start-->

- [Enterprise integration patterns in detail](#enterprise-integration-patterns-in-detail)
  - [Message channel patterns](#message-channel-patterns)
    - [Point-to-point channel](#point-to-point-channel)
      - [Example of a point-to-point channel](#example-of-a-point-to-point-channel)
      - [Relation to other channel patterns](#relation-to-other-channel-patterns)
      - [RPC communication](#rpc-communication)
    - [Publish-subscribe channel](#publish-subscribe-channel)
      - [Example of a publish-subscribe channel](#example-of-a-publish-subscribe-channel)
      - [Event messages](#event-messages)
      - [MQTT](#mqtt)
    - [Datatype channel](#datatype-channel)
      - [**Example of a Data Type Channel**](#example-of-a-data-type-channel)
    - [Guaranteed Delivery](#guaranteed-delivery)
    - [Channel Adapter](#channel-adapter)
      - [Channel adapter and application layers](#channel-adapter-and-application-layers)
    - [Message bus](#message-bus)
      - [Example of a Message Bus](#example-of-a-message-bus)
      - [Key Elements of the Message Bus](#key-elements-of-the-message-bus)
  - [Navigation](#navigation)
  - [References](#references)
  <!--toc:end-->

The diagram below provides an overview of the different enterprise integration
patterns that are discussed in detail in this lecture. Note that this is only a
selection of the patterns defined in the enterprise integration pattern book.
For a comprehensive list of patterns, see the [^1].

![Enterprise Integration Patterns Overview](./imgs/eip-overview.drawio.png)

## Message channel patterns

### Point-to-point channel

> **Problem statement**
>
> How can a sender ensure that only one consumer will process a message?

In enterprise integration scenarios, some processes require **exclusive
processing** of messages, where only one consumer should handle each message.
This is crucial in cases where duplicated processing would lead to errors,
inconsistencies, or wasted resources. Without a mechanism to enforce
single-message consumption, multiple consumers could potentially process the
same message, resulting in duplicate actions or data conflicts.

The Point-to-Point Channel pattern addresses this by allowing each message
to be consumed by only one receiver. The messaging system takes care that each
message can only ever be consumed by one receiver.

#### Example of a point-to-point channel

Imagine an order processing system where a Web shop needs to send each order to
an ERP system for fulfillment. Each order must be handled only once by the ERP
system; otherwise, processing it multiple times could result in duplicate
invoices or incorrect inventory reductions.

In this scenario, the Web shop places each order on a Point-to-Point
Channel. The ERP system listens to this channel and consumes messages as they
arrive. Once the ERP system processes an order, the message is removed from the
channel, ensuring no other consumers can access it.

![Point-to-point channel example](./imgs/point-to-point-channel.drawio.png)

#### Relation to other channel patterns

- Publish-Subscribe Channel: Unlike the Point-to-Point Channel, a
  Publish-Subscribe Channel allows multiple consumers to receive the same
  message. This pattern is used when the goal is to broadcast information to
  multiple systems that each act on the message independently.

- Competing Consumers: In scenarios where a high volume of messages needs to be
  processed efficiently, multiple consumers can be set up to compete for
  messages on the same Point-to-Point Channel. This setup, known as Competing
  Consumers, allows each instance to process a portion of the messages,
  effectively balancing the load across multiple systems without duplicating
  message processing.

#### RPC communication

RPC communication can be implemented using a pair of point-to-point channels.
The requester sends a command message in the request channel and receives a
document message in the response channel.

### Publish-subscribe channel

> **Problem Statement**
>
> How can a sender broadcast a message to multiple consumers so that each
> consumer receives its own copy?

In many integration scenarios, a single message needs to be distributed to
multiple systems or services, each acting independently on the same
information. This is common in event-driven architectures where various systems
need to stay synchronized or updated when an event occurs. Without a mechanism
to distribute copies of the same message to multiple consumers, each recipient
would need to poll or request the message separately, leading to inefficiency
and delays.

The publish-subscribe channel pattern addresses this by broadcasting each
message to all consumers subscribed to the channel. When a message is sent to a
publish-subscribe channel, every subscriber receives its own copy of the
message, allowing each consumer to process the message independently.

#### Example of a publish-subscribe channel

![Publish-subscribe channel example](./imgs/pub-sub-channel.drawio.png)

Consider the address change of a customer in a Web shop. Several systems need to
be notified about this update:

- The ERP system to send deliveries and invoices to the right address
- The CRM system to send advertisements to the right address

In this scenario, the Web shop publishes the address update on a
publish-subscribe channel. Each subscribing system receives its own copy of the
address update message. This allows each system to act on the order update in
its own way without interfering with other systems.

#### Event messages

The publish-subscribe channel is a core component of event-driven
communication, where changes in one system (events) are immediately broadcast
to multiple listeners.

#### MQTT

[MQTT](https://mqtt.org/) (Message Queuing Telemetry Transport) is a
lightweight messaging protocol often used to implement publish-subscribe
communication. Originally developed for low-bandwidth, high-latency networks,
MQTT has become a popular choice for IoT (Internet of Things) applications,
mobile devices, and other systems where efficient, reliable, and asynchronous
communication is essential.

### Datatype channel

> **Problem Statement**
>
> How can an application send different data items in such a way that the
> receiver knows how to process them?

In an enterprise system, various types of messages flow through the messaging
infrastructure. Each message type (e.g., orders, stock updates, invoices) may
have a different format and structure. A receiver must know which message
it receives. Otherwise it is not able to process the messages.

This problem could be solved using different approaches:

- Adding a format identifier to the message (cf.
  [EDIFACT](./exchange-formats.md#introduction-to-edifact))
- Using a [Command Message](#command-message) with a specific command for each
  of the message types

The Datatype Channel pattern addresses this issue by organizing channels based
on the type of data they carry. By assigning each message type to its own
channel, the sender knows the type of message based on the channel through
which it is sent.

#### **Example of a Data Type Channel**

Consider a Web shop that sends different types of messages to an ERP
system:

- Customer address updates
- Request for quotations
- Purchase orders

Using Datatype Channels a separate channel is created for each message type.

![Datatype channel example](./imgs/datatype-channel.drawio.png)

### Guaranteed Delivery

> **Problem Statement**
>
> How can a sender ensure that a message is delivered to its intended recipient
> even in the case of network failures or system downtime?

In enterprise integration, some messages are critical and must be reliably
delivered. Temporary network issues or downtime in the receiving system could
result in message loss. Also the messaging system might not temporarily no be
available. All these issues may lead to lost messages and, as a result, to
incomplete transactions, missing updates, or data inconsistencies.
Consequently, a mechanism is required to ensure that the message will reach its
destination, regardless of temporary issues.

![Guaranteed delivery example](./imgs/guaranteed-delivery.drawio.png)

The Guaranteed Delivery pattern addresses this problem by adding persistent
data stores to the all involved systems (i.e. sender, messaging system and
receiver). Using the Guaranteed Delivery pattern sending a message involves the
following steps:

1. The sender stores the message in its data store. Sending only completes once
   the message has been stored.
2. The message is forwarded to the messaging system. It is only deleted from
   the data store of the sender once it has been successfully stored in the
   messaging systems data store.
3. The message is forwarded to the receiver. It is only deleted form the data
   store of the messaging system once it has been successfully stored in the
   receiver data store.
4. Finally, the receiver processes the messages and deletes it from the data
   store once it has been successfully processed.

The increased reliability of the guaranteed delivery pattern obviously reduced
the performance of the message delivery and requires additional storage.
Depending on the message size and the duration of an outage huge amounts of
storage might be required. For this reason some messaging systems support retry
timeouts or maximum number of retries. Also the Message Expiration pattern
might be used to limit the amount of time a message is stored.

### Channel Adapter

> **Problem Statement**
>
> How can we integrate applications that were not designed with messaging in
> mind into a messaging infrastructure?

In an enterprise environment, some applications — often legacy systems or
external systems — lack native messaging capabilities. If the existing system
provide an API it most likely will not fit the API of the messaging system.
Nevertheless, these systems need to be connected to the messaging system.

In case of custom applications functionality for the integration with the
messaging system could be added to the application. This would increase the
complexity of the application. Furthermore, this approach closely ties the
application to a particular messaging system.

The Channel Adapter pattern addresses these issue by creating a connection
between the application and the messaging system. The channel adapter acts as a
client to the messaging system. It translates messages and invokes the
appropriate application functionality. It also listens to application events
and send messages via the messaging system in response to these events.

The Channel Adapter pattern aims to adapt the interfaces of the messaging
system and the connected application to each others. In this respect it is
quite similar to the adapter pattern in the Design Patterns book. [^2].

#### Channel adapter and application layers

![Channel adapter and different application layers](./imgs/channel-adapter.drawio.png)

The channel adapter can connect to different layers of an application:

1. **UI layer**:

   Sometimes it is not possible to expose the functionality of a system via an
   API. The reason could be that an legacy system simply does not provide the
   functionality or a system vendor does not provide the necessary APIs. In
   these cases a UI adapter enable the access to the same functionality a user
   has on the UI of the application. The downside of an adapter on the UI level
   is that these adapters tend to be brittle and comparably slow.

2. **Business logic layer**:

   Information systems usually expose their
   functionality via an API. These API are provided by vendors to support
   system integration. The APIs tend to be more stable the UI of an application.
   Additionally, APIs offer better performance then an integration on the UI
   Layer. If a system offers an API on the business logic layer, it is the
   recommended layer to implement the channel adapter.

3. **Database layer**:

   Most information system persist their data in a relation database. A channel
   adapter on the database layer can extract the data from the database without
   the knowledge of the application. A trigger can be added to the database to
   always send a message when relevant tables change. This approach can be used
   when there is no other programmatic access to the application, or when
   read-only data extraction is sufficient. Updates on the database layer
   usually are very dangerous as they circumvent the business logic of the
   application.

### Message bus

> **Problem Statement**
>
> How can multiple applications send messages to each others while being
> loosely coupled? It should be possible to easily add and remove applications.

In large enterprise systems, applications often need to communicate with each
other, exchanging data and triggering actions across different systems.
However, directly connecting each application to every other application leads
to a tightly coupled architecture that is difficult to scale or maintain. Every
time a new application is added, new point-to-point connections must be
created, increasing complexity.

The message bus pattern provides a solution by introducing a central
communication infrastructure that acts as a common messaging backbone. This bus
enables multiple applications to communicate in a standardized and loosely
coupled manner. Applications are not aware of each other’s internal structures
or implementations; they simply send and receive messages via the bus.

#### Example of a Message Bus

Consider a system landscape where multiple systems handle different parts of the
order process:

- A Web shop handles the creation of customer orders.
- A ERP system reserves raw material for an order an schedules production.
- A customs application handles the customs clearance of the order.
- The billing system generates the invoice and sends it to the customer.
- Finally, a shipping system plans and schedules the shipping of an order

Each of these systems needs to react on activities of other systems (e.g. when
an order is created). To achieve this each system only interacts with the
message bus. This allows changes to the individual application without the
other applications being impacted. For example, if a new billing system is
added, it can simply subscribe to relevant messages.

![Example of a message bus](./imgs/message-bus.drawio.png)

#### Key Elements of the Message Bus

1. **Common Communication Infrastructure**

   The message bus serves as the backbone for all communication between
   applications. Each application connects to the bus, and messages are routed
   through this central channel. This setup eliminates the need for direct
   connections between applications, reducing complexity. The communication
   infrastructure may include a Message Router or may be based on
   Publish-Subscribe channels.

2. **Adapters**

   Applications typically do not natively support communication over the
   Message Bus. To solve this, each application uses an adapter to interface
   with the bus. This adapter can, for example, be implemented using the
   channel adapter pattern.

3. **Common Command Structure**

   The message bus uses a predefined command structure to ensure all messages
   participants understand the messages. This can be achieved using the command
   massage pattern. Furthermore, the data structure of the transmitted data
   need to be agreed upon by all involved applications. The can be achieved
   using a canonical data model.

## Navigation

🏠 [Overview](../README.md) | [< Previous
Chapter](./enterprise-integration-patterns.md) | [Next Chapter >
](./reliability-performance.md)

## References

[^1]:
    G. Hohpe and B. Woolf, Enterprise integration patterns: designing,
    building, and deploying messaging solutions. The
    Addison-Wesley signature series. Boston Munich: Addison-Wesley, 2013.

[^2]:
    E. Gamma, Ed., Design patterns: elements of reusable object-oriented
    software, 39. printing. in Addison-Wesley professional computing series.
    Boston, Mass. Munich: Addison-Wesley, 2011.
