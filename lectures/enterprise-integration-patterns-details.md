# Enterprise integration patterns in detail

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

The Guaranteed Delivery pattern addresses this problem by adding persistent
data stores to the all involved systems (i.e. sender, messaging system and
receiver). Using the Guaranteed Delivery pattern sending a message involves the
following steps:

1. The sender stores the message in its data store. Sending only completed once
   the message has been stored.
2. The

## Navigation

🏠 [Overview](../README.md) | [< Previous
Chapter](./enterprise-integration-patterns.md) | [Next Chapter >
](./reliability-performance.md)

## References

[^1]:
    G. Hohpe and B. Woolf, Enterprise integration patterns: designing,
    building, and deploying messaging solutions. The
    Addison-Wesley signature series. Boston Munich: Addison-Wesley, 2013.
