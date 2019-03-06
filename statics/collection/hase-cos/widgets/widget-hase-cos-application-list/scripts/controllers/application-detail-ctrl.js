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
    // ApplicationDetailCtrl.prototype.approval = function(){

    // }
    ApplicationDetailCtrl.prototype.approval = function(size, parentSelector){debugger;
        console.log(size);
        console.log(parentSelector);
        var parentElem = parentSelector ? 
        angular.element(document.querySelector('.modal-demo ' + parentSelector)) : undefined;
        var modalInstance = this.$uibModal.open({
            animation: true,
            ariaLabelledBy: 'modal-title',
            ariaDescribedBy: 'modal-body',
            templateUrl: 'myModalContent.html',
            controller: 'ApplicationDetailCtrl',
            controllerAs: 'applicationDetailCtrl',
            size: size,
            appendTo: parentElem,
            resolve: {
                items: function () {
                //return this.$scope.items;
                return "";
                }
            }
        });

        modalInstance.result.then(function (selectedItem) {
        //this.$scope.selected = selectedItem;
        }, function () {
        //$log.info('Modal dismissed at: ' + new Date());
        });

    }
    module.exports = ApplicationDetailCtrl;
});
