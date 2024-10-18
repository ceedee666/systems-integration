# Learn about the SAP integration suite

This lab exercise is divided into two parts. The first two parts focus on the SAP integration suite:

1. Learning about the SAP Integration Suite to understand its capabilities and
   architecture.
2. Setting up the SAP Integration Suite in a BTP (Business Technology Platform)
   trial account for hands-on experience.

Additionally, the Mini-ERP system should be deployed to the SAP BTP. The
necessary steps are described in the [Mini-ERP lab](./mini-erp.md).

## Learning About SAP Integration Suite

The learning goal for the first part of the lab is to gain an understanding of
the [SAP Integration
Suite](https://www.sap.com/products/technology-platform/integration-suite.html),
its core components, and how it facilitates enterprise integration through
pre-packaged content and custom integration flows.

### What is SAP Integration Suite?

The SAP Integration Suite is a comprehensive integration platform-as-a-service
(PaaS) that helps organizations connect their on-premise and cloud
applications. It supports a wide variety of integration scenarios, such as API
management, event-driven integration, and process orchestration.

SAP Integration Suite includes the following key services:

- Cloud Integration: To create and run integration flows connecting different systems.
- API Management: For managing APIs securely.
- Open Connectors: Providing pre-built connectors to popular third-party services.
- Integration Advisor: For building B2B integration flows based on predefined guidelines.

In this lab we will mainly focus on the Cloud Integration capabilities of
the SAP Integration Suite. The reason for using the SAP Integration Suite is:

- it is based on [Apache Camel](https://camel.apache.org/), a widely used open
  source integration framework
- it is hosted by SAP simplifying the deployment in the context to the lab
- it offers a UI enabling the visual development of integration scenarios.

## Setting up the SAP Integration Suite

The goal for this part of the lab is to set up the SAP Integration Suite in a
[SAP BTP](https://www.sap.com/products/technology-platform.html) trial account.

1. **Create a BTP Trial Account**

   Follow the steps in [this
   guide](https://developers.sap.com/tutorials/hcp-create-trial-account..html)
   to create a free SAP Business Technology Platform (BTP) trial account.

1. **Enable SAP Integration Suite**:

   After setting up your BTP trial account, you will need to enable the SAP
   Integration Suite service. Follow [this
   guide](https://developers.sap.com/tutorials/btp-integration-suite-nonsapconnectivity-settingup-suite.html)
   to activate the SAP Integration Suite in you SAP BTP trial account.

## Developing with SAP Integration Suite

After setting up the SAP Integration Suite in you trail account work through
this [learning
journey](https://learning.sap.com/learning-journeys/developing-with-sap-integration-suite)
to learn about its main features.

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./rpc.md) | [Next Chapter >](./messaging.md)
