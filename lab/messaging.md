# Lab 6: Exchange data using messaging

<!--toc:start-->

- [Lab 5: Exchange data using messaging](#lab-5-exchange-data-using-messaging)
  - [Objective](#objective)
  - [Requirements](#requirements)
  - [Navigation](#navigation)
  <!--toc:end-->

## Objective

In this lab, you will implement a real-time synchronization mechanism using
**message exchange** via the **SAP Integration Suite**. The Web shop will send
customer orders to the ERP system sending a message via a messaging channel.

## Requirements

1. Order messages

   - The web shop will send an order message to the SAP Integration Suite
     whenever a customer completes a purchase. This message should contain the
     necessary order details, such as product ID, quantity, and customer
     information.

2. Integration flow

   - Implement an integration flow within the SAP Integration Suite that
     receives the order message from the web shop. The integration flow must
     invoke the correct OData service of the ERP system.

3. Error handling:

   - Ensure proper error handling within the integration flow for scenarios
     such as service unavailability or message delivery failures.
   - The SAP Integration Suite should implement retry mechanisms for failed
     message delivery or ERP service invocation. Consider leveraging message
     persistence and retry options available within the suite.

Please also document the integration you build using the [enterprise
integration patterns](../lectures/enterprise-integration-patterns-details.md).

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./rpc.md) | [Next
Chapter >](./integration-patterns-lab.md)
