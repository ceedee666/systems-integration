# In- and outbound connection in the SAP integration suite

In this lab, we will explore how to perform inbound and outbound connections
using the SAP Integration Suite. Specifically, we will focus on setting up and
configuring both inbound communication with external systems and outbound
connections to services running within the SAP Business Technology Platform
(SAP BTP). By the end of this lab, you will gain practical experience in:

1. Configuring an HTTP inbound channel to receive external requests and
   initiate an integration flow.
2. Authenticating external systems using client credentials to securely access
   the SAP Integration Suite.
3. Setting up outbound connections within an integration flow to invoke
   services hosted on SAP BTP.

For detailed documentation on configuring inbound communication within SAP
Integration Suite, please refer to the following resources:

- [SAP Integration Suite Documentation - Configuring Inbound
  Communication](https://help.sap.com/docs/integration-suite/sap-integration-suite/configuring-inbound-communication)
- [SAP Integration Suite Documentation - Configuring Inbound HTTP
  Connections](https://help.sap.com/docs/integration-suite/sap-integration-suite/configuring-inbound-http-connections)

## Inbound connection using client credentials

### Step 1: Model a simple integration flow with http channel

1. Create a new integration flow with the following elements:

   - Sender: Add an HTTP channel as the sender. Configure it as follows:
     - User Role: Set the user role to `ESBMessaging.send`.
     - Address: Assign an address, such as `/test-inbound-client-credentials`.
   - Start Event: Add a Start event to initiate the flow.
   - Content Modifier: Insert a Content Modifier step in the flow. Use the
     content modifier to add some dummy value to the message header.
   - End Event: Add an End event to complete the integration flow.

2. Deploy the Flow

### Step 2: Deploy the process integration runtime in sap btp

1. Go to your SAP BTP subaccount where the SAP Integration Suite is running.

2. Deploy the Process Integration Runtime

   - Navigate to Instance and Subscription in your subaccount.
   - Create instance of the SAP Process Integration Runtime using the
     `integration-flow` plan.
   - Set the Roles for the instance as `ESBMessaging.send` and the Grant-types
     as `Client Credentials`. ![SAP Process Integration Runtime parameters step
1](./imgs/create-if-runtime-1.png) ![SAP Process Integration Runtime
parameters step 2](./imgs/create-if-runtime-2.png)

3. Create a new service key for the Process Integration Runtime using
   `ClientId/Secret` as the key type.

### Step 3: Invoke the flow Using HTTPie or Postman

Store client credentials as environment variables (optional but recommended
for security):

1. In your terminal or environment, set the following variables:

   ```bash
   export CLIENT_ID="client_id_of_the_service_key"
   export CLIENT_SECRET="client_secret_of_the_service_key"
   ```

2. Invoke the integration flow.

   - Get the endpoint of the flow by navigating to `Monitor` and then the
     `Manage Integration Content`.
   - Also set the log level to `Trace`.
   - Invoke the integration flow using e.g. HTTPie and the command below. Note
     that the example contains some JSON data that is sent to the flow.

     ```bash
     http -a $CLIENT_I:$CLIENT_SECRET POST \
     "https://<your_integration_runtime_url> \
     name=Christian email=drumm@fh-aachen.de
     ```

     This request should trigger the flow, and you can see the processing
     details in message monitor.

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./integration-suite.md) | [Next Chapter >](./messaging.md)
