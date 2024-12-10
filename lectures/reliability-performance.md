# Reliability and performance

## Introduction: Understanding computer time on a human scale

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
