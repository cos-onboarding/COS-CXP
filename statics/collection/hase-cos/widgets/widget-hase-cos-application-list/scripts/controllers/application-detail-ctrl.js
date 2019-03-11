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
        this.$scope.roleId = this.$stateParams.role_id;
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

        this.$scope.statusLevelJudge = false;
        this.$scope.appointLevelJudge = false;
        this.$scope.assingnLevelJudge = false;
        if(this.$scope.status !=undefined && this.$scope.status!= null && this.$scope.status!= '' && this.$scope.status !='undefined'){
            this.$scope.statusLevelJudge = true;
        }
        if(this.$scope.appointTime !=undefined && this.$scope.appointTime!= null && this.$scope.appointTime!= '' && this.$scope.appointTime !='undefined'){
            this.$scope.appointLevelJudge = true;
        }
        if(this.$scope.assignTo !=undefined && this.$scope.assignTo!= null && this.$scope.assignTo!= '' && this.$scope.assignTo !='undefined'){
            this.$scope.assingnLevelJudge = true;
        }
        
        
        
        //applicationDetail deal with
        if(this.$scope.status){
            judgeAppLevel(applicationDetailCtrl,"Status",this.$scope.roleName);
            judgeAppLevel(applicationDetailCtrl,"Assigned_To",this.$scope.roleName);
            judgeAppLevel(applicationDetailCtrl,"Appointment",this.$scope.roleName);
            
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
       
        this.$scope.selected = [] ; 
        this.$scope.isAllCheck = true;
    };
    function judgeAppLevel(ctrl,value,role){
        if(ctrl.widget.getPreference(role+".Application_Level_Info."+value)){
            if(ctrl.widget.getPreference(role+".Application_Level_Info."+value).indexOf(",")>0){
                var st = ctrl.widget.getPreference(role+".Application_Level_Info."+value).split(",");
                if(st.includes(ctrl.$scope.status) && value =='Status'){
                    ctrl.$scope.statusLevel = true;
                    if (true) {

                    }
                }
                 if(st.includes(ctrl.$scope.status) && value =='Assigned_To'){
                    ctrl.$scope.appointLevel = true;
                }
                 if(st.includes(ctrl.$scope.status) && value =='Appointment'){
                    ctrl.$scope.assingnLevel = true;
                }
            }
        }
        
    }
    //return previous applicationList
    ApplicationDetailCtrl.prototype.prePage = function(){
        var param = {role_id:this.$scope.roleId,role_name:this.$scope.roleName};
        this.$rootScope.$state.go('C1',param);
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
