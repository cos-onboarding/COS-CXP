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
    function ApplicationCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
    }

    ApplicationCtrl.prototype.$onInit = function() {
        // Do initialization here
    };
    ApplicationCtrl.prototype.click = function() {
        // Do initialization here
        this.$rootScope.$state.go('C2');
    };
    module.exports = ApplicationCtrl;
});
