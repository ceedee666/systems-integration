using SimpleERPService as service from '../../srv/simpleerp-service';

extend projection service.Orders with {
    virtual null as pickEnabled     : Boolean @UI.Hidden,
    virtual null as shipEnabled     : Boolean @UI.Hidden,
    virtual null as completeEnabled : Boolean @UI.Hidden,
    virtual null as cancelEnabled   : Boolean @UI.Hidden,
}

annotate service.Orders with actions {
    pickOrder     @(
        Core.OperationAvailable            : in.pickEnabled,
        Common.SideEffects.TargetProperties: [
            'in/orderStatus_status',
            'in/pickEnabled',
        ]
    );
    shipOrder     @(
        Core.OperationAvailable            : in.shipEnabled,
        Common.SideEffects.TargetProperties: [
            'in/orderStatus_status',
            'in/shipEnabled',
        ]
    );
    completeOrder @(
        Core.OperationAvailable            : in.completeEnabled,
        Common.SideEffects.TargetProperties: [
            'in/orderStatus_status',
            'in/completeEnabled',
        ]
    );
    cancelOrder   @(
        Core.OperationAvailable            : in.cancelEnabled,
        Common.SideEffects.TargetProperties: [
            'in/orderStatus_status',
            'in/cancelEnabled',
        ]
    );
}
