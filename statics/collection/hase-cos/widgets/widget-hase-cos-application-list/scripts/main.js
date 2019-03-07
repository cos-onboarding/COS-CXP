/**
 *  ----------------------------------------------------------------
 *  Copyright © Backbase B.V.
 *  ----------------------------------------------------------------
 *  Filename : main.js
 *  Description: Widget for cos application list
 *  ----------------------------------------------------------------
 */

define( function (require, exports, module) {

    'use strict';

    module.name = 'widget-hase-cos-application-list';

    // External Dependencies
    var base = require('base');
    var core = require('core');
    var ui = require('ui');
    require('angular-ui-router');
    require('bootstrap');
    require('bootstrap-table');
    // Internal Dependencies
    var Model = require('./model');
    var MainCtrl = require('./controllers/main-ctrl');
    var ApplicationCtrl = require('./controllers/application-ctrl');
    var ApplicationDetailCtrl = require('./controllers/application-detail-ctrl');
    var commonService  = require("./service/common-service");
    

    var deps = [
        core.name,
        ui.name,
        'ui.router'
    ];

    /**
     * @ngInject
     */
    function run($rootScope,$state,$stateParams) {
        // Module is Bootstrapped
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
    }

    module.exports = base.createModule(module.name, deps)
        .constant('WIDGET_NAME', module.name )
        .controller('MainCtrl', MainCtrl )
        .controller('ApplicationCtrl',ApplicationCtrl)
        .controller('ApplicationDetailCtrl',ApplicationDetailCtrl)
        .factory( 'model', Model )
        .factory('commonService',commonService)
        .config(["$stateProvider","$urlRouterProvider",function($stateProvider,$urlRouterProvider){
           // $urlRouterProvider.otherwise("/");
            $stateProvider.state('C2', {
                url:'/C2/:id',
                template: '<div lp-template="templates/main.ng.html"></div>',
                controller:'ApplicationDetailCtrl'
            }).state('C1', {
                url: '/C1/:id',
                template: '<div lp-template="templates/application.html"></div>',
                controller:'ApplicationCtrl'
            }).state('C', {
                url: '/',
                template: '<div lp-template="templates/login.html"></div>',
                controller:'MainCtrl'
            });
                }])
            .run( ['$rootScope','$state','$stateParams',run] )
            .run(function($state){
                $state.go('C');
            });
});
