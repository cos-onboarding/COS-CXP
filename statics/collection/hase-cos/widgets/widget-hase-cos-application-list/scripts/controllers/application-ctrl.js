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
    function ApplicationCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,$http) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
    }

    ApplicationCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.applicationNumber = '';
        this.$scope.customerId = '';
        this.$scope.customerName = '';
        this.$scope.statusList = [];
        this.$scope.businessCenterList = [];
        this.$scope.staffAssignedList = [];
        this.$scope.summaryStatusList = [{
            "status":'1111',"statusCount":2
        },{"status":'2222',"statusCount":433}];
    };
    ApplicationCtrl.prototype.click = function() {
        // Do initialization here
        this.$rootScope.$state.go('C2');
    };
    /**
     * Zach Y Gao
     * 05-03-2019
     * @param status
     * ** filter applications list data by state ** view button
     */
    ApplicationCtrl.prototype.statusApplicationListButton = function(status){
        this.$scope.fileStatusData = status;
    };

    ApplicationCtrl.prototype.caseSearchButton = function(){
        var params = {
            "applicationNumber": this.$scope.applicationNumber,
            "customerId": this.$scope.customerId,
            "customerName": this.$scope.customerName,
            "status": "statusName",
            "businessCenter": "businessName",
            "staffAssigned": "staffName"
        }
        $http.post("http://,", $scope.formData)
                    .success(function(result){
                     })
                    .error(function(result){
                     });

        this.$scope.fileStatusData = '';
    };

    module.exports = ApplicationCtrl;
});
