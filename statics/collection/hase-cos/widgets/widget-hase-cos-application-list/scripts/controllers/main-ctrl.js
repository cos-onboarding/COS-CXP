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
    function MainCtrl(model, lpWidget, lpCoreUtils,commonService,$rootScope,$scope,) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.commonService = commonService;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
    }

    MainCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.userName ="";
        this.$scope.password ="";
    };
    MainCtrl.prototype.click = function(){
        this.$rootScope.$state.go('C1',{id:"9e955dfc3b3611e9b40a68f728192098"});
        // var mainCtrl = this;
        // var data ={
        //     userName:mainCtrl.$scope.userName,
        //     password:mainCtrl.$scope.password,
        //     url:'/login'
        // };
        // this.commonService.getCommonServiceMessage(data)
        //     .then(function (response) {
        //         if(response.data.status){
        //             mainCtrl.$rootScope.$state.go('C1');
        //         }else{
        //             mainCtrl.$rootScope.$state.go('C');
        //         }
        //     }, function () {
        //         mainCtrl.$rootScope.$state.go('C');
                
        //     });
    }
    module.exports = MainCtrl;
});