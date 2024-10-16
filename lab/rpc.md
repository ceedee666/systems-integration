# Lab 3: Synchronizing product stock and purchase orders

<!--toc:start-->

- [Lab 3: Synchronizing product stock and purchase orders](#lab-3-synchronizing-product-stock-and-purchase-orders)
  - [Objective](#objective)
  - [Requirements](#requirements)
  - [Additional Considerations](#additional-considerations)
  - [Navigation](#navigation)
  <!--toc:end-->

## Objective

In this exercise, you will implement a real-time synchronization mechanism
using Remote Procedure Calls (RPC) to ensure that the ERP system the single
source of truth for both product stock levels and purchase orders. The web shop
will request stock levels and create purchase orders in the ERP system in
real-time whenever necessary.

## Requirements

1. **Centralized Stock Management**:

   - **ERP as Source of Truth**: The ERP system will manage and store all stock
     levels. The web shop will not maintain any local stock data.
   - **Real-Time Stock Query**: Implement an RPC call in the web shop to
     retrieve the current stock level for a product directly from the ERP system
     whenever a customer views a product or attempts to place an order.
   - The web shop should handle stock availability dynamically based on the
     data returned by the ERP system, displaying "in stock" or "out of stock"
     accordingly.

2. **Purchase Order Creation**:

   - **Centralized Order Management**: The ERP system will store and manage all
     purchase orders. The web shop will create new purchase orders by making an
     RPC call to the ERP system whenever a customer completes a purchase.
   - The web shop must pass the necessary order details (e.g., product ID,
     quantity, customer info) to the ERP system, which will store the purchase
     order and return a confirmation or order ID.
   - Implement real-time feedback from the ERP system to the web shop, such as
     order confirmation or failure messages if stock is insufficient.

3. **Error Handling & Retries**:
   - Ensure proper error handling for cases such as failed RPC calls, network
     issues, or unavailable services. Implement retry logic for failed requests.
   - Consider the performance implications of querying stock data in real-time.
     Explore caching options if necessary, but ensure the web shop never holds
     outdated stock data.

## Additional Considerations

- Think about the pros and cons of using RPC for system integration. What are
  the benefits of real-time synchronization, and what challenges might arise
  (e.g., performance, tight coupling of systems)?
- Consider how this approach might scale as more systems or services are added
  to the architecture. Be prepared to discuss the limitations of RPC in more
  complex environments. What happens if the ERP system is temporarily
  unavailable, and how might this impact the user experience?

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./file-transfer.md) | [Next
Chapter >](./integration-suite.md)
