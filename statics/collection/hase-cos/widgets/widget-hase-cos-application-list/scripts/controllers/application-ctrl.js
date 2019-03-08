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
    function ApplicationCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,$stateParams,$http,$timeout,commonService,$compile) {
       this.state = model.getState();
        this.utils = lpCoreUtils;
        this.$stateParams = $stateParams;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
        this.$http = $http;
        this.$timeout = $timeout;
 		this.commonService = commonService;
        this.$compile = $compile;
    }

    ApplicationCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.rid = this.$stateParams.role_id;
        this.$scope.rname = this.$stateParams.role_name;
        console.log(this.$scope.rid);
        this.$scope.applicationNumber = '';
        this.$scope.customerId = '';
        this.$scope.customerName = '';
        this.$scope.appTable = [];
        this.$scope.statusList = [];
        this.$scope.businessCenterList = [];
        this.$scope.staffAssignedList = [];      
        this.titleTable(); //获取头部信息
        this.initSummary();
    };

    /**
     * Zach Y Gao
     * 05-03-2019
     * @param status
     * ** filter applications list data by state ** view button
     */
    ApplicationCtrl.prototype.statusApplicationListButton = function(status){
    	var statusKey = "status";
    	var statusValue = status;
    	if(statusValue != "" && statusValue != undefined){
        	  console.log(statusValue);
        $('#table').bootstrapTable('filterBy', {statusKey: statusValue});
      }
    };

    ApplicationCtrl.prototype.caseSearchButton = function(){
    	var applicationCtrl = this;
//  	applicationCtrl.searchInputVal = [];
    	var seachFilterParams = {
    	"id":applicationCtrl.seachByid,
    	"customerId": applicationCtrl.seachBycustomerId,
    	"companyName": applicationCtrl.seachBycompanyName,
    	"status": applicationCtrl.seachBystatus,
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
            onLoadSuccess:function(){applicationCtrl.initSearch();}
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
    //初始化加载searchBy的elemenet name
		ApplicationCtrl.prototype.initSearch = function(){
			console.log("----start---"+new Date().getTime());
			var applicationCtrl = this;
			var searchElements = applicationCtrl.widget.getPreference("Search_RSO").split(",");
			var dataList = $("#table").bootstrapTable("getData");
			var searchResult = {};
			var optionElements = [];
			var inputElements = [];
			for(var i =0;i<searchElements.length;i++){
				searchResult[searchElements[i]] = {data:[],type:""};
				if(searchElements[i]==="status"||searchElements[i]==="businessCenter"||searchElements[i]==="staffList"){
					searchResult[searchElements[i]] ["type"]="select";
				}else{
					searchResult[searchElements[i]] ["type"]="input";
				}
			}
			
			for (var i =0;i<searchElements.length;i++) {
				var searchKey = searchElements[i];
				
				for(var j=0;j<dataList.length;j++)
				{
					if(searchResult[searchKey]["data"].indexOf(dataList[j][searchKey])<0&&dataList[j][searchKey])
					{
						searchResult[searchKey]["data"].push(dataList[j][searchKey])
					}
				}
			}

			
			applicationCtrl.optionElements = optionElements; 
			applicationCtrl.inputElements = inputElements; 
			applicationCtrl.searchResult = searchResult;
			console.log("----end---"+new Date().getTime());
		};
		
		
		ApplicationCtrl.prototype.initSummary = function(){
			var applicationCtrl = this;
			var data = {
					roleId: applicationCtrl.$scope.rid,	
					url: "/applicationCountNum"
				};
			applicationCtrl.commonService.getCommonServiceMessage(data).then(
            function(response){
            	debugger;
				applicationCtrl.$scope.summaryStatusList = response.data;
            },function(){
				
            }
        )
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

    // ApplicationCtrl.prototype.jumpHtml = function(value){
    //     var applicationCtrl = this;
    //     console.log(applicationCtrl.selectedRow)
    //     applicationCtrl.$rootScope.$state.go('C2');
    // }

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
 
                        var html = '<a href="#C2/'+applicationCtrl.$scope.rname+'/'+row.Application_ID+'/'+row.Appointment_Date_Time+'/'+row.Handling_Call_Agent+'">'+ value +'</a>';
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
