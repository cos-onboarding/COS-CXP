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
        var applicationDetailCtrl = this;
        // Do initialization here
        
        this.$scope.id = this.$stateParams.Application_ID;
        this.$scope.roleId = this.$stateParams.role_name;
        this.$scope.roleName = this.$stateParams.role_name;
        this.$scope.status = this.$stateParams.status;
        this.$scope.appointTime = this.$stateParams.Appointment_Date_Time;
        this.$scope.assignTo = this.$stateParams.Handling_Call_Agent;

        this.$scope.isApplicationDetail = true;

        this.$scope.reject = false;
        //application level mock
        this.$scope.statusLevel = false;
        this.$scope.appointLevel = false;
        this.$scope.assingnLevel = false;
        
        
        //applicationDetail deal with
        if(this.$scope.status){
            judgeAppLevel(applicationDetailCtrl,"Status",role);
            judgeAppLevel(applicationDetailCtrl,"Assigned_To",role);
            judgeAppLevel(applicationDetailCtrl,"Appointment",role);
            
        }else{
            applicationDetailCtrl.$scope.isApplicationDetail = true;
        }
        //this.$scope.appliDetails =[];
        //return applicationDetail
        // var data = {
        //     applicationId:applicationDetailCtrl.$scope.id,
        //     roleId: applicationDetailCtrl.$scope.roleId,
        //     status:applicationDetailCtrl.$scope.status,
        //     url:'/applicationDetailSeach'
        // };
        // this.commonService.getCommonServiceMessage(data).then(
        //     function(response){
        //         applicationDetailCtrl.$scope.appliDetails = response.data
        //     },function(){
        //         //applicationDetailCtrl.$rootScope.$state.go('C');
        //     }
        // );
        var dataCheck = {
            //applicationId:applicationDetailCtrl.$scope.id,
            // status: applicationDetailCtrl.$scope.status,
            // roleId: applicationDetailCtrl.$scope.roleId,
            status:'Pending for Handling',
            roleId:'946ed4103b3611e9b40a68f728192098',
            url:'/applicationCheckSeach'
        };

        //return checkList
        this.commonService.getCommonServiceMessage(dataCheck).then(
            function(response){
                applicationDetailCtrl.$scope.checklists = response.data
            },function(){
                applicationDetailCtrl.$rootScope.$state.go('C');
            }
        );
        // this.$scope.checklists = [
        //     {"id":"1","txt":"Booked Time Slot"},
        //     {"id":"2","txt":"Booked Ssh Slot"},
        //     {"id":"3","txt":"Booked Http Slot"},
        //     {"id":"4","txt":"Booked Fun Slot"},
        //     {"id":"5","txt":"Booked Shi Slot"}
        // ];
        // this.$scope.appliDetails = [
        //     {"title":"Status","content":"Pedding"},
        //     {"title":"Appointment","content":"31 Dec 2020, 13:30 Central"},
        //     {"title":"Appointment","content":"31 Dec 2020, 13:30 Central"},
        //     {"title":"Assigned to:","content":"Booked Fun Slot"},
        //     {"title":"Assigned to:","content":"Booked Shi Slot"}
        // ];
        //checkList select data
        this.$scope.selected = [] ; 
        this.$scope.isAllCheck = true;
    };
    function judgeAppLevel(ctrl,value,role){
        if(!ctrl.widget.getPreference(role+".Application_Level_Info."+value)){
            if(ctrl.widget.getPreference(role+".Application_Level_Info."+value).indexOf(",")>0){
                var st = ctrl.widget.getPreference(role+".Application_Level_Info."+value).split(",");
                if(st.indexOf(ctrl.$scope.status)>0){
                    ctrl.$scope.statusLevel = true;
                }
            }
        }
        
    }
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
