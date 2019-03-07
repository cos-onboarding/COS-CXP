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
    function ApplicationCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,$stateParams,$http,$timeout) {
        this.state = model.getState();
        this.utils = lpCoreUtils;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
        this.$stateParams = $stateParams;
        this.$http = $http;
        this.$timeout = $timeout;
    }

    ApplicationCtrl.prototype.$onInit = function() {
        // Do initialization here
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
        this.loadingList(); // 自动加载方法
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
            url: '/portalserver/static/widgets/%5BBBHOST%5D/widget-hase-cos-application-list/scripts/controllers/application_list.json',
            pagination: true, //开启分页
            pageNumber: 1, //初始化加载第一页，默认第一页
            pageSize: 5, // 单页记录数
            pageList: [5, 10, 25, 50],
            paginationHAlign: "right",
            paginationDetailHAlign: "left",
            // queryParams: queryParams, // 后台传参数的数据
            minimumCountColumns: 2,
            columns: applicationCtrl.$scope.appTable // table头部信息 
        }).on('click-row.bs.table', function (row, $element) {
            console.log($element.id);
            var id = $element.id;
            $('[data-toggle="popover"]').popover({ 
                trigger:'click',
                title:"Remark Details",
                html: true,
                content: remarkDetails(id),
            });
            // close popover when click on the area outside of popover
            $('body').on('hidden.bs.popover', function () {
                $('body').popover('destroy');
            })
            // $('body').on('click', function(event) {
            //     // var id = $("#id");
            //     var target = $(event.target);
            //     if (!target.hasClass('popover') 
            //             && target.parent('.popover-content').length === 0
            //             && target.parent('.popover-title').length === 0
            //             && target.parent('.popover').length === 0
            //             && target.data("toggle") !== "popover") {
            //         $('[data-toggle="popover"]').popover('destroy');
            //     }
            // }); 
        });
        // $('#mytab').bootstrapTable('refresh')
    };

    //请求后台参数
    function queryParams(params){
        params.rid = this.$stateParams.id;
        return params;
    }

    //  // 动态remarkDetails
    function remarkDetails(id){
        // console.log(row)
        return "<br> Customer ID"+id+" <br> 28882888 <br>"
    }

    // ApplicationCtrl.prototype.jumpHtml = function(value){
    //     debugger;
    //     this.$rootScope.$state.go('C2',{id:value});
    // }

    //自动加载Table头部信息
    ApplicationCtrl.prototype.titleTable = function(){
        console.log("123:" + this.$scope.appTable)
        var applicationCtrl = this
        console.log("456:" + applicationCtrl.$scope.appTable)
        applicationCtrl.$scope.appTable = [{
            field: 'id',
            title: 'ID',
            sortable:true,
            align: 'center',
            formatter:function(value, row, index){
                // window.sessionStorage.setItem("IDs",value);
                // console.log(value)
                // var html = '<a ng-click="applicationCtrl.jumpHtml('+value+')">'+ value +'</a>';
                var html = '<a href="#C2/'+value+'">'+ value +'</a>';
                return html;
            }
        },{
            field: 'type',
            title: 'Type',
            sortable:true,
            align: 'center',
        }, {
            field: 'entityType',
            title: 'Entity Type',
            sortable:true,
            align: 'center',
        }, {
            field: 'companyName',
            title: 'Company Name',
            sortable:true,
            align: 'center',
        }, {
            field: 'customerId',
            title: 'Customer ID',
            sortable:true,
            align: 'center',
        }, {
            field: 'category',
            title: 'Category',
            align: 'center',
        }, {
            field: 'status',
            title: 'Status',
            align: 'center',
        },{
            field: 'remark',
            title: 'Remark',
            align: 'center',
            formatter:function(value, row, index){
                var html = '';
                html += '<img class="btn ml-1" height="40px" src="/portalserver/static/features/%5BBBHOST%5D/theme-hase-cos/dist/styles/images/search.svg" data-toggle="popover" aria-hidden="true">';
                return html;
            }
        }, {
            field: 'appointmentDate',
            title: 'Appointment Date & Time',
            sortable:true,
            align: 'center',
        }, {
            field: 'confirmedVenue',
            title: 'Confirmed Venue',
            align: 'center',
        }, {
            field: 'handlingCallAgent',
            title: 'Handling Call Agent',
            align: 'center',
        },  {
            field: 'taskDueDate',
            title: 'Handling Call Agent',
            align: 'center',
        }, {
            field: 'documentLastUploadDate',
            title: 'Document Last Upload Date',
            align: 'center',
        }, {
            field: 'lastModifiedDate',
            title: 'Last Modified Date',
            align: 'center',
        },]
    };
    module.exports = ApplicationCtrl;
});
