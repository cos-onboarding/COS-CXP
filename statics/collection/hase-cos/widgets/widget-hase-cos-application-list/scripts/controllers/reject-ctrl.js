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
    function RejectCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,commonService,$stateParams) {


        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;  
        this.commonService =  commonService; 
        this.$stateParams = $stateParams;

        
    }

    RejectCtrl.prototype.$onInit = function(){
        var rejectCtrl = this;
        this.$scope.Appcation_ID = this.$stateParams.Appcation_ID;
        this.$scope.staff_id = this.$stateParams.staff_id;
        var date = new Date(); 
        this.$scope.dateTime = date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate();
        //console.log(this.$scope.Appcation_ID+"<-->"+this.$scope.staff_id);
        this.$scope.selected = [] ;
    }

    RejectCtrl.prototype.isChecked = function(id){  
        return this.$scope.selected.indexOf(id) >= 0 ;  
    } ;

    RejectCtrl.prototype.updateSelection = function($event,id){
        var rejectCtrl = this;
        var checkbox = $event.target ;  
        this.$scope.isEnhanced = checkbox.checked;
       
    };

    RejectCtrl.prototype.isCheckedTwo = function(id){  
        return this.$scope.selected.indexOf(id) >= 0 ;  
    } ;

    RejectCtrl.prototype.updateSelectionTwo = function($event,id){
        var rejectCtrl = this;
        var checkbox = $event.target ;  
        this.$scope.isNexus = checkbox.checked;
    };
    //cancel回退
    RejectCtrl.prototype.backDetailPage = function(){
        
        history.back();

    }
    //confirm
    RejectCtrl.prototype.submit = function(){
        var rejectCtrl = this;
        var time = this.$scope.dateTime;
    }


    





    module.exports = RejectCtrl;
});