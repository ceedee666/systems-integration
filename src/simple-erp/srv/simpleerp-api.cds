service SimpleERPApi @(
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
        orderID     :      Integer;
        customer    :      UUID;
        orderDate   :      Date;
        orderAmount :      Decimal(10, 2);
        currency    :      String(3);
        orderStatus :      Integer;
        items       : many OrderItems;
    }

    define type Products {
        productID   : String(50) not null;
        name        : String(100);
        description : String(500);
        price       : Decimal(10, 2);
        currency    : String(3);
        stock       : Integer;
    }

    define type Customers {
        customerID  : UUID;
        name        : String(100) not null;
        email       : String(100) not null;
        street      : String(100);
        houseNumber : String(10);
        city        : String(100);
        postalCode  : String(10);
        country     : String(3);
    }

    function getProducts() returns String;
    function products()    returns many Products;
    function orders()      returns many Orders;
    function customers()   returns many Customers;
    action   createOrder(order : Orders);
}

annotate SimpleERPApi with @(requires: 'system-integration');
