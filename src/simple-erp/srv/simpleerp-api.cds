service SimpleERPApi  @(
     path    : '/rest/api',
     protocol: 'rest',
     impl    : 'srv/simpleerp-api'
) {
    function getProducts() returns String;
}

annotate SimpleERPApi with @(requires: 'system-integration');
