define(function (require, exports, module) {

    'use strict';

    /**
     * Shortcut service
     * @ngInject
     * @constructor
     */
    loginService.$inject = ['$http', 'lpWidget', 'lpCoreUtils','$location'];
    function loginService($http, lpWidget, lpCoreUtils,$location) {
        //var servicePath = lpCoreUtils.resolvePortalPlaceholders(lpWidget.getPreference('runtimeService'));
        
        var servicePath = "http://localhost:7777/portalserver/services/rest";
        return {
            getLoginMessage: function (data) {
               
                return $http({
                    url: servicePath + data.url,
                    method: 'POST',
                    data:data
                });

            }
        }
    };
    // loginService.prototype.getLoginMessage=function(data){
    //     return $http({
    //         url: servicePath + data.url,
    //         method: 'POST',
    //         data:data
    //     });
    // }
    module.exports = loginService;
});