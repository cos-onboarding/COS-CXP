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
    function HeaderCtrl(model, lpWidget, lpCoreUtils,$scope) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$scope = $scope;
    }

    HeaderCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.fullUserName = "EEE";
    };

    module.exports = HeaderCtrl;
});
