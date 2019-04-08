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
    function LoginCtrl(model, lpWidget, lpCoreUtils,commonService,$rootScope,$scope) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.commonService = commonService;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
    }

    LoginCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.userName ="";
        this.$scope.password ="";
    };
    LoginCtrl.prototype.click = function(){
        //this.$rootScope.$state.go('C1',{id:"9e955dfc3b3611e9b40a68f728192098"});
        var loginCtrl = this;
        var data ={
            userName:loginCtrl.$scope.userName,
            password:loginCtrl.$scope.password,
            url:'/login'
        };

        //var param = {role_name:"BA",Application_ID:"f64965fc3ef511e9944e68f728192098",Appointment_Date_Time:"2019-03-05 12:25:00",Handling_Call_Agent:"Beatrice",role_id:"cf4b464c3b3611e9b40a68f728192098",status:"Pending RSO Allocation",staff_id:"0000169064"};
        //loginCtrl.$rootScope.$state.go('C2',param);
        this.commonService.getCommonServiceMessage(data)
            .then(function (response) {
                console.log(response.data);
                if(response.data.roleId){
                    loginCtrl.$rootScope.$state.go('C1',{role_id:response.data.roleId,role_name:response.data.roleName,staffId:response.data.staffId,pageSize:5,page:1});
                }else{
                    loginCtrl.$rootScope.$state.go('C');
                }
            }, function () {
                loginCtrl.$rootScope.$state.go('C');
            });
    }
    module.exports = LoginCtrl;
});