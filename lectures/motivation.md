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

- **Identify Key Processes:** Determine the essential business processes, both
  manual and automated, needed for the company's operations.
- **Determine Supporting Systems:** Consider which information systems would
  support these processes.
- **Analyze Integration Needs:** Explore how these systems should interact with
  each other and whether integration with external partners' systems is
  necessary.

Prepare one slide summarizing your key findings.

## Exercise 2

**Scenario:**

The following diagram shows two systems connected by an arrow. System X could
represent a Customer Relationship Management (CRM) system, while System Y might
be an invoicing or billing system.

![Abstract integration
scenario](imgs/01-motivation-abstract-scenario.drawio.png)

**Exercise Instructions:**

Form small groups of 3-4 students and discuss what the arrow connecting System
X and System Y might represent in the context of system integration and
interoperability. Consider the following:

- What kind of interaction does the arrow symbolize (e.g., data flow, process
  flow)?
- What challenges such as data consistency, security, performance, or
  scalability, might arise from this interaction?
- What are the implications for reliability, security, and efficiency?
- How could different integration patterns or methods (e.g., synchronous vs.
  asynchronous communication) influence this interaction?

Prepare one slide summarizing your key findings.

## Interoperability Perspectives

In chapter 1 of Fundamentals of Information Systems Interoperability [^2], the
authors define three perspective of interoperability:

1. Levels and tasks
1. Integration scenarios and methods
1. Interoperability concerns

In this lecture this view is extended by the integration styles
defined in chapter 2 of Enterprise Integration Patterns [^3].
These different perspectives are discussed in the following sections.

### Integration styles

The first perspective on integration are the different integration styles.
Four basic integration styles can be identified:

1. File transfer
1. Shared database
1. Remote procedure invocation
1. Messaging

In the case of file transfer, applications produce or consume files to share
data with other applications. In contrast to this approach multiple
applications share data in a common data bases in the shared database style. In
the remote procedure invocation style applications expose some functionality to
other applications in order to receive data or trigger processes. Finally,
messaging requires a messaging system that is used by applications to exchange
messages.

### Levels and tasks

The second perspective relates the **syntactic**, **semantic** and
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

| Level / Task | Syntactial                                                                                                                                                                                                                                              | Semantic                                               | Organizational               |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ | ---------------------------- |
| Exchange     | Exchange formats: [CSV](https://en.wikipedia.org/wiki/Comma-separated_values), [EDIFACT](https://en.wikipedia.org/wiki/EDIFACT), [XML](https://en.wikipedia.org/wiki/XML), [JSON](https://en.wikipedia.org/wiki/JSON) <br/> Query languages: SQL, XPAth | Schema mapping, ontologies                             | Message exchange             |
| Integrate    | Databases, REST, OData                                                                                                                                                                                                                                  | Schema languages, generic and user-defind schemas.     | Correlation and choreography |
| Orchestrate  | BPMN, Petri Nets, Workflow engines                                                                                                                                                                                                                      | Verification, service invocation, integration patterns | Choreography                 |

### Integration scenarios and methods

The approaches mentioned in the previous two sections are concerned with the
exchange of messages and data to support integration. One approach that has not
been mentioned so far is the integration on a UI level.

Different technologies for an integration on the UI level exist. For example,
portals offer an integrated access to heterogeneous and distributed
applications and systems. In contrast to this, [Robotic Process
Automation](https://en.wikipedia.org/wiki/Robotic_process_automation) enables
the automated execution of processes across different systems by automating the
respective UIs.

| Application Domain | UI Integration                                                   | Process Integration | Application & Function Integration                  | Data & Information Integration                                        |
| ------------------ | ---------------------------------------------------------------- | ------------------- | --------------------------------------------------- | --------------------------------------------------------------------- |
| **Method / Style** | UI-oriented                                                      | Message-oriented    | Message-oriented                                    | Query-based                                                           |
| **Realization**    | Portals, Robotic Process Automation, Workflow management systems | Process engines     | EAI systems, Message-oriented middleware, ETL tools | ETL tools, everythin mention in [Levels and Tasks](#levels-and-tasks) |

### Interoperability concerns

The final perspective on interoperability are the interoperability concerns. In
order to execute processes across heterogeneous systems interoperability needs
to be established on three levels: data, service and process level. On each
level two questions need to be answered:

- What is to be exchanged?
- How is it exchanged?

On the data level these questions are answered using exchange formats like XML
or JSON, and protocols like REST or OData. On the process level the "What" is
still concerned with exchange formats and protocols while the "How" is related
to process orchestration and process choreographies. Those can be realized,
e.g. using process engines or EAI systems.

## Summary

The previous discussion shows that interoperability is a broad and complex
topic that spans multiple levels of system interaction, from data exchange to
process orchestration across organizations.

These perspectives - whether related to integration styles, tasks, or methods -
will form the foundation for the rest of the course. We will return to these
concepts regularly. In particular, we will apply them to analyse case studies
and implement them in the lab exercises.

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

[^3]:
    G. Hohpe and B. Woolf, Enterprise integration patterns: designing, building,
    and deploying messaging solutions, Boston Munich: Addison-Wesley, 2013.
