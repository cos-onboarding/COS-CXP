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
            remarkCtrl.$scope.applicationId = data.applicationId;
            console.log(data);
            remarkCtrl.$http.post(remarkCtrl.serviceUrl+"/getRemark", data)
            .then(function (response) {
                remarkCtrl.$scope.remarkList = response.data;
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
            staffId:remarkCtrl.$scope.staffId
        }
        if(remarkCtrl.$scope.remarkCause != ""){
            remarkCtrl.$http.post(remarkCtrl.serviceUrl+"/saveRemark", param)
                .then(function (response) {
                    remarkCtrl.$scope.remarkCause = "";
                    $("#Modal").modal('hide')
                    remarkCtrl.$scope.$emit('topEvent');
                }).catch(function(){

            });
        }else{
            $("#Modal").modal('hide')
        }
    }
    
    module.exports = RemarkCtrl;
});