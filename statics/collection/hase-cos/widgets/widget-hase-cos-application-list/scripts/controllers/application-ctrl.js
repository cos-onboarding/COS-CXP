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
    function ApplicationCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,$http,$timeout,$stateParams,$compile) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.$stateParams = $stateParams;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
        this.$http = $http;
        this.$timeout = $timeout;
        this.$compile = $compile;
    }

    ApplicationCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.rid = this.$stateParams.id;
        console.log(this.$scope.rid);
        this.$scope.applicationNumber = '';
        this.$scope.customerId = '';
        this.$scope.customerName = '';
        this.$scope.appTable = [];
        this.$scope.statusList = [];
        this.$scope.businessCenterList = [];
        this.$scope.staffAssignedList = [];
        this.$scope.summaryStatusList = [{
            "status":'All My Cases,OBS Maintenance',"statusCount":2
        },{"status":'Under Review by BA',"statusCount":433},
        {"status":'Case Assign by BA',"statusCount":433},
        
        {"status":'Under Lvl 2 Approval by BA Lead',"statusCount":433},
        {"status":'Under Review by SD',"statusCount":433},
        {"status":'Follow Up by Received from BBO - SD',"statusCount":433},
        {"status":'Case returned by BA',"statusCount":433}
        ,{"status":'Preprocessing',"statusCount":433}
        ,{"status":'Pending Client Meeting',"statusCount":433}
        ,{"status":'BBO Processing',"statusCount":433}
        ,{"status":'BA Follow Up by BBO - BA',"statusCount":433}
        ,{"status":'Follow Up by BBO - Pre-submission',"statusCount":433}
        ,{"status":'Follow Up by BBO - Pre-submission',"statusCount":433}
        ,{"status":'OBS Maintenance Follow Up by BBO',"statusCount":433}
        ,{"status":'Pending RSO Allocation',"statusCount":433}
        ,{"status":'Pending for Handling,Pending Customer Submission',"statusCount":433}
        ,{"status":'Pending CCC Allocation',"statusCount":433}
        ,{"status":'Pending - Missing Documents from Customer (CCC)',"statusCount":433}
        ,{"status":'Pending - Missing Documents from Customer',"statusCount":433}
        ,{"status":'Rejected,Canceled',"statusCount":433}
        ,{"status":'Account Opened',"statusCount":433}];
        this.titleTable(); //获取头部信息
        
    };

    /**
     * Zach Y Gao
     * 05-03-2019
     * @param status
     * ** filter applications list data by state ** view button
     */
    ApplicationCtrl.prototype.statusApplicationListButton = function(status){
    	if(status != "" && status != undefined){
        	  console.log(status);
        $('#table').bootstrapTable('filterBy', {status: status});
      }
    };

    ApplicationCtrl.prototype.caseSearchButton = function(){
    	var seachFilterParams = {
    	"id":this.$scope.applicationNumber,
    	"customerId": this.$scope.customerId,
    	"companyName": this.$scope.customerName,
    	"status": this.$scope.statusName,
    	"businessName": "",
    	"staffName": ""
    	}
    	 for (var filterValue in seachFilterParams) {
    		var value = seachFilterParams[filterValue];
    		if (value === '' || value === null || value === undefined) {
      			  delete seachFilterParams[filterValue];
     	 } else {
      			
      }
    }
    	 console.log(seachFilterParams);
//  	 $('#table').bootstrapTable('insertRow$', 0,$('#table').bootstrapTable('filterBy', {id:"28882883"}));
    	 $('#table').bootstrapTable('filterBy', seachFilterParams);
//  	 $('#table').bootstrapTable('getData', useCurrentPage = true);   $('#table').bootstrapTable('insertRow$', 1,$('#table').bootstrapTable('filterBy', {customerId:"3777388221"}));
    	 

        var params = {
            "applicationNumber": this.$scope.applicationNumber,
            "customerId": this.$scope.customerId,
            "customerName": this.$scope.customerName,
            "status": this.$scope.statusName,
            "businessCenter": this.$scope.businessName,
            "staffAssigned": this.$scope.staffName
        }
        $http.post("http://,", $scope.formData)
                    .success(function(result){
                     })
                    .error(function(result){
                     });

        this.$scope.fileStatusData = '';
    };

        //自动加载
        ApplicationCtrl.prototype.loadingList = function(){
        var applicationCtrl = this;
            //table with json data
        $('#table').bootstrapTable({
            url: 'http://localhost:7777/portalserver/services/rest/inboxAppList',
            method: 'POST',
            pagination: true, //开启分页
            pageNumber: 1, //初始化加载第一页，默认第一页
            pageSize: 5, // 单页记录数
            pageList: [5, 10, 25, 50],
            paginationHAlign: "right",
            paginationDetailHAlign: "left",
            showColumns: false,
            queryParams: queryParams(applicationCtrl), // 后台传参数的数据
            minimumCountColumns: 2,
            columns: applicationCtrl.$scope.appTable, // table头部信息 
            onPostBody:function(){debugger;applicationCtrl.$compile($('#table'))(applicationCtrl.$scope)},
            onResetView:function(){debugger;applicationCtrl.$compile($('#table'))(applicationCtrl.$scope)}
        }).on('click-row.bs.table', function (row, $element) {
            console.log($element.id);
            var id = $element.id;
            $('[data-toggle="popover"]').popover({ 
                trigger:'click',
                title:"Remark Details",
                html: true,
                content: remarkDetails(id),
            });
            
            $('body').on('hidden.bs.popover', function () {
                $('body').popover('destroy');
            })
        });
    };

    // //请求后台参数
    function queryParams(applicationCtrl){
        var param = {
            roleId: applicationCtrl.$scope.rid,
        };
        return param;
    }

    //  // 动态remarkDetails
    function remarkDetails(id){
        // console.log(row)
        return "<br> Customer ID"+id+" <br> 28882888 <br>"
    }

    ApplicationCtrl.prototype.jumpHtml = function(value){
        var applicationCtrl = this;
        console.log(applicationCtrl.selectedRow)
        applicationCtrl.$rootScope.$state.go('C2');
    }

    //自动加载Table头部信息
    ApplicationCtrl.prototype.titleTable = function(){
        var applicationCtrl = this;
        var param = {roleId:applicationCtrl.$scope.rid}
        applicationCtrl.$http.post("http://localhost:7777/portalserver/services/rest/inboxAppTable", param)
            .then(function (response) {
                var appHtml = {
                    field: 'Application_ID',
                    title: 'Application ID',
                    align: "center",
                    formatter:function(value, row, index){
                        applicationCtrl.selectedRow = row;
                        var html = '<a href="" ng-click="alert(123)">'+ value +'</a>';
                        return html;
                    }
                }
                for (let index = 0; index < response.data.length; index++) {
                    if(response.data[index].field == "Application_ID"){
                        response.data[index] = appHtml;
                    }
                }
                applicationCtrl.$scope.appTable = response.data;
                console.log(applicationCtrl.$scope.appTable);
                applicationCtrl.loadingList(); // 自动加载方法
            }).catch(function(){

            });
    };


    module.exports = ApplicationCtrl;
});
