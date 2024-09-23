sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'de/fhaachen/drumm/orders/test/integration/FirstJourney',
		'de/fhaachen/drumm/orders/test/integration/pages/OrdersList',
		'de/fhaachen/drumm/orders/test/integration/pages/OrdersObjectPage',
		'de/fhaachen/drumm/orders/test/integration/pages/OrderPositionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage, OrderPositionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('de/fhaachen/drumm/orders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage,
					onTheOrderPositionsObjectPage: OrderPositionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);