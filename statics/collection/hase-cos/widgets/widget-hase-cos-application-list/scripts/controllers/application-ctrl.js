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


    function ApplicationCtrl(model, lpWidget,lpCoreUtils,$rootScope,$scope,$stateParams,$http,$timeout,commonService,$compile) {
        this.state = model.getState();
        this.model = model;
        this.utils = lpCoreUtils;
        this.$stateParams = $stateParams;
        this.widget = lpWidget;
        this.$rootScope = $rootScope;
        this.$scope = $scope;
        this.$http = $http;
        this.$timeout = $timeout;
        this.commonService = commonService;
        this.$compile = $compile;
        this.serviceUrl = lpWidget.getPreference("serviceUrl");
    }

    ApplicationCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.rid = this.$stateParams.role_id;
        this.$scope.rname = this.$stateParams.role_name.replace(" ","_");
        this.$scope.staff_id = this.$stateParams.staffId;
        this.$scope.page = this.$stateParams.page;
        this.$scope.pageSize = this.$stateParams.pageSize;

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
        this.$scope.element = []; // 封装por弹框数据
        this.$scope.searchElements = []; // 获取XML角色KEY
        this.titleTable(); //获取头部信息
        this.initSummary();
        this.preRender();
        this.topModel();

    };

    ApplicationCtrl.prototype.preRender = function() {
        var applicationCtrl = this;
        if(!applicationCtrl.model.searchModel)
        {
            return;
        }
        applicationCtrl.$scope.searchParamTemplate = applicationCtrl.model.searchModel;
        applicationCtrl.caseSearchButton();
    }


    /**
     * 
     *  filter applications list data by state ** view button
     */
    ApplicationCtrl.prototype.statusApplicationListButton = function(status){
    	var statusValue = status;
    	if(statusValue != "" && statusValue != undefined){
        	  console.log(statusValue);
        $('#table').bootstrapTable('filterBy', {Status: statusValue});
      }
    };
	
	/**
	 *  Function triggered by the search button
	 */
    ApplicationCtrl.prototype.caseSearchButton = function(){
    	var applicationCtrl = this;
    	 for (var filterValue in applicationCtrl.$scope.searchParamTemplate) {
    		var value = applicationCtrl.$scope.searchParamTemplate[filterValue];
    		if (value === '' || value === null || value === undefined) {
      			  delete applicationCtrl.$scope.searchParamTemplate[filterValue];
     	 } else {
      			
      }
    }

         var param = {}; 
         for(var pro in applicationCtrl.$scope.searchParamTemplate)
         {
            param[pro.replace(" ","_")] = applicationCtrl.$scope.searchParamTemplate[pro];
         }
			for(var pmValue in param){
				if(param[pmValue].indexOf("All") != -1){
					delete param[pmValue];
				}
			}
    	 $('#table').bootstrapTable('filterBy', param);
    	 applicationCtrl.model.searchModel = applicationCtrl.$scope.searchParamTemplate;

    };

        //自动加载
        ApplicationCtrl.prototype.loadingList = function(){
            var applicationCtrl = this;
                //table with json data
            $('#table').bootstrapTable({
                url: applicationCtrl.serviceUrl+'/inboxAppList',
                method: 'POST',
                pagination: true, //开启分页
                pageNumber: applicationCtrl.$scope.page, //初始化加载第一页，默认第一页
                pageSize: applicationCtrl.$scope.pageSize, // 单页记录数
                pageList: [5, 10, 25, 50],
                paginationHAlign: "right",
                paginationDetailHAlign: "left",
                showColumns: false,
                queryParams: queryParams(applicationCtrl), // 后台传参数的数据
                minimumCountColumns: 2,
                columns: applicationCtrl.$scope.appTable, // table头部信息 
                onLoadSuccess:function(data){
                  applicationCtrl.applicationList = data;
                  applicationCtrl.initSearch(data);
                  applicationCtrl.$scope.$apply();
                },
                onPostBody:function(){ // 调用Popover
                    applicationCtrl.addPopoverListener();
                    applicationCtrl.addRemark();
                    applicationCtrl.onSkip();
                }
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
            }).on('page-change.bs.table',function(number, size){
                var pageSize = $("#table").bootstrapTable('getOptions').pageSize;
                applicationCtrl.$scope.pageSize = pageSize;
                applicationCtrl.$scope.page = size;
            })
        };

        ApplicationCtrl.prototype.addPopoverListener = function(){

            var quickViewItems = this.getQuickViewItems();

            $('[data-toggle="popover"]').popover({ 
                title:"Quick View",
                trigger: 'click',
                html: true,
                content: remarkDetails
            });

            function remarkDetails(){
                $('.popover.show').popover('hide');
                var html = "";
                for(var i = 0; i < quickViewItems.length; i++ ){
                    // 获取当前DOM属性值
                    html += "<br>" + quickViewItems[i] + ":" + this.getAttribute(quickViewItems[i]);

                }
                return html;
            }
            $('body').on('click', function(event) {
                var target = $(event.target);
                if (!target.hasClass('popover') 
                        && target.parent('.popover-content').length === 0
                        && target.parent('.popover-title').length === 0
                        && target.parent('.popover').length === 0
                        && target.data("toggle") !== "popover") {
                        $('.popover.show').popover('hide');
                }
            }); 
        }
    /**
     * Initialize the load search module
     * @param : dataList  Parameters from the table onLoadSuccess
     */
		ApplicationCtrl.prototype.initSearch = function(dataList){
			console.log("----start---"+new Date().getTime());
			var applicationCtrl = this;
			var newRname = this.$scope.rname.replace(/\s+/g,"_");
			var searchElements = applicationCtrl.widget.getPreference(newRname + ".Search").split(",");
			var searchResult = {};
            var searchParamTemplate = {};
			var optionElements = [];
			var inputElements = [];
				
			for(var i =0;i<searchElements.length;i++){
				searchResult[searchElements[i]] = {data:[],type:""};
                searchParamTemplate[searchElements[i]] = "";

				if(searchElements[i]==="Status"||searchElements[i]==="Business Center"||searchElements[i]==="BBO Assigned"){
					searchResult[searchElements[i]] ["type"]="select";
				}else{
					searchResult[searchElements[i]] ["type"]="input";
				}
			}
			
			for (var i =0;i<searchElements.length;i++) {
				var searchKey = searchElements[i];
				if(dataList!=undefined){
				for(var j=0;j<dataList.length;j++)
				{
					if(searchResult[searchKey]["data"].indexOf(dataList[j][searchKey])<0&&dataList[j][searchKey])
					{
						searchResult[searchKey]["data"].push(dataList[j][searchKey])
					}
				}
				}
			  }
						
			applicationCtrl.optionElements = optionElements; 
			applicationCtrl.inputElements = inputElements; 
			applicationCtrl.$scope.searchResult = searchResult;
            applicationCtrl.$scope.searchParamTemplate = searchParamTemplate;
			console.log("----end---"+new Date().getTime());
		};
		
		/**
		 * Initialize the summary module
		 */
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


    //自动加载Table头部信息
    ApplicationCtrl.prototype.titleTable = function(){
        var applicationCtrl = this;
        var param = {roleId:applicationCtrl.$scope.rid}
        applicationCtrl.$http.post(applicationCtrl.serviceUrl+"/inboxAppTable", param)
            .then(function (response) {
                var quickViewItems = applicationCtrl.getQuickViewItems();
                var appHtml = applicationCtrl.getAppHtml(applicationCtrl);
                var quickViewHtml = applicationCtrl.getQuickViewHtml(quickViewItems);
                var remarkHtml = applicationCtrl.getRemarkHtml();
                var checkboxRole = applicationCtrl.widget.getPreference("CheckboxRole").split(",");

                if(applicationCtrl.$scope.rname == checkboxRole){
                    var checkboxHtml = applicationCtrl.getCheckboxHtml();
                    response.data.splice(0,0,checkboxHtml);
                }

                for (let index = 0; index < response.data.length; index++) {
                    if(response.data[index].field == "Application_ID"){
                        response.data[index] = appHtml;
                    }
                    if(response.data[index].field == "Remark"){
                        response.data[index] = remarkHtml;
                    }
                }

                if(quickViewItems != undefined&&quickViewItems.length>0){
                    response.data.splice(2,0,quickViewHtml);
                }
                
                applicationCtrl.$scope.appTable = response.data;
                console.log(applicationCtrl.$scope.appTable);
                applicationCtrl.loadingList(); // 自动加载方法
            }).catch(function(){

            });
    };

    // XML中角色对应信息
    ApplicationCtrl.prototype.getQuickViewItems = function(){
        var applicationCtrl = this;
        var roleList = applicationCtrl.widget.getPreference("Role").split(",");
        var quickViewItems = [];
        for (let index = 0; index < roleList.length; index++) {
            if(applicationCtrl.$scope.rname == roleList[index]){
                quickViewItems = applicationCtrl.widget.getPreference("Application_List."+applicationCtrl.$scope.rname).split(",");
            }
        }
        return quickViewItems;
        
    }

    // 获取checkbox对象
    ApplicationCtrl.prototype.getCheckboxHtml = function(){
        var checkboxHtml = {
            checkbox:true,
        };
        return checkboxHtml;
    }

    // 获取APPID对象
    ApplicationCtrl.prototype.getAppHtml = function(applicationCtrl){
        var appHtml = {
            field: 'Application_ID',
            title: 'Application ID',
            align: "center",
            formatter:function(value, row, index){
                // var html = '<a href="#C2/'+applicationCtrl.$scope.rname+'/'+row.Application_ID+'/'+row.Appointment_Date_Time+'/'+row.Handling_Call_Agent+'/'+applicationCtrl.$scope.rid+'/'+row.Status+'">'+ value +'</a>';
                var html = '<a href="javascript:void(0)" name="applicationSkip" applicationId="'+row.Application_ID+'" dateTime="'+row.Appointment_Date_Time+'" remarkState="'+row.Remark+'" hca="'+row.Handling_Call_Agent+'" status="'+row.Status+'">'+ value +'</a>';

                return html;
            }
        };
        return appHtml;
    };

    //获取Remark对象
    ApplicationCtrl.prototype.getRemarkHtml = function(){
        var remarkHtml = {
            field: 'Remark',
            title: 'Remark',
            align: "center",
            formatter:function(value, row, index){
                console.log(value);
                var html = '<img';
                html=html + ' Application_ID = ' + '"'+row.Application_ID+'"';
                if(value != 0){
                    html = html + ' class="btn ml-1" data-toggle="modal" height="40px" name = "remarkModal" src="/portalserver/static/features/%5BBBHOST%5D/theme-hase-cos/dist/styles/images/file-alt-solid.svg">';
                }else{
                    html = html + ' class="btn ml-1" data-toggle="modal" height="40px" name = "remarkModal" src="/portalserver/static/features/%5BBBHOST%5D/theme-hase-cos/dist/styles/images/file-regular.svg">';
                }
                return html;
            }
        };
        return remarkHtml
    };

    // 点击调用REMARK
    ApplicationCtrl.prototype.addRemark= function(){
        var applicationCtrl = this;
        $("img[name='remarkModal']").click(function(){
            var application_id = this.getAttribute("application_id");
            applicationCtrl.$scope.$broadcast("getRemark", { applicationId: application_id,staffId: applicationCtrl.$scope.staff_id});
        });
    };

    // 点击Application跳转页面
    ApplicationCtrl.prototype.onSkip = function(){
        var applicationCtrl = this;
        $("a[name='applicationSkip']").click(function(){
            applicationCtrl.$rootScope.$state.go('C2',{
                role_name:applicationCtrl.$scope.rname,
                Application_ID:this.getAttribute("applicationid"),
                Appointment_Date_Time:this.getAttribute("datetime"),
                Handling_Call_Agent:this.getAttribute("hca"),
                role_id: applicationCtrl.$scope.rid,
                status:this.getAttribute("status"),
                remarkState:this.getAttribute("remarkstate"),
                staff_id:applicationCtrl.$scope.staff_id,
                pageSize:applicationCtrl.$scope.pageSize,
                page:applicationCtrl.$scope.page,
            });
        })

    }


    // 获取quickView对象
    ApplicationCtrl.prototype.getQuickViewHtml = function(quickViewItems){
        var quickViewHtml = {
            field: 'Quick_View',
            title: 'Quick View',
            align: 'center',
            formatter:function(value, row, index){       
                // 给HTML加DOM元素                 
                var html = '<img';
                for(var i=0;i<quickViewItems.length;i++)
                {
                   html=html+ ' '+quickViewItems[i] + '= "' + row[quickViewItems[i]] +'" ';
                }
                html = html + ' class="btn ml-1" height="40px" src="/portalserver/static/features/%5BBBHOST%5D/theme-hase-cos/dist/styles/images/search.svg" data-toggle="popover" aria-hidden="true">';
                return html;
            }
        };
        return quickViewHtml;
    }

    // 获取分配员工的值
    ApplicationCtrl.prototype.getStaff = function(){
        var applicationCtrl = this;
        var param = {role_name:applicationCtrl.$scope.rname.replace("_"," ")};
        applicationCtrl.$http.post(applicationCtrl.serviceUrl+"/getInboxStaff", param)
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
        applicationCtrl.$http.post(applicationCtrl.serviceUrl+"/saveInboxStaff", param)
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

    //向上传播
    ApplicationCtrl.prototype.topModel = function(){
        var applicationCtrl = this;
        applicationCtrl.$scope.$on('topEvent', function (event, args) {
            $('#table').bootstrapTable('refresh', {
                silent: true
            });
        })
    }

    module.exports = ApplicationCtrl;
});
