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
    function RejectCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,commonService,$stateParams,$http) {


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

    RejectCtrl.prototype.$onInit = function(){
        var rejectCtrl = this;
        this.$scope.Appcation_ID = this.$stateParams.Appcation_ID;
        this.$scope.staff_id = this.$stateParams.staff_id;
        this.$scope.role_name = this.$stateParams.role_name;
        this.$scope.role_id = this.$stateParams.role_id;
        this.$scope.Appointment_Date_Time =this.$stateParams.Appointment_Date_Time;
        this.$scope.Handling_Call_Agent = this.$stateParams.Handling_Call_Agent;
        this.$scope.status = this.$stateParams.status;
      

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
        var staff_id = this.$scope.staff_id;
        var reCategory = this.$scope.province;
        var emCategory = this.$scope.provinceTwo;
        var rejectReason = this.$scope.rejectReason;
        var isEnhanced = this.$scope.isEnhanced ? 'Yes' : 'No';
        var isNexus = this.$scope.isNexus ? 'Yes' : 'No';
        
        //数据库保存的参数
        var param = {
            Appcation_ID:this.$scope.Appcation_ID,
            reject_date:time,
            reject_staff:staff_id,
            reject_category:reCategory,
            reject_email:emCategory,
            reject_reason:rejectReason,
            isEnhanced:isEnhanced,
            isNexus:isNexus   
        }
        //跳转到详情页需要的参数
        var detailParam = {
            role_name:this.$scope.role_name,
            Application_ID:this.$scope.Appcation_ID,
            Appointment_Date_Time:this.$scope.Appointment_Date_Time,
            Handling_Call_Agent:this.$scope.Handling_Call_Agent,
            role_id:this.$scope.role_id,
            status:this.$scope.status +"Rejected" ,
            staff_id:this.$scope.staff_id,
            
        }
        //console.log(detailParam);

        rejectCtrl.$http.post(rejectCtrl.serviceUrl+"/saveRejectReason",param)
        .then(function(response){
           
           if(response.data.msg == "success"){
               $(".modal-backdrop").hide();
                rejectCtrl.$rootScope.$state.go('C2',detailParam);

           }else{
               console.log("insert database fail,please contact backend");
           }
        }).catch(function(){});


    }


    module.exports = RejectCtrl;
});