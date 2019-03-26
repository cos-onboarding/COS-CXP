/**
 * Controllers
 * @module controllers
 */
define(function (require, exports, module) {

    'use strict';

    /**
     * Main controller
     * @ngInject
     * @constructor
     */
    function MainCtrl(model, lpWidget, lpCoreUtils,shortcutService) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.shortcutService = shortcutService;
    }

    MainCtrl.prototype.$onInit = function() {
        // Do initialization here
    };

    MainCtrl.prototype.click = function() {
        var mainCtrl = this;
        this.shortcutService.getShortcuts()
            .then(function (response) {
                mainCtrl.shortcuts = response.data.items.length && response.data.items || [];
                
                updateConfiguration();
                
                
            }, function () {
               errorFlag=true;
               mainCtrl.scope.lpCoreBus.publish('errorKey',errorFlag);
            });
    };
    module.exports = MainCtrl;
});
