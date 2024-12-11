# Reliability and performance

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

In the following we use the formal definitions given in [^1]. The **availability** \( A(t) \) of a component in the time interval
\([0, t)\) is defined as the average fraction of time that the component has
been functioning correctly during that interval. The long-term availability \(
A \) of a component is defined as \( A(\infty) \).

Likewise, the **reliability** \( R(t) \) of a component in the time interval \([0, t)\) is formally defined as the conditional probability that it has been functioning correctly during that interval, given that it was functioning correctly at time \( T = 0 \).

Following Pradhan [1996], to establish \( R(t) \), we consider a system of \( N \) identical components. Let \( N_0(t) \) denote the number of correctly operating components at time \( t \), and \( N_1(t) \) the number of failed components. Then, clearly:

\[
R(t) = \frac{N_0(t)}{N} = 1 - \frac{N_1(t)}{N} = \frac{N_0(t)}{N_0(t) + N_1(t)}
\]

The rate at which components are failing can be expressed as the derivative \( \frac{dN_1(t)}{dt} \). Dividing this by the number of correctly operating components at time \( t \) gives us the failure rate function \( z(t) \):

\[
z(t) = \frac{1}{N_0(t)} \frac{dN_1(t)}{dt}
\]

From:

\[
\frac{dR(t)}{dt} = -\frac{1}{N} \frac{dN_1(t)}{dt}
\]

it follows that:

\[
z(t) = \frac{1}{N_0(t)} \frac{dN_1(t)}{dt} = -\frac{1}{R(t)} \frac{dR(t)}{dt}
\]

If we make the simplifying assumption that a component does not age (and thus essentially has no wear-out phase), its failure rate will be constant, i.e., \( z(t) = z \), implying that:

\[
\frac{dR(t)}{dt} = -zR(t)
\]

Because \( R(0) = 1 \), we obtain:

\[
R(t) = e^{-zt}
\]

In other words, if we ignore aging of a component, we see that a constant failure rate leads to a reliability function described by an exponential decay.

```

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./enterprise-integration-patterns-details.md)

## References

[^1]:
    M. van Steen and A. S. Tanenbaum, Distributed Systems, Fourth edition,
    Version 4.01 (January 2023). Maarten van Steen, 2023.
    [Online](https://www.distributed-systems.net/index.php/books/ds4/)

[^2]: https://en.wikipedia.org/wiki/High_availability

[^3]:
    M. Kleppmann, Designing data-intensive applications: the big ideas behind
    reliable, scalable, and maintainable systems, First edition. Beijing Boston
    Farnham Sebastopol Tokyo: O’Reilley, 2017.
```
