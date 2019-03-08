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
        this.commonService.getCommonServiceMessage(data)
            .then(function (response) {
                if(response.data.roleId){
                    loginCtrl.$rootScope.$state.go('C1',{id:response.data.roleId});
                }else{
                    loginCtrl.$rootScope.$state.go('C');
                }
            }, function () {
                loginCtrl.$rootScope.$state.go('C');
            });
    }
    module.exports = LoginCtrl;
});