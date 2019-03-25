/**
 * Controllers
 * @module controllers
 */
define(function (require, exports, module) {

    'use strict';

    /**
     * HeaderCtrl controller
     * @ngInject
     * @constructor
     */
    function HeaderCtrl(model, lpWidget, lpCoreUtils,$scope,commonService) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$scope = $scope;
        this.commonService=commonService;
    }

    HeaderCtrl.prototype.$onInit = function() {
        var headerCtrl = this;
        // Do initialization here

        var data = {
            url: '/getSession'
        };
        this.commonService.getCommonServiceMessage(data).then(
            function (response) {debugger;
                headerCtrl.$scope.roleName = response.data.roleName;
                headerCtrl.$scope.roleId = response.data.roleId;
            },function(){

            }
        );
    };

    module.exports = HeaderCtrl;
});
