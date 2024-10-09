namespace de.fhaachen.simpleerp;

using from '@sap/cds-common-content';

using {
    cuid,
    managed,
    Currency,
    Country,
    sap.common.CodeList
} from '@sap/cds/common';

entity Products : cuid, managed {
    productID   : String(50) not null;
    name        : localized String(100);
    description : localized String(500);
    price       : Decimal(10, 2);
    currency    : Currency;
    stock       : Integer default 0 @assert.range: [
        0,
        1000
    ];
}

entity Customers : cuid, managed {
    name        : String(100) not null;
    email       : String(100) not null;
    street      : String(100);
    houseNumber : String(10);
    city        : String(100);
    postalCode  : String(10);
    country     : Country;
}

@cds.autoexpose
entity OrderStatus : CodeList {
    key status : Integer enum {
            new       = 10;
            picked    = 20;
            shipped   = 30;
            completed = 40;
            canceled  = -10;
        }
}

entity Orders : cuid, managed {
    orderID     : Integer @readonly default 0;
    customer    : Association to one Customers not null;
    orderDate   : Date not null;
    orderAmount : Decimal(10, 2);
    currency    : Currency;
    orderStatus : Association to OrderStatus default 10;
    items       : Composition of many OrderItems
                      on items.order = $self;
}

entity OrderItems : cuid, managed {
    itemID     : Integer @readonly default 0;
    order      : Association to Orders;
    product    : Association to one Products;
    quantity   : Integer;
    itemAmount : Decimal(10, 2);
    currency   : Currency;
}
