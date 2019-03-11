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
        this.$scope.rname = this.$stateParams.role_name.replace(" ","_");;
        console.log(this.$scope.rid);
        this.$scope.applicationNumber = '';
        this.$scope.customerId = '';
        this.$scope.customerName = '';
        this.$scope.appTable = [];
        this.$scope.statusList = [];
        this.$scope.businessCenterList = [];
        this.$scope.staffAssignedList = [];      
        this.$scope.checkboxList = []; // 选中信息
        this.$scope.staffId = ""; // 员工ID
        this.$scope.staffList = []; // 员工
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
//      applicationCtrl.searchInputVal = [];
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
//       $('#table').bootstrapTable('insertRow$', 0,$('#table').bootstrapTable('filterBy', {id:"28882883"}));
         $('#table').bootstrapTable('filterBy', seachFilterParams);
//       $('#table').bootstrapTable('getData', useCurrentPage = true);   $('#table').bootstrapTable('insertRow$', 1,$('#table').bootstrapTable('filterBy', {customerId:"3777388221"}));
         
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
            onLoadSuccess:function(data){applicationCtrl.initSearch(data);},
        }).on('click-row.bs.table', function (row, $element) {
            
            $('[data-toggle="popover"]').popover({ 
                trigger:'click',
                title:"Quick View",
                html: true,
                content: remarkDetails($element,applicationCtrl),
            });
            $('body').on('click', function(event) {
                var target = $(event.target);
                if (!target.hasClass('popover') 
                        && target.parent('.popover-content').length === 0
                        && target.parent('.popover-title').length === 0
                        && target.parent('.popover').length === 0
                        && target.data("toggle") !== "popover") {
                    $('[data-toggle="popover"]').popover('hide');
                    $('body').popover('destroy');
                    $("#table").bootstrapTable('refresh');
                }
            }); 
            // $('body').on('hidden.bs.popover', function () {
            //     $('body').popover('destroy');
            // })
        }).on('check.bs.table', function (row, $element) { //单选
            var checkBoxData= $("#table").bootstrapTable('getSelections');
            applicationCtrl.$scope.checkboxList = checkBoxData;
        }).on('check-all.bs.table', function (rows) { // 全选
            var checkBoxData= $("#table").bootstrapTable('getSelections');
            applicationCtrl.$socpe.checkboxList = checkBoxData;
        }).on('uncheck-all.bs.table', function (rows) { // 单行取消
            var checkBoxData= $("#table").bootstrapTable('getSelections');
            applicationCtrl.$socpe.checkboxList = checkBoxData;
        }).on('uncheck.bs.table', function (rows) { // 全取消
            var checkBoxData= $("#table").bootstrapTable('getSelections');
            applicationCtrl.$socpe.checkboxList = checkBoxData;
        });
    };
    //初始化加载searchBy的elemenet name
        ApplicationCtrl.prototype.initSearch = function(dataList){
            console.log("----start---"+new Date().getTime());
            var applicationCtrl = this;
            var searchElements = applicationCtrl.widget.getPreference("Search_"+applicationCtrl.$scope.rname).split(",");
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

    // 动态remarkDetails
    function remarkDetails($element,applicationCtrl){
        var element = []; // 封装数据
        var searchElements = applicationCtrl.widget.getPreference("Application_List."+applicationCtrl.$scope.rname).split(",");
        var contactPerson = $element.Contact_Person;
        var contactNumber = $element.Contact_Number;
        var referralSource = "";
        if($element.Referral_Source != undefined){ // Referral_Source参数判断是那个角色拥有，才进行赋值
            referralSource = $element.Referral_Source;
            element.push(referralSource);
        }
        // 重组数据
        element.push(contactPerson);
        element.push(contactNumber);

        searchElements.splice(0,1); // 清除XML中第一个参数。那个参数是角色。
        var html = "";
        for(var i = 0; i < searchElements.length; i++ ){
            for (var j = i; j < element.length; j++) {
                html += "<br>" + searchElements[i] + ":" + element[j];
                break;
            }
        }
        return html;
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
                        var html = '<a href="#C2/'+applicationCtrl.$scope.rname+'/'+row.Application_ID+'/'+row.Appointment_Date_Time+'/'+row.Handling_Call_Agent+'/'+applicationCtrl.$scope.rid+'/'+row.Status+'">'+ value +'</a>';
                        return html;
                    }
                };

                var quickViewHtml = {
                    field: 'Quick_View',
                    title: 'Quick View',
                    align: 'center',
                    formatter:function(value, row, index){
                        var html = '<img class="btn ml-1" height="40px" src="img/search.svg" data-toggle="popover" aria-hidden="true">';
                        return html;
                    }
                };
                if(applicationCtrl.$scope.rname == "CCC_TH"){
                    var checkboxHtml = {
                        checkbox:true,
                    };
                    response.data.splice(0,0,checkboxHtml);
                }
                for (let index = 0; index < response.data.length; index++) {
                    if(response.data[index].field == "Application_ID"){
                        response.data[index] = appHtml;
                    }
                }
                var searchElements = applicationCtrl.widget.getPreference("Application_List."+applicationCtrl.$scope.rname);
                if(searchElements != undefined){
                    var search = searchElements.split(",");
                    if(search[0] == "CCC_Agent" || search[0] == "RSO" || search[0] == "BBO" || search[0] == "BBC_CM_TH"){
                        response.data.splice(2,0,quickViewHtml);
                    }
                }

                
                applicationCtrl.$scope.appTable = response.data;
                console.log(applicationCtrl.$scope.appTable);
                applicationCtrl.loadingList(); // 自动加载方法
            }).catch(function(){

            });
    };

    // 获取分配员工的值
    ApplicationCtrl.prototype.getStaff = function(){
        var applicationCtrl = this;
        var param = {role_name:applicationCtrl.$scope.rname.replace("_"," ")};
        applicationCtrl.$http.post("http://localhost:7777/portalserver/services/rest/getInboxStaff", param)
            .then(function (response) {
                console.log(response)
                applicationCtrl.$scope.staffList  = response.data;
            }).catch(function(){});

    };

    //给员工分配
    ApplicationCtrl.prototype.saveAssign = function(){
        var applicationCtrl = this;
        var param = {
            staffId:applicationCtrl.$scope.staffId, // 分配人ID
            inboxAppList:applicationCtrl.$scope.checkboxList // 数据集合
        }
        console.log(param);
        applicationCtrl.$http.post("http://localhost:7777/portalserver/services/rest/saveInboxStaff", param)
            .then(function (response) {
                $("#AssignModal").modal('hide')
                $("#table").bootstrapTable('refresh');
                applicationCtrl.$scope.checkboxList = [];
            }).catch(function(){});
    }

    // 关闭模态框
    ApplicationCtrl.prototype.emptyAssign = function(){
        var applicationCtrl = this;
        $("#AssignModal").modal('hide')
        $("#table").bootstrapTable('refresh');
        applicationCtrl.$scope.checkboxList = [];
    }

    module.exports = ApplicationCtrl;
});
