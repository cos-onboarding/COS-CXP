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
    function RemarkCtrl(model, lpWidget, lpCoreUtils,commonService,$rootScope,$scope,$http) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.commonService = commonService;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
        this.$http = $http;
        this.serviceUrl = lpWidget.getPreference("serviceUrl");

    }

    RemarkCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.remarkCause = "";
        this.$scope.staffId = "";
        this.$scope.applicationId = "";
        this.$scope.staffName = "";
        this.$scope.remarkList = [];
        this.onRemarkLoad();
    };

    RemarkCtrl.prototype.onRemarkLoad = function(){
        var remarkCtrl = this;
        remarkCtrl.$scope.$on("getRemark", function (event, data) {
            remarkCtrl.$scope.staffId = data.staffId;
            remarkCtrl.$http.post(remarkCtrl.serviceUrl+"/getRemark", data)
            .then(function (response) {
                remarkCtrl.$scope.remarkList = response.data;
                remarkCtrl.$scope.applicationId = response.data.application_id;
                remarkCtrl.$scope.staffName = response.data.staff_name;
                console.log(response);
                $('#Modal').modal('show');
            }).catch(function(){

            });
        });
    };

    RemarkCtrl.prototype.postRemrak = function(){
        var remarkCtrl = this;
        var param = {
            remarkCause:remarkCtrl.$scope.remarkCause,
            applicationId:remarkCtrl.$scope.applicationId,
            staffName:remarkCtrl.$scope.staffName,
            staffId:remarkCtrl.$scope.staffId
        }
        remarkCtrl.$http.post(remarkCtrl.serviceUrl+"/saveRemark", param)
            .then(function (response) {
                $("#Modal").modal('hide')

            }).catch(function(){

        });
    }
    
    module.exports = RemarkCtrl;
});