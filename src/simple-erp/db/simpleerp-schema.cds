namespace de.fhaachen.simpleerp;

using from '@sap/cds-common-content';

using {
    cuid,
    managed,
    Currency,
    Country
} from '@sap/cds/common';

@assert.unique: {id: [productID]}
entity Products : cuid, managed {
    productID   : String(50);
    name        : String(100);
    description : String(500);
    price       : Decimal(9, 2);
    currency    : Currency;
    stock       : Integer;
}

entity Customers : cuid, managed {
    name    : String(100);
    email   : String(100);
    address : Association to Address;
}

entity Address : cuid, managed {
    street      : String(100);
    houseNumber : String(10);
    city        : String(100);
    postalCode  : String(10);
    country     : Country;
}

entity Orders : cuid, managed {
    customer    : Association to Customers;
    orderDate   : DateTime;
    totalAmount : Decimal(9, 2);
    currency    : Currency;
    positions   : Composition of many OrderPositions
                      on positions.order = $self;
}

entity OrderPositions : cuid, managed {
    order       : Association to Orders;
    product     : Association to Products;
    quantity    : Integer;
    price       : Decimal(9, 2);
    totalAmount : Decimal(9, 2);
}
