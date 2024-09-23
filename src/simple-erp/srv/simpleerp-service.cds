using de.fhaachen.simpleerp as erp from '../db/simpleerp-schema.cds';

service SimpleERPService {
    entity Products as projection on erp.Products;
    entity Customers as projection on erp.Customers;
    entity Orders as projection on erp.Orders;
    entity OrderItems as projection on erp.OrderItems
}

annotate erp.Products with @odata.draft.enabled;
annotate erp.Customers with @odata.draft.enabled;
annotate erp.Orders with @odata.draft.enabled;