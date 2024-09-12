using de.fhaachen.simpleerp as erp from '../db/simpleerp-schema.cds';

service SimpleERPService {
    @odata.draft.enabled
    entity Products as projection on erp.Products;
    entity Customers as projection on erp.Customers;
    entity Orders as projection on erp.Orders;
}
