service SimpleERPApi  @(
     path    : '/rest/api',
     protocol: 'rest',
     impl    : 'srv/simpleerp-api'
) {
    function getProducts() returns String;
    function products() returns String;
    function stock(productID: String) returns Integer;
    function createOrder() returns Boolean;
}

annotate SimpleERPApi with @(requires: 'system-integration');
