using SimpleERPUIService as service from '../../srv/simpleerpui-service.cds';

annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Orderid}',
                Value : orderID,
            },
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Orderdate}',
                Value : orderDate,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Orderamount}',
                Value : orderAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Orderstatus}',
                Value : orderStatus_status,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'service.pickOrder',
                Label : '{i18n>Pickorder}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'service.shipOrder',
                Label : '{i18n>Shiporder}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'service.completeOrder',
                Label : '{i18n>Completeorder}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'service.cancelOrder',
                Label : '{i18n>Cancelorder}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Orderitems}',
            ID : 'Items',
            Target : 'items/@UI.LineItem#Items',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Order}',
            Value : orderID,
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>Customer}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Orderdate}',
            Value : orderDate,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Orderamount}',
            Value : orderAmount,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Orderstatus}',
            Value : orderStatus_status,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'service.pickOrder',
            Label : '{i18n>Pickorder}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'service.shipOrder',
            Label : '{i18n>Shiporder}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'service.completeOrder',
            Label : '{i18n>Completeorder}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'service.cancelOrder',
            Label : '{i18n>Cancelorder}',
        },
    ],
    UI.SelectionFields : [
        orderID,
        customer_ID,
        items.product_ID,
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Order}',
        TypeNamePlural : '{i18n>Orders}',
        Title : {
            $Type : 'UI.DataField',
            Value : orderID,
        },
    },
);

annotate service.Orders with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'street',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'houseNumber',
                },
            ],
        },
        Common.Label : '{i18n>Customer}',
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : customer.name,
            ![@UI.TextArrangement] : #TextOnly,
        },
    )
};

annotate service.Orders with {
    orderID @Common.Label : '{i18n>Order}'
};

annotate service.OrderItems with {
    product @(
        Common.Label : '{i18n>Product}',
        Common.SemanticObject : 'Product',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : product_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : product.productID,
            ![@UI.TextArrangement] : #TextOnly
        },
        )
};

annotate service.Orders with {
    orderAmount @(
        Measures.ISOCurrency : currency_code,
        Common.FieldControl : #ReadOnly,
    )
};

annotate service.OrderItems with @(
    UI.LineItem #Items : [
        {
            $Type : 'UI.DataField',
            Value : itemID,
            Label : '{i18n>Itemid}',
        },
        {
            $Type : 'UI.DataField',
            Value : product.ID,
            Label : '{i18n>Product}',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : '{i18n>Quantity}',
        },
        {
            $Type : 'UI.DataField',
            Value : itemAmount,
            Label : '{i18n>Amount}',
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Orderitem}',
        TypeNamePlural : '{i18n>Orderitems}',
        Title : {
            $Type : 'UI.DataField',
            Value : itemID,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Generalinformation}',
            ID : 'i18nGeneralinformation',
            Target : '@UI.FieldGroup#i18nGeneralinformation',
        },
    ],
    UI.FieldGroup #i18nGeneralinformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : itemID,
                Label : '{i18n>Itemid}',
            },
            {
                $Type : 'UI.DataField',
                Value : product_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : quantity,
                Label : '{i18n>Quantity}',
            },
            {
                $Type : 'UI.DataField',
                Value : itemAmount,
                Label : '{i18n>Amount}',
            },
        ],
    },
);

annotate service.OrderItems with {
    itemAmount @(
        Measures.ISOCurrency : currency_code,
        Common.FieldControl : #ReadOnly,
    )
};

annotate service.Customers with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextFirst
    }
};

annotate service.Products with {
    ID @(
        Common.Text : {
        $value : productID,
        ![@UI.TextArrangement] : #TextOnly,
    },
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

