service SimpleERPApi  @(
     path    : '/rest/api',
     protocol: 'rest',
     impl    : 'srv/simpleerp-api'
) {
    function getProducts() returns String;
}