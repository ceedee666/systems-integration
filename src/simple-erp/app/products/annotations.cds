using SimpleERPUIService as service from '../../srv/simpleerpui-service.cds';

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Productid}',
                Value : productID,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Productname}',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description}',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Price}',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Stock}',
                Value : stock,
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
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Productid}',
            Value : productID,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Productname}',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Price}',
            Value : price,
        },
        {
            $Type : 'UI.DataField',
            Value : stock,
            Label : '{i18n>Stock}',
        },
    ],
    UI.SelectionFields : [
        productID,
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Product}',
        TypeNamePlural : '{i18n>Products}',
        Title : {
            $Type : 'UI.DataField',
            Value : productID,
        },
    },
);

annotate service.Products with {
    productID @(
        Common.Label : '{i18n>Productid}',
        Common.FieldControl : #Mandatory,
    )
};

annotate service.Products with {
    price @Measures.ISOCurrency : currency_code
};

