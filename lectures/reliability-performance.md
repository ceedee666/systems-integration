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

Fault tolerance is a term closely related to dependability. In the context of distributed systems dependability includes the following concepts [^1]:

- Availability
- Reliability
- Safety
- Maintainability

### Availability

> **Definition**
>
> Availability is the probability that a system is operational and accessible at
> a given point in time. It reflects the system's readiness to deliver its
> intended functionality whenever required.Key considerations:

Availability is typically expressed as a percentage, calculated using the formula:

```math
$$
Availability = \frac{Uptime}{Uptime + Downtime} \times 100
$$
```

Availability=UptimeUptime+Downtime×100
Availability=Uptime+DowntimeUptime​×100

For example:

    A system with 99.9% availability (commonly known as "three nines") allows for approximately 8.76 hours of downtime per year.
    A system with 99.99% availability ("four nines") reduces downtime to around 52.6 minutes per year.

- Redundancy: Use of failover mechanisms or redundant components to minimize
  downtime.
- Monitoring: Real-time detection and response to issues.
- Load balancing: Distributing requests across multiple servers to prevent
  overloading.

Example in integration: An e-commerce platform must ensure its payment gateway
remains available during high traffic events like Black Friday.

### Reliability

Definition: Reliability measures the ability of a system to perform its
intended function without failure over a specific period. It focuses on
consistent operation rather than immediate recovery.

Key considerations:

- Error handling: Mechanisms to detect and address errors without compromising
  the system.
- Data integrity: Ensuring data remains accurate and consistent across
  integrations.
- Testing: Regular stress testing to identify potential weaknesses.

Example in integration: A supply chain system must reliably synchronize
inventory data across warehouses and stores.

---

### Safety

Definition: Safety ensures that a system operates without causing unacceptable
risks or harm. This is particularly crucial in domains like healthcare or
aviation.

Key considerations:

- Fail-safe mechanisms: Designing systems to enter a safe state in case of
  failure.
- Error isolation: Ensuring faults in one component do not propagate to others.
- Compliance: Adhering to industry standards and regulations.

Example in integration: A healthcare system must prevent incorrect medication
dosages due to integration errors between prescription and dispensing systems.

---

### Maintainability

Definition: Maintainability is the ease with which a system can be repaired or
updated to restore functionality or improve performance.

Key considerations:

- Modular design: Simplifying updates and replacements by isolating components.
- Documentation: Providing detailed records of system configurations and
  integrations.
- Monitoring tools: Enabling quick diagnosis of issues through effective
  monitoring.

Example in integration: A content management system (CMS) should allow seamless
integration with new plugins or APIs without major rework.

---

Interactive Discussion:

- Discuss real-world examples where each aspect is critical.
- Highlight trade-offs: For instance, achieving high availability might
  increase complexity, impacting maintainability.

By covering these aspects, students can understand the multi-dimensional
approach required to design robust and fault-tolerant integrations.

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./enterprise-integration-patterns-details.md)

## References

[^1]:
    M. van Steen and A. S. Tanenbaum, Distributed Systems, Fourth edition,
    Version 4.01 (January 2023). Maarten van Steen, 2023.
    [Online](https://www.distributed-systems.net/index.php/books/ds4/)

[^2]:
    M. Kleppmann, Designing data-intensive applications: the big ideas behind
    reliable, scalable, and maintainable systems, First edition. Beijing Boston
    Farnham Sebastopol Tokyo: O’Reilley, 2017.
