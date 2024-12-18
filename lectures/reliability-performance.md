# Reliability and performance

<!--toc:start-->

- [Reliability and performance](#reliability-and-performance)
  - [Side note: Understanding computer time on a human scale](#side-note-understanding-computer-time-on-a-human-scale)
    - [Exercise: Scaling computer times to human scale](#exercise-scaling-computer-times-to-human-scale)
    - [Solution](#solution)
  - [Fault tolerance](#fault-tolerance)
    - [Definitions](#definitions)
    - [Exercise / Discussion](#exercise-discussion)
    - [Formal Definitions](#formal-definitions)
    - [Relationship Between Availability, MTBF, and MTTR](#relationship-between-availability-mtbf-and-mttr)
    - [Difference and Relation Between Fault, Error, and Failure](#difference-and-relation-between-fault-error-and-failure)
      - [Example Scenario](#example-scenario)
      - [Types of faults](#types-of-faults)
      - [Types of failures](#types-of-failures)
  - [Navigation](#navigation)
  - [References](#references)
  <!--toc:end-->

## Side note: Understanding computer time on a human scale

In modern computing, operations happen incredibly fast, often measured in
nanoseconds (ns), microseconds (µs), or milliseconds (ms). While intervals
measured in these units may all seem very short, understanding their
differences is critical when designing and optimizing system integrations. A
seemingly small delay at the computer scale can accumulate into significant
slowdowns, especially when systems process a large number of messages per
second.

To better understand the performance impact of various operations, we can
translate these computer times into a human scale. By scaling up the times,
we can relate them to durations we experience in everyday life, making it
easier to comprehend the relative speed of different components in a system.

In the following exercise, you will explore how common computer operations —
such as accessing memory, performing disk I/O, or making network calls —
translate to a human time scale. This will provide insights into the vast
differences in speed across system components and help you appreciate the
importance of efficient integration design.

### Exercise: Scaling computer times to human scale

In this exercise, you will calculate how much time common computer operations
would take if scaled to human scale. Use the following conversion:

- 0,5 ns (nanosecond) = 1 second on the human scale.

For each operation listed below, calculate the equivalent human time. Round the
results to whole numbers for simplicity.

| Operation                       | Computer time | Human scale |
| ------------------------------- | ------------- | ----------- |
| CPU cycle                       | 0,5 ns        |             |
| Level 1 cache access            | 1 ns          |             |
| Level 2 cache access            | 3 ns          |             |
| Level 3 cache access            | 28 ns         |             |
| Main memory access (DDR DIMM)   | 100 ns        |             |
| SSD I/O                         | 100 µs        |             |
| Rotational disk I/O             | 1 ms          |             |
| Internet call (SF to NYC)       | 65 ms         |             |
| Internet call (SF to Hong Kong) | 141 ms        |             |

### Solution

| Operation                       | Computer time | Human scale          |
| ------------------------------- | ------------- | -------------------- |
| CPU cycle                       | 0,5 ns        | 1 seconds            |
| Level 1 cache access            | 1 ns          | 2 seconds            |
| Level 2 cache access            | 3 ns          | 6 seconds            |
| Level 3 cache access            | 28 ns         | 56 seconds           |
| Main memory access (DDR DIMM)   | 100 ns        | 3 minutes 20 seconds |
| SSD I/O                         | 100 µs        | 2 days 7 hours       |
| Rotational disk I/O             | 1 ms          | 23 days              |
| Internet call (SF to NYC)       | 65 ms         | 4 years 2 months     |
| Internet call (SF to Hong Kong) | 141 ms        | 9 years 1 months     |

## Fault tolerance

Once multiple systems are connected using some integration technology, the
entire system landscape is inevitably transformed into a distributed system.
Unlike standalone systems, distributed systems involve components that operate
on separate nodes and communicate over networks. While this distributed nature
brings flexibility and enables scalability, it also introduces a higher degree
of complexity and vulnerability to failures. In this section fault tolerance
for distributed systems is discussed in detail.

Fault tolerance is a term closely related to dependability. In the context of
distributed systems dependability includes the following concepts [^1]:

- Availability
- Reliability
- Safety
- Maintainability

### Definitions

> **Availability**
>
> Availability is the probability that a system is operational and accessible at
> a given point in time. It reflects the system's readiness to deliver its
> intended functionality whenever required.Key considerations:

Availability is typically expressed as a percentage. For example [^2]:

- A system with 99.9% availability (commonly known as "three nines") allows for
  approximately 8.76 hours of downtime per year.
- A system with 99.99% availability ("four nines") reduces downtime to around
  52.6 minutes per year.

> **Reliability**
>
> Reliability measures the ability of a system to perform its intended function
> without failure over a specific period. It focuses on consistent operation
> rather than immediate recovery.

A highly reliable systems is one that works without interruption for a long
period of time. As an example consider a system that fails randomly for 1 ms
every hour. The availability of the system is still above 99.999%. However, the
reliability is low. In contrast, a system that never fails but is shout down
for 2 planned weeks every year has a high reliability, but only an availability
of about 96%.

> **Safety**
>
> Safety ensures that a system operates without causing unacceptable risks or
> harm.

This is particularly crucial in high risk scenarios e.g. aviation or process
control. A failing control system of a nuclear power plant could e.g. cause
catastrophic consequences.

> **Maintainability**
>
> Maintainability is the ease with which a system can be repaired or updated to
> restore functionality or improve performance.

### Exercise / Discussion

For each of the mentioned aspects identify are real-world example in which this
aspect is crucial. For each scenario:

- Identify a possible approach to increase the crucial aspect.
- Highlight trade-offs: For instance, achieving high availability might
  increase complexity, impacting maintainability.

### Formal Definitions

In the following we use the formal definitions given in [^1]. The
availability $A(t)$ of a component in the time interval $[0, t)$ is
defined as the average fraction of time that the component has been functioning
correctly during that interval. The long-term availability $A$ of a
component is defined as $A(\infty)$.

Reliability $R(t)$ of a component in the time interval
$[0, t)$ is formally defined as the conditional probability that it has been
functioning correctly during that interval, given that it was functioning
correctly at time $ T = 0 $.

Consider a system of $N$ identical components. Let $N_0(t)$ denote the number
of correctly operating components at time $t$, and $N_1(t)$ the number of
failed components.

```math
$$
R(t) = \frac{N_0(t)}{N} = 1 - \frac{N_1(t)}{N} = \frac{N_0(t)}{N_0(t) + N_1(t)}
$$
```

The rate at which components are failing can be expressed as
$\frac{dN_1(t)}{dt}$. Dividing this by the number of correctly operating
components at time $t$ gives us the failure rate function $z(t)$:

```math
$$
z(t) = \frac{1}{N_0(t)} \frac{dN_1(t)}{dt}
$$
```

Since $N = N_0(t) + N_1(t)$, we can write:

```math
$$
R(t) = \frac{N_0(t)}{N} = \frac{N - N_1(t)}{N} = 1 - \frac{N_1(t)}{N}

$$
```

Differentiate both sides with respect to $t$:

```math
$$
\frac{dR(t)}{dt} = 0 - \frac{1}{N} \frac{dN_1(t)}{dt} = = -\frac{1}{N} \frac{dN_1(t)}{dt}
$$
```

By substituting $\frac{dN_1(t)}{dt} = -N\frac{dR(t)}{dt}$ we get:

```math
$$
z(t) = -\frac{N}{NR(t)}\frac{dR(t)}{dt} = -\frac{1}{R(t)} \frac{dR(t)}{dt}.
$$
```

If we assume the failure rate $z(t)$ is constant over time $z(t) = z$, we
rewrite the equation as:

```math
$$
\frac{dR(t)}{dt} = -zR(t).
$$
```

This differential equation describes the rate at which reliability decreases
over time. With $ R(0) = 1$ (i.e. the system starts fully operational), we get:

```math
$$
R(t) = e^{-zt}.
$$
```

The solution $R(t) = e^{-zt}$ shows:

- Reliability decreases exponentially over time when the failure rate $z$ is
  constant.
- The system follows an exponential distribution, which models the time between
  events (failures) in a memoryless process.

This result is a fundamental property of systems with constant failure rates
and reflects their reliability over time.

### Relationship Between Availability, MTBF, and MTTR

Availability $A$ can also be expressed using the metrics Mean Time Between
Failures (MTBF) and Mean Time To Repair (MTTR). Theses two metrics are defined
as follows:

- Mean Time Between Failures (MTBF): The average time a system operates
  correctly between two consecutive failures.
- Mean Time To Repair (MTTR): The average time required to repair a system and
  restore it to an operational state after a failure.

Availability $A$ is the fraction of time a system is operational. It can be
expressed in terms of MTBF and MTTR as:

```math
$$
A = \frac{\text{MTBF}}{\text{MTBF} + \text{MTTR}}
$$
```

This formula highlights how the interplay between MTBF and MTTR affects
availability:

- Higher MTBF: Indicates the system operates longer without failure, improving
  availability.
- Lower MTTR: Reduces downtime, also improving availability.

Bases on this definitions, we can make some observations:

- If MTBF is much larger than MTTR $\text{MTBF} \gg \text{MTTR}$, the system
  will have very high availability $A \to 1$.
- If MTTR is comparable to MTBF $\text{MTBF} \approx \text{MTTR}$, availability
  decreases significantly because the system spends a considerable portion of
  time under repair.

> Note that the previous definitions only make sense if it is clear what a
> failure actually is. This might not always be obvious in a complex system
> landscape.

### Difference and Relation Between Fault, Error, and Failure

In the context of system reliability and fault tolerance, the terms fault,
error, and failure are often used interchangeably, but they have distinct
meanings and relationships. Understanding these terms is essential for
analyzing and designing robust systems.

A _fault_ is the underlying cause of an abnormal condition in a component of
the system. It refers to a defect in hardware, software, or the environment
that has the potential to disrupt system operation. A fault may be transient,
intermittent or permanent. [^2]

An _error_ is a deviation from the intended or expected behavior of a system
caused by an active fault. It represents the manifestation of a fault during
system operation. A error might cause a system failure.

A _failure_ occurs when a system deviates from its intended behavior and is
unable to deliver the required functionality to the user. It is the ultimate
consequence of an error that impacts the system ability to provide its services.

#### Example Scenario

Consider web application that provides real-time stock price updates to users.
The application consists of:

- A front-end interface for user interaction.
- Middleware servers for processing requests.
- A database backend for storing stock price data.

To ensure reliability, the system is designed with _redundancy_ in the
middleware layer, having multiple middleware servers to handle requests.

- Example 1: fault that does not lead to failure

  - Fault: One of the middleware servers experiences a hardware issue (e.g., a
    network interface card fails), making it unable to process requests.
  - This fault does not lead to an error or failure because the system detects
    the unresponsive middleware server and reroutes requests to other middleware
    servers in the cluster. The redundancy ensures the application continues to
    operate normally, and is able to provide its services

- Example 2: critical fault leading to failure

  - Fault: The database backend encounters a corruption in its stock price
    table due to a disk failure.
  - When a middleware server queries the database for stock prices, it receives
    corrupted or invalid data. The front-end application tries to display the
    stock prices and crashes due to the malformed data. Unlike the first fault,
    this fault affects a critical component (the database). The error propagates
    to the user-facing application, resulting in a failure.

#### Types of faults

In [^1] the following fault types in distributed systems are defined:

- Hardware faults:

  Examples of hardware faults include hard disk crashes, RAM failures, power
  outages, or physical mistakes like unplugging cables.

  Mitigation strategies for hardware faults include hardware redundancy to
  reduce failure rates. Examples for hardware redundancy are RAID for
  disks, dual power supplies, and backup generators.

- Software errors:

  Examples of software errors include bugs, runaway processes excessively
  consuming resources, a service slows down, stops responding or returns
  corrupted responses.

  Mitigation strategies for software errors include:

  - thorough Testing
  - Process isolation to limit the scope of errors.
  - Monitoring for anomalies in performance and resource usage.

- Human errors:

  Human errors are mistakes made by developers, operators, or users during the
  design, configuration, or operation of a system. Examples include
  configuration errors, accidental actions like deleting critical files or poor
  maintenance like not installing updates.
  Ignoring disk space alerts leading to crashes.

#### Types of failures

In [^2] failures are further categorized:

| **Type of Failure**        | **Description of Server’s Behavior**               |
| -------------------------- | -------------------------------------------------- |
| **Crash failure**          | Halts but is working correctly until it halts      |
| **Omission failure**       |                                                    |
| - Receive omission         | Fails to respond to incoming requests              |
| - Send omission            | Fails to send messages                             |
| **Timing failure**         | Response lies outside a specified time interval    |
| **Response failure**       |                                                    |
| - Value failure            | The value of the response is wrong                 |
| - State-transition failure | Deviates from the correct flow of control          |
| **Arbitrary failure**      | May produce arbitrary responses at arbitrary times |

### The CAP theorem and its relation to fault tolerance

The CAP theorem, formulated by Eric Brewer, is a foundational concept in
distributed systems that describes a trade-off between three key properties:

1. Consistency (C): All nodes in the system see the same data at the same time.
2. Availability (A): The system is operational and can respond to requests,
   even in the presence of faults.
3. Partition Tolerance (P): The system continues to operate despite network
   partitions (communication breakdowns between nodes).

The theorem states that in a distributed system, you can achieve at most two of
these three properties simultaneously.

#### Understanding the Properties

1. Consistency:

   Ensures that every read receives the most recent write or an
   error. This is crucial for applications where data correctness is critical,
   such as financial transactions.

2. Availability:

   Guarantees that every request receives a (potentially
   outdated) response, even if some nodes are unavailable. This is essential
   for systems that prioritize uptime over data freshness.

3. Partition tolerance:

   Ensures the system can function correctly despite
   network failures that partition the system into isolated segments.

#### Trade-offs in CAP

According to the CAP theorem, there are three distinct trade-offs for a
distributed system. When designing a distributed system, you need to consider
which of the possible properties are required by the system.

1. Consistency + Availability (CA):

   Possible in systems that do not need to tolerate network partitions.
   Typically applies to systems operating in a single, reliable data center.

2. Consistency + Partition Tolerance (CP):

   Prioritizes correctness over availability. During network partitions, some
   requests may fail to ensure consistent data. Example: Traditional relational
   databases using distributed transactions.

3. Availability + Partition Tolerance (AP):

   Prioritizes uptime over strict consistency. Nodes may return stale data
   during partitions. Example: Distributed systems like DNS or NoSQL databasesp.

The CAP theorem is directly related to fault tolerance because distributed
systems often encounter network partitions or node failures, requiring the
system to choose between consistency and availability.

#### Example scenario for the CAP theorem

Consider a distributed database used for real-time stock trading:

- During a network partition, the system faces a choice:
  - Prioritize Consistency (stop trading to ensure all nodes have the same data).
  - Prioritize Availability (allow trading to continue with potentially stale data).
- Depending on the system's fault tolerance strategy, it might:
  - Opt for consistency to avoid incorrect trades (CP system).
  - Opt for availability to maintain service during network issues (AP system).

### Exercise

Analyze the distributed architecture you implemented in the lab, focusing on
fault tolerance and the CAP theorem. Begin by identifying key
components (e.g., webshop, ERP system, messaging systems) and their
interactions. Highlight potential faults (hardware, software, human errors) and
describe how your system (could) mitigates these issues using mechanisms like
redundancy, load balancing, or error recovery. Discuss the impact of unhandled
faults on system performance and reliability.

Evaluate your architecture with respect to the CAP theorem, explaining which
properties (consistency, availability, partition tolerance) your system
prioritizes. Provide examples of trade-offs in scenarios such as network
partitions or high traffic.

Prepare a short presentation of your results.

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./enterprise-integration-patterns-details.md)

## References

[^1]:
    M. van Steen and A. S. Tanenbaum, Distributed Systems, Fourth edition,
    Version 4.01 (January 2023). Maarten van Steen, 2023.
    [Online](https://www.distributed-systems.net/index.php/books/ds4/)

[^2]: [High availability](https://en.wikipedia.org/wiki/High_availability)

[^3]:
    M. Kleppmann, Designing data-intensive applications: the big ideas behind
    reliable, scalable, and maintainable systems, First edition. Beijing Boston
    Farnham Sebastopol Tokyo: O’Reilley, 2017.
