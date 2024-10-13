using de.fhaachen.simpleerp as erp from '../db/simpleerp-schema.cds';

service SimpleERPService {
    entity Products   as projection on erp.Products;
    entity Customers  as projection on erp.Customers;

    entity Orders     as projection on erp.Orders
        actions {
            action pickOrder();
            action shipOrder();
            action completeOrder();
            action cancelOrder();
        };

        

    entity OrderItems as projection on erp.OrderItems
}

annotate SimpleERPService with @(requires: 'system-integration');