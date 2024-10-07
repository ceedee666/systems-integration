sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'de/fhaachen/drumm/products/test/integration/FirstJourney',
		'de/fhaachen/drumm/products/test/integration/pages/ProductsList',
		'de/fhaachen/drumm/products/test/integration/pages/ProductsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('de/fhaachen/drumm/products') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage
                }
            },
            opaJourney.run
        );
    }
);