sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'de.fhaachen.drumm.orders',
            componentId: 'OrderPositionsObjectPage',
            contextPath: '/Orders/items'
        },
        CustomPageDefinitions
    );
});