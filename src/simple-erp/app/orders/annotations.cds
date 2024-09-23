using SimpleERPService as service from '../../srv/simpleerp-service';
using from '../../db/simpleerp-schema';

annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Orderdate}',
                Value: orderDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Orderamount}',
                Value: orderAmount,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Orderstatus}',
                Value: orderStatus_status,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Customer}',
            ID    : 'i18nCustomer',
            Target: '@UI.FieldGroup#i18nCustomer',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Orderitems}',
            ID    : 'i18nOrderitems',
            Target: 'items/@UI.SelectionPresentationVariant#i18nOrderitems',
        },
    ],
    UI.LineItem                  : [
        {
            $Type : 'UI.DataField',
            Value : orderID,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Orderdate}',
            Value: orderDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Orderamount}',
            Value: orderAmount,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Orderstatus}',
            Value: orderStatus_status,
        },
        {
            $Type: 'UI.DataField',
            Value: customer.name,
            Label: '{i18n>Customer}',
        },
    ],
    UI.SelectionFields           : [
        orderID,
        items.product_productID,
        orderStatus.status,
        customer.name,
    ],
    UI.FieldGroup #i18nCustomer  : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: customer_ID,
            Label: '{i18n>Customer}',
        }, ],
    },
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : orderID,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>Orderid}',
        TypeNamePlural : '{i18n>Orders}',
        Title : {
            $Type : 'UI.DataField',
            Value : orderID,
        },
        TypeImageUrl : 'sap-icon://sales-order',
    },
);

annotate service.Orders with {
    customer @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Customers',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: customer_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'email',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'street',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'houseNumber',
                },
            ],
        },
        Common.Text                    : {
            $value                : customer.name,
            ![@UI.TextArrangement]: #TextOnly
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.OrderItems with {
    product @(
        Common.Label                   : '{i18n>Productid}',
        Common.SemanticObject          : 'Product',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Products',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: product_productID,
                ValueListProperty: 'productID',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.OrderStatus with {
    status @Common.Label: '{i18n>Orderstatus}'
};

annotate service.Orders with {
    orderAmount @(
        Measures.ISOCurrency: currency_code,
        Common.FieldControl : #ReadOnly,
    )
};

annotate service.Customers with {
    name @(
        Common.SemanticObject          : 'Customer',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Customers',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: name,
                ValueListProperty: 'name',
            }, ],
            Label         : '{i18n>Customer}',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Customers with {
    ID @Common.Text: {
        $value                : name,
        ![@UI.TextArrangement]: #TextOnly
    }
};

annotate service.OrderItems with @(
    UI.LineItem #i18nOrderitems: [
        {
            $Type : 'UI.DataField',
            Value : itemID,
            Label : '{i18n>Itemid}',
        },
        {
            $Type: 'UI.DataField',
            Value: product_productID,
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: '{i18n>Quantity}',
        },
        {
            $Type: 'UI.DataField',
            Value: itemAmount,
            Label: '{i18n>Amount}',
        },
    ],
    UI.Facets                  : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        ID    : 'GeneralInformation',
        Target: '@UI.Identification',
    }, ],
    UI.Identification          : [
        {
            $Type: 'UI.DataField',
            Value: product_productID,
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: '{i18n>Quantity}',
        },
        {
            $Type: 'UI.DataField',
            Value: itemAmount,
            Label: '{i18n>Amount}',
        },
    ],
    UI.SelectionPresentationVariant #i18nOrderitems : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#i18nOrderitems',
            ],
            SortOrder : [
                {
                    $Type : 'Common.SortOrderType',
                    Property : itemID,
                    Descending : false,
                },
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
    },
    UI.HeaderInfo : {
        TypeName : '{i18n>Itemid}',
        TypeNamePlural : '{i18n>Orderitems}',
        Title : {
            $Type : 'UI.DataField',
            Value : itemID,
        },
    },
);

annotate service.OrderItems with {
    itemAmount @(
        Measures.ISOCurrency: currency_code,
        Common.FieldControl : #ReadOnly,
    )
};

annotate service.Products with {
    productID @Common.Text: name
};

annotate service.OrderItems @(Common.SideEffects #ItemAmount: {
    SourceProperties: [
        'product_productID',
        'quantity'
    ],
    TargetProperties: [
        'itemID',
        'itemAmount',
        'currency_code'
    ],
});

annotate service.Orders @(Common.SideEffects #ItemAmount: {
    SourceEntities  : ['items'],
    TargetProperties: [
        'orderAmount',
        'currency_code'
    ],
});

annotate service.Orders with @Common.SemanticKey: [orderID];
annotate service.OrderItems with @Common.SemanticKey: [itemID];
annotate service.Orders with {
    orderID @Common.Label : '{i18n>Orderid}'
};

