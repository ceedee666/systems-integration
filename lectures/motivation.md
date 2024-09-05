# Motivation

<!--toc:start-->

- [Motivation](#motivation)
  - [Exercise 1](#exercise-1)
  - [Exercise 2](#exercise-2)
  - [Interoperability Perspectives](#interoperability-perspectives)
    - [Levels and tasks](#levels-and-tasks)
    - [Integration scenarios and methods](#integration-scenarios-and-methods)
    - [Interoperability concerns](#interoperability-concerns)
  - [References](#references)
  <!--toc:end-->

## Exercise 1

**Scenario:**

Consider a small to medium-sized company that sells bike parts online, catering
to both individual consumers and small, independent bike shops. The products are
shipped from a warehouse that is owned and operated by the company. In addition
to the online store, the company also operates a flagship store in the city
center. [^1]

**Exercise Instructions:**

Form small groups of 3-4 students and discuss the following aspects of the
scenario:

- **Identify Key Processes:** Determine the essential business processes needed
  for the company's operations.
- **Determine Supporting Systems:** Consider which information systems would
  support these processes.
- **Analyze Integration Needs:** Explore how these systems should interact with
  each other and whether integration with external partners' systems is necessary.

Prepare one slide summarizing your key findings.

## Exercise 2

**Scenario:**

The following diagram shows two systems connected by an arrow.

![Abstract integration
scenario](imgs/01-motivation-abstract-scenario.drawio.png)

**Exercise Instructions:**

Form small groups of 3-4 students and discuss what the arrow connecting System
X and System Y might represent in the context of system integration and
interoperability. Consider the following:

- What type of interaction does the arrow symbolize (e.g., data flow, process
  flow)?
- What challenges might arise from this interaction?
- What are the implications for reliability, security, and efficiency?
- How could different integration patterns or methods influence this
  interaction?

Prepare one slide summarizing your key findings.

## Interoperability Perspectives

In chapter 1 of Fundamentals of Information Systems Interoperability [^2], the
authors define three perspective of interoperability:

1. Levels and tasks
1. Integration scenarios and methods
1. Interoperability concerns

These three perspectives are discussed in the following sections.

### Levels and tasks

The first perspective relates the **syntactic**, **semantic** and
**organizational** level of interoperability to the tasks **exchange**,
**integrate** and **orchestrate**.

The syntactic level of interoperability is concerned with the data format,
while the semantic level is concerned with the meaning of the data. As an
example consider the simple XML tag `<customer>`. While the data format my be
identical, the meaning of _Customer_ in a banking application is quiet
different form the meaning of customer in a health insurance application, even
within one company. Based on syntactic and semantic operability, the
organizational interoperability level is concerned the interoperability across
the borders of organizations.

The exchange task focusses on the exchange of data between services or
applications. The integration task is related to the integration of multiple
service and applications. Finally, the orchestration is related to the
coordination of services of applications across system boundaries, both within
and across organizations.

The following table provides examples of technologies and concepts used for the
tasks on different levels.

| Level / Task | Syntactial                                                                                                                                                                                          | Semantic | Organizational |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------------- |
| Exchange     | [CSV](https://en.wikipedia.org/wiki/Comma-separated_values), [EDIFACT](https://en.wikipedia.org/wiki/EDIFACT), [XML](https://en.wikipedia.org/wiki/XML), [JSON](https://en.wikipedia.org/wiki/JSON) |          |                |
| Integrate    |                                                                                                                                                                                                     |          |                |
| Orchestrate  |                                                                                                                                                                                                     |          |                |

### Integration scenarios and methods

### Interoperability concerns

## Navigation

🏠 [Overview](../README.md) | [Next Chapter >](./integration-styles.md)

## References

[^1]:
    If this sounds a lot like
    [Bike-Components](http://www.bike-components.de) to you, your are on the
    right track 😉.

[^2]:
    S. Rinderle-Ma, J. Mangler, and D. Ritter, _Fundamentals of Information
    Systems Interoperability: Data, Services, and Processes_. Cham: Springer
    International Publishing, 2024.
