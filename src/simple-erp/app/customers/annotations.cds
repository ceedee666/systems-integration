using SimpleERPUIService as service from '../../srv/simpleerpui-service.cds';

annotate service.Customers with @(
    UI.SelectionFields : [
        name,
        country_code,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : email,
            Label : '{i18n>Email}',
        },
        {
            $Type : 'UI.DataField',
            Value : street,
            Label : '{i18n>Street}',
        },
        {
            $Type : 'UI.DataField',
            Value : houseNumber,
            Label : '{i18n>Housenumber}',
        },
        {
            $Type : 'UI.DataField',
            Value : postalCode,
            Label : '{i18n>Postalcode}',
        },
        {
            $Type : 'UI.DataField',
            Value : city,
            Label : '{i18n>City}',
        },
        {
            $Type : 'UI.DataField',
            Value : country_code,
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Customer}',
        TypeNamePlural : '{i18n>Customers}',
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Generalinformation}',
            ID : 'GeneralInformation',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Address}',
            ID : 'Address',
            Target : '@UI.FieldGroup#Address',
        },
    ],
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : '{i18n>Email}',
            },
        ],
    },
    UI.FieldGroup #Address : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : street,
                Label : '{i18n>Street}',
            },
            {
                $Type : 'UI.DataField',
                Value : houseNumber,
                Label : '{i18n>Housenumber}',
            },
            {
                $Type : 'UI.DataField',
                Value : postalCode,
                Label : '{i18n>Postalcode}',
            },
            {
                $Type : 'UI.DataField',
                Value : city,
                Label : '{i18n>City}',
            },
            {
                $Type : 'UI.DataField',
                Value : country_code,
            },
        ],
    },
);

annotate service.Customers with {
    name @Common.Label : '{i18n>Name}'
};

