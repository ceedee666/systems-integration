using SimpleERPService as service from '../../srv/simpleerp-service';
using from '@sap/cds/common';

annotate service.Customers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Name}',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Email}',
                Value : email,
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
            Label : '{i18n>Address}',
            ID : 'Address',
            Target : '@UI.FieldGroup#Address',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Name}',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Email}',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Street}',
            Value : street,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Housenumber}',
            Value : houseNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>City}',
            Value : city,
        },
    ],
    UI.SelectionFields : [
        name,
        country.code,
    ],
    UI.HeaderInfo : {
        TypeNamePlural : 'Customers',
        TypeName : 'Customer',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeImageUrl : 'sap-icon://customer',
    },
    UI.FieldGroup #Address : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Street}',
                Value : street,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Housenumber}',
                Value : houseNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>City}',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Postalcode}',
                Value : postalCode,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Countrycode}',
                Value : country_code,
            },
        ],
    },
);

annotate service.Customers with {
    postalCode @Common.Label : '{i18n>Postalcode}'
};

annotate service.Customers with {
    city @Common.Label : '{i18n>City}'
};

annotate service.Customers with {
    name @Common.Label : '{i18n>Name}'
};

annotate service.Countries with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextFirst,
    }
};

annotate service.Customers with {
    country @Common.ValueListWithFixedValues : true
};

