# Lab 2: Transferring Product Information from ERP to Web Shop

<!--toc:start-->

- [Lab 2: Transferring Product Information from ERP to Web Shop](#lab-2-transferring-product-information-from-erp-to-web-shop)
  - [Objective](#objective)
  - [Requirements](#requirements)
  - [Additional Considerations](#additional-considerations)
  - [Navigation](#navigation)
  <!--toc:end-->

## Objective

In this exercise, you will transfer product information from the [ERP
system](./mini-erp.md) to the [Web shop](./simple-web-shop.md) you implemented
in the previous exercise. The transfer will be done using files, simulating a
basic integration method through file exchange.

The ERP system already provides a file export for product information on the
UI. This file includes at least the following attributes for each product:
product ID, name, description and price.

## Requirements

1. **Web Shop File Import**:

   - Implement a process in your web shop to read the product information from
     the transferred file and update the product listings accordingly.
   - The web shop should reflect any changes in the ERP system, including new
     products, price updates, and changes in stock availability.

2. **File Transfer Process**:

   - Develop a mechanism for exporting the product data from the ERP system and
     importing it into the Web shop.
   - Consider file naming conventions, the location where files are stored, and
     how often files are transferred (e.g., periodically or on-demand).

3. **Error Handling**:
   - Consider how your system will handle errors, such as invalid file formats,
     missing fields, or failed transfers.
   - Implement basic error handling to ensure the integration process is
     robust.

## Additional Considerations

- The exercise simulates real-world scenarios where file-based integration is
  common in legacy systems. Reflect on the advantages and limitations of this
  approach.
- Think about how this method could be improved or automated further, and be
  ready to discuss how to ensure data consistency between the two systems.

## Navigation

🏠 [Overview](../README.md) | [< Previous Chapter](./simple-web-shop.md) | [Next Chapter >](./rpc.md)
