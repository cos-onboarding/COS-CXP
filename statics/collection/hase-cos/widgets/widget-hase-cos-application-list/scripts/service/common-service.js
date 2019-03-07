define(function (require, exports, module) {

    'use strict';

    /**
     * Shortcut service
     * @ngInject
     * @constructor
     */
    commonService.$inject = ['$http', 'lpWidget', 'lpCoreUtils','$location'];
    function commonService($http, lpWidget, lpCoreUtils,$location) {
        //var servicePath = lpCoreUtils.resolvePortalPlaceholders(lpWidget.getPreference('runtimeService'));
        
        var servicePath = "http://localhost:7777/portalserver/services/rest";
        return {
            getCommonServiceMessage: function (data) {
               
                return $http({
                    url: servicePath + data.url,
                    method: 'POST',
                    data:data
                });

            }
        }
    };
   
    module.exports = commonService;
});