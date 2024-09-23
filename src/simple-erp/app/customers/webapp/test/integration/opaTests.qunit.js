sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'de/fhaachen/drumm/customers/test/integration/FirstJourney',
		'de/fhaachen/drumm/customers/test/integration/pages/CustomersList',
		'de/fhaachen/drumm/customers/test/integration/pages/CustomersObjectPage'
    ],
    function(JourneyRunner, opaJourney, CustomersList, CustomersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('de/fhaachen/drumm/customers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCustomersList: CustomersList,
					onTheCustomersObjectPage: CustomersObjectPage
                }
            },
            opaJourney.run
        );
    }
);