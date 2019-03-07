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

    function ApplicationDetailCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,commonService,$stateParams) {


        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;  
        this.commonService =  commonService; 
        this.$stateParams = $stateParams;

        
    }

    ApplicationDetailCtrl.prototype.$onInit = function() {
        console.log("2222222222"+this.$rootScope.$stateParams);
        console.log("2222222222"+this.$rootScope.$stateParams);
        // Do initialization here
        this.$scope.id = this.$stateParams.id;
        console.log(this.$scope.id);
        this.$scope.reject = false;
        this.$scope.fullUserName = "Chrismrs Wong";
        this.$scope.simpleUserName = "CW";
        this.$scope.selectedLanguage = "English";
        var data = {};
        this.commonService.getCommonMessage(data).then(
            function(response){

            },function(){

            }
        )
        this.$scope.checklists = [
            {"id":"1","txt":"Booked Time Slot"},
            {"id":"2","txt":"Booked Ssh Slot"},
            {"id":"3","txt":"Booked Http Slot"},
            {"id":"4","txt":"Booked Fun Slot"},
            {"id":"5","txt":"Booked Shi Slot"}
        ];
        this.$scope.appliDetails = [
            {"title":"Status","content":"Pedding"},
            {"title":"Appointment","content":"31 Dec 2020, 13:30 Central"},
            {"title":"Appointment","content":"31 Dec 2020, 13:30 Central"},
            {"title":"Assigned to:","content":"Booked Fun Slot"},
            {"title":"Assigned to:","content":"Booked Shi Slot"}
        ];
        //checkList select data
        this.$scope.selected = [] ; 
        this.$scope.isAllCheck = true;
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
     
      
    ApplicationDetailCtrl.prototype.isChecked = function(id){  
        return this.$scope.selected.indexOf(id) >= 0 ;  
    } ;  
    ApplicationDetailCtrl.prototype.updateSelection = function($event,id){  
        var applicationDetailCtrl =this;
        var checkbox = $event.target ;  
        var checked = checkbox.checked ;  
        if(checked){  
            this.$scope.selected.push(id) ;  
            if(applicationDetailCtrl.$scope.selected.length == applicationDetailCtrl.$scope.checklists.length){
                applicationDetailCtrl.$scope.isAllCheck = false;
            }
        }else{  
            var idx = this.$scope.selected.indexOf(id) ;  
            this.$scope.selected.splice(idx,1) ;  
            applicationDetailCtrl.$scope.isAllCheck = true;
        }   
    } ;
    module.exports = ApplicationDetailCtrl;
});
