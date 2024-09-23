using SimpleERPService as service from '../../srv/simpleerp-service';
using from '@sap/cds/common';

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
    ],
    UI.SelectionFields : [
        productID,
        name,
    ],
);

annotate service.Products with {
    productID @Common.Label : '{i18n>Productid}'
};

annotate service.Products with {
    name @Common.Label : '{i18n>Productname}'
};

annotate service.Products with {
    currency @(
        Common.Text : {
            $value : currency_code,
            ![@UI.TextArrangement] : #TextFirst
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Currencies with {
    code @Common.Text : descr
};

annotate service.Products with {
    price @Measures.ISOCurrency : currency_code
};

