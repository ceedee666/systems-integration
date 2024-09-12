using de.fhaachen.simpleerp as erp from '../db/schema';

service ERPService {
    @odata.draft.enabled
    entity Products as projection on erp.Products;
    entity Customers as projection on erp.Customers;
    entity Orders as projection on erp.Orders;
}
