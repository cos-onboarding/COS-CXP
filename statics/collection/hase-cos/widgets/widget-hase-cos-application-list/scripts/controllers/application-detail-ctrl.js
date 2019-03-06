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
    function ApplicationDetailCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,$uibModal) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;  
        this.$uibModal =  $uibModal;  
        
    }

    ApplicationDetailCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.reject = false;
        this.$scope.fullUserName = "Chrismrs Wong";
        this.$scope.simpleUserName = "CW";
        this.$scope.selectedLanguage = "English";
        this.$scope.checklists = [
            {"id":"PG","txt":"Booked Time Slot"},
            {"id":"SG","txt":"Booked Time Slot"},
            {"id":"SF","txt":"Booked Time Slot"},
            {"id":"PF","txt":"Booked Time Slot"},
            {"id":"C","txt":"Booked Time Slot"}
        ];
        //model
        this.$scope.items = ['item1', 'item2', 'item3'];

        this.$scope.animationsEnabled = true;
    };
    //return previous applicationList
    ApplicationDetailCtrl.prototype.prePage = function(){
        this.$rootScope.$state.go('C1');
    }
    //reject alert box
    ApplicationDetailCtrl.prototype.reject = function(){
        this.$scope.reject = true;
    }
    ApplicationDetailCtrl.prototype.Cancel = function(){
        this.$scope.reject = false;

    }
    ApplicationDetailCtrl.prototype.SaveAssign = function(){
        this.$scope.reject = false;

    }
    module.exports = ApplicationDetailCtrl;
});
