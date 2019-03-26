/**
 *  ----------------------------------------------------------------
 *  Copyright © Backbase B.V.
 *  ----------------------------------------------------------------
 *  Filename : main.js
 *  Description: Header widget for cos page
 *  ----------------------------------------------------------------
 */

define( function (require, exports, module) {

    'use strict';

    module.name = 'widget-hase-cos-header';

    // External Dependencies
    var base = require('base');
    var core = require('core');
    var ui = require('ui');
    require('angular-ui-router');
    // Internal Dependencies
    var Model = require('./model');
    var MainCtrl = require('./controllers/main-ctrl');
    var HeaderCtrl = require('./controllers/header-ctrl');
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
        .controller('HeaderCtrl', HeaderCtrl )
        .factory( 'model', Model )
        .factory( 'commonService', commonService )
        .run( ['$rootScope','$state','$stateParams',run] );
});
