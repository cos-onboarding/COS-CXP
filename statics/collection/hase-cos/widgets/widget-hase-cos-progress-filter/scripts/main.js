/**
 *  ----------------------------------------------------------------
 *  Copyright © Backbase B.V.
 *  ----------------------------------------------------------------
 *  Filename : main.js
 *  Description: Widget for progress filter
 *  ----------------------------------------------------------------
 */

define( function (require, exports, module) {

    'use strict';

    module.name = 'widget-hase-cos-wlc';

    // External Dependencies
    var base = require('base');
    var core = require('core');
    var ui = require('ui');
    require('angular-ui-router');
    require('bootstrap');
    require('bootstrap-table');
    require('angular-moment-picker');
    require('popper');
     require('moment');
    // Internal Dependencies
    var Model = require('./model');
    var MainCtrl = require('./controllers/main-ctrl');
    var ProgressFilterCtrl = require('./controllers/progressFilterCtrl');
    var commonService  = require("./service/common-service");

    var deps = [
        core.name,
        ui.name,
        'ui.router',
        'moment-picker',
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
        .controller('ProgressFilterCtrl', ProgressFilterCtrl)
        .factory('commonService',commonService)
        .factory( 'model', Model )
        .run( run );
});
