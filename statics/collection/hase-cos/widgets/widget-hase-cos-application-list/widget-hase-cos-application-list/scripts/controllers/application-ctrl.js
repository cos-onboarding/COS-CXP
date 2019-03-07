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
            "status":'1111',"statusCount":2
        },{"status":'2222',"statusCount":433}];
        this.titleTable(); //获取头部信息
        this.loadingList(); // 自动加载方法
    };
    ApplicationCtrl.prototype.click = function() {
        // Do initialization here
        this.$rootScope.$state.go('C2');
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
    		var filterValue = seachFilterParams[i];
    		if (filterValue === '' || filterValue === null || filterValue === undefined) {
      			  delete seachFilterParams[i];
     	 } else {
      			
      }
    }
    	 console.log(seachFilterParams);
    	 $('#table').bootstrapTable('filterBy', seachFilterParams);
}
/*        var params = {
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

        this.$scope.fileStatusData = '';*/
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
        }).on('click-cell.bs.table', function (e, field, value, row, $element) {
            console.log(row);
            $('[data-toggle="popover"]').popover({ 
                trigger:'click',
                title:"Remark Details",
                html: true,
                content: remarkDetails(row),
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

     // 动态remarkDetails
    function remarkDetails(row){
        return "<br> Customer ID"+row.id+" <br> 28882888 <br>"
    }

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
                var html = '<a href="applications_change_log.html">'+ value +'</a>';
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
                html += '<img class="btn ml-1" height="40px" src="img/search.svg" data-toggle="popover" aria-hidden="true">';
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
