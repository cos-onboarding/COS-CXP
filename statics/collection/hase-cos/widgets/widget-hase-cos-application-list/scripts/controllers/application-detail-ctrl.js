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

    function ApplicationDetailCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,commonService,$stateParams,$http) {


        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;  
        this.commonService =  commonService; 
        this.$stateParams = $stateParams;
        this.$http = $http;
        this.serviceUrl = lpWidget.getPreference("serviceUrl");

        
    }

    ApplicationDetailCtrl.prototype.$onInit = function() {
        var applicationDetailCtrl = this;
        
        // Do initialization here
        var rejectStr = '';
        var status ='';
        this.$scope.items = [];
        this.$scope.flag = false;
        this.$scope.id = this.$stateParams.Application_ID;
        this.$scope.staff_id = this.$stateParams.staff_id;

        this.$scope.roleId = this.$stateParams.role_id;
        this.$scope.roleName = this.$stateParams.role_name;
       

        //reject返回详情页后进行状态判断
        if(this.$stateParams.status.indexOf("Rejected")>-1){
            this.$scope.flag = true;
            rejectStr = this.$stateParams.status.substring(this.$stateParams.status.length-8,this.$stateParams.status.length);
            status = this.$stateParams.status.substring(0,this.$stateParams.status.length-8);
           
           
        }else{
            this.$scope.status = this.$stateParams.status;
        }
        
        this.$scope.appointTime = this.$stateParams.Appointment_Date_Time;
        this.$scope.assignTo = this.$stateParams.Handling_Call_Agent;
        this.$scope.remarkState = this.$stateParams.remarkState;
		this.$scope.ccc = getDepartmentRole(applicationDetailCtrl,"CCC");
        this.$scope.bbc = getDepartmentRole(applicationDetailCtrl,"BBC");
		
        this.$scope.isApplicationDetail = true;
		this.$scope.isReactive = false;
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

		
		//reactivate or not
        if (this.$scope.status === "Rejected") {
            var currentlyFlag = judgeDepartment(applicationDetailCtrl, this.$scope.roleName);
            this.$scope.currentlyFlag = currentlyFlag;
            var data = {
                applicationId: applicationDetailCtrl.$scope.id,
                url: '/getRejectedRoleName'
            };
            this.commonService.getCommonServiceMessage(data).then(
                function (response) {
                    var rejectedFlag = judgeDepartment(applicationDetailCtrl, response.data.roleName.replace(' ','_'))
                    if (rejectedFlag == currentlyFlag) {
                        applicationDetailCtrl.$scope.isReactive = true;
                    }
                }
            );
        }
        //将reject的状态回显页面
        if(this.$scope.flag){
            this.$scope.status = rejectStr;
        }

        console.log("=============status:"+this.$scope.status+"===============");
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
            
                var st ='';
                if(ctrl.widget.getPreference(role+".Application_Level_Info."+value).indexOf(",")>0){
                    st = ctrl.widget.getPreference(role+".Application_Level_Info."+value).split(",");
                }else{
                    st = ctrl.widget.getPreference(role+".Application_Level_Info."+value);
                }
                if(st.includes(ctrl.$scope.status) && value =='Status'){
                    ctrl.$scope.statusLevel = true;
                }
                if(st.includes(ctrl.$scope.status) && value =='Appointment'){
                    ctrl.$scope.appointLevel = true;
                }
                 if(st.includes(ctrl.$scope.status) && value =='Assigned_To'){
                    ctrl.$scope.assingnLevel = true;
                }
           
        }
        
    }
	
	function judgeDepartment(ctrl, role) {
        var flag;
        if (ctrl.$scope.ccc.includes(role)) {
            flag = "CCC";
        }
        if (ctrl.$scope.bbc.includes(role)) {
            flag = "BBC"
        }
        return flag;
    }

    function getDepartmentRole(ctrl, department) {
        var departmentRole = "";
        if (ctrl.widget.getPreference(department).indexOf(",") > 0) {
            departmentRole = ctrl.widget.getPreference(department).split(",");
        } else {
            departmentRole = ctrl.widget.getPreference(department);
        }
        return departmentRole;
    }
    //return previous applicationList
    ApplicationDetailCtrl.prototype.prePage = function(){
        var param = {role_id:this.$scope.roleId,role_name:this.$scope.roleName};
        this.$rootScope.$state.go('C1',param);
    }
    //reject alert box
    ApplicationDetailCtrl.prototype.reject = function(){
        //this.$scope.reject = true;
        var param = {Appcation_ID: this.$scope.id,staff_id:this.$scope.staff_id,role_name: this.$scope.roleName,Appointment_Date_Time:this.$scope.appointTime,role_id:this.$scope.roleId,Handling_Call_Agent:this.$scope.assignTo,status:this.$scope.status,remarkState:this.$scope.remarkState };
        this.$rootScope.$state.go('C3',param);
       
    }
    //reactivate alert box
    ApplicationDetailCtrl.prototype.reactivateClick = function () {
        var applicationDetailCtrl = this;
        var data = {
            applicationId: applicationDetailCtrl.$scope.id,
            roleName:applicationDetailCtrl.$scope.roleName,
            url: '/reactivateStatus'
        };
        this.commonService.getCommonServiceMessage(data).then(
            function (response) {
                applicationDetailCtrl.$scope.reactivate = false;
                applicationDetailCtrl.$scope.isReactive = false;
                applicationDetailCtrl.$scope.status = response.data.status;
                applicationDetailCtrl.$scope.toastContent2 = response.data.msg;
                $("#ReactivateToast").delay(1000).slideDown(500).delay(2000).fadeOut(500);
            }
        );
    }
    ApplicationDetailCtrl.prototype.Cancel = function(){
        this.$scope.reject = false;

    }
    ApplicationDetailCtrl.prototype.SaveAssign = function(){
        this.$scope.reject = false;

    }
	ApplicationDetailCtrl.prototype.CancelReactivate = function () {
		this.$scope.reactivate = false;
    }    
    ApplicationDetailCtrl.prototype.reactivate = function () {
        this.$scope.reactivate = true;
    }
 
    // remark
    ApplicationDetailCtrl.prototype.callRemark =function(){

        var applicationDetailCtrl = this;
        applicationDetailCtrl.$scope.$broadcast("getRemark", { applicationId: applicationDetailCtrl.$scope.id,staffId: applicationDetailCtrl.$scope.staff_id});
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
    //Status pop up request
    ApplicationDetailCtrl.prototype.selectRejectReason = function(){
        var applicationDetailCtrl =this;
        
        applicationDetailCtrl.$http.post(applicationDetailCtrl.serviceUrl +"/selectRejectReason",{"Application_ID": this.$scope.id})
        .then(function(response){
            
            applicationDetailCtrl.$scope.items = response.data;
         
         }).catch(function(){});
          
    }
    
    module.exports = ApplicationDetailCtrl;
});
