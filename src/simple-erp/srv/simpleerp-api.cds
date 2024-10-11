service SimpleERPApi  @(
     path    : '/rest/api',
     protocol: 'rest',
     impl    : 'srv/simpleerp-api'
) {
    function getProducts() returns String;
    function products() returns String;
    function orders() returns String;
    action createOrder(data: String);
}

annotate SimpleERPApi with @(requires: 'system-integration');
