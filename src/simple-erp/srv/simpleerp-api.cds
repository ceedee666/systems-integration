service SimpleERPApi  @(
     path    : '/rest/api',
     protocol: 'rest',
     impl    : 'srv/simpleerp-api'
) {
    define type OrderItems {
        itemID     : Integer;
        product    : UUID;
        quantity   : Integer;
        itemAmount : Decimal(10, 2);
        currency   : String(3);
    }

    define type Orders {
        orderID     : Integer;
        customer    : UUID;
        orderDate   : Date;
        orderAmount : Decimal(10, 2);
        currency    : String(3);
        orderStatus : Integer default 10;
        items       : many OrderItems;
    }


    function getProducts() returns String;
    function products() returns String;
    function orders() returns many Orders;

    action createOrder(order: Orders);
}

annotate SimpleERPApi with @(requires: 'system-integration');
