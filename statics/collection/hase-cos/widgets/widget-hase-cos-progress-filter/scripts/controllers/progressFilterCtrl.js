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

    function ProgressFilterCtrl(model, lpWidget, lpCoreUtils,$rootScope,$scope,$stateParams,$http,$timeout,commonService,$compile) {
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
    
    ProgressFilterCtrl.prototype.$onInit = function() {
        // Do initialization here
        this.$scope.searchParam = {};
        this.$scope.searchParam.progress = "inProgress";
		this.$scope.appTable = [];
		this.$scope.searchElements = [];
        this.getRoleName();
//      this.initSearchElement();
    };

		ProgressFilterCtrl.prototype.getRoleName = function(){
			var progressFilterCtrl = this;
			var param = {};
			progressFilterCtrl.$http.post(progressFilterCtrl.serviceUrl+"/progressGetSession", param)
            .then(function (response) {
            	var roleJson = JSON.parse(response.data[response.data.length-1]);
            	progressFilterCtrl.$scope.muleRname = roleJson.roleName;
            	response.data.splice(response.data.length-1,1);
                progressFilterCtrl.$scope.appTable = response.data;
                console.log(progressFilterCtrl.$scope.appTable);
                console.log(response.sessionData);
                console.log(response.data);
		        progressFilterCtrl.$scope.progressCount = 0; 
                progressFilterCtrl.$scope.rname = roleJson.roleName.replace(" ","_").replace("/","_");
		        progressFilterCtrl.$scope.searchElements = JSON.parse(progressFilterCtrl.widget.getPreference(progressFilterCtrl.$scope.rname+".FilterElement"));
		        progressFilterCtrl.elementShow();
				progressFilterCtrl.titleTable();//获取头部信息
            }).catch(function(){

            });
    }	
	
		/**
		 * search button function
		 */
		ProgressFilterCtrl.prototype.initSearchElement = function(){
			var progressFilterCtrl = this;
		}
	
		ProgressFilterCtrl.prototype.progessCheck = function(element){
			var progressFilterCtrl = this;
			progressFilterCtrl.elementShow();
			$('#table').bootstrapTable('destroy');
			progressFilterCtrl.titleTable();
		}
		
		ProgressFilterCtrl.prototype.elementShow = function(){
			var progressFilterCtrl = this;
			var roleJson = JSON.parse(progressFilterCtrl.widget.getPreference("Role.InProgressFilter"));
			var rname = progressFilterCtrl.$scope.rname;
			switch(rname){
			    case roleJson.bbc :
			    	progressFilterCtrl.completedDate = progressFilterCtrl.$scope.progressCount % 2 == 1 ? false : true;
			    	
			        break;
			    case roleJson.ccc :
			    	progressFilterCtrl.appointmentDate = progressFilterCtrl.$scope.progressCount % 2 == 1 ? false : true;
			    	progressFilterCtrl.customerDate = progressFilterCtrl.$scope.progressCount % 2 == 1 ? true : false;
			        break;
			    case  roleJson.ba :
			  	    progressFilterCtrl.completedDate = progressFilterCtrl.$scope.progressCount % 2 == 1 ? false : true;
			  	    progressFilterCtrl.approvalDate = progressFilterCtrl.$scope.progressCount % 2 == 1 ? false : true;
			        break;
			}    
		}
		
		ProgressFilterCtrl.prototype.tableSearch = function(){
			var progressFilterCtrl = this;
			var searchElementList =  progressFilterCtrl.$scope.searchElements;
			var progressFilterDictionaries = JSON.parse(progressFilterCtrl.widget.getPreference("ProgressFilter.Dictionaries"));
			var searchElementModel = [];
			var params = {};
			for(var key in searchElementList){
				var len= searchElementList[key].data.length;
				for(var i=len-1; i>=0;i--){
					if(searchElementList[key].data[i]!="inProgress" && searchElementList[key].data[i]!="completed"){
					searchElementModel.push(searchElementList[key].data[i]);
					}
				}
			}
			var value;
			for(var j=0; j<searchElementModel.length;j++){
					if(progressFilterCtrl.$scope.searchParam[searchElementModel[j]]===undefined){
						params[searchElementModel[j]] = '';
						value = 0;
					}else{
						value = progressFilterCtrl.$scope.searchParam[searchElementModel[j]];
					}
				if(value != '' && value != null && value != undefined){
					params[searchElementModel[j]] = progressFilterCtrl.$scope.searchParam[searchElementModel[j]];
					if(params[searchElementModel[j]]._d != undefined && params[searchElementModel[j]]._d != ''){
						params[searchElementModel[j]] = new Date(params[searchElementModel[j]]._d).toISOString().slice(0, 10) + " 00:00:00";
					}
				}
			}
//			params["progress"] = progressFilterCtrl.searchParam["progress"] == "inProgress" ? "In Progress" : "Completed";
			for(var key in  params){
				for(var searchValue in progressFilterDictionaries){
					if(params[searchValue] === undefined){
						params[searchValue] = "";
					}
					if(key== searchValue && key.indexOf("To") == -1 && key.indexOf("From") == -1){
						params[key] = progressFilterDictionaries[searchValue];
					}
				}
			}
			
//			progressFilterCtrl.$scope.rname   progressFilterCtrl.$scope.rid  progressFilterCtrl.$scope.progressCount % 2 == 1 ? "ICompleted" : "In Progress"
			params["progress"] = progressFilterCtrl.$scope.progressCount % 2 == 1 ? "In Progress" : "Completed";
			params["roleName"] = progressFilterCtrl.$scope.muleRname;
			params.rpType = "";
			params.nonType = "";
			console.log(params);
			if(params.progress == "In Progress"){
				params.approvalFrom = "";
				params.approvalTo = "";
				params.completedFrom = "";
				params.completedTo = "";
			}
			if(params.appointmentFrom<=params.appointmentTo && params.approvalFrom <= params.approvalTo && params.baFrom<=params.baTo &&params.completedFrom<=params.completedTo&&params.customerFrom<=params.customerTo){
			params["url"] = "/progressFilter";
			console.log(progressFilterCtrl.$scope.progressCount);
			progressFilterCtrl.commonService.getCommonServiceMessage(params).then(
				 function(response){
				                $("#table").bootstrapTable('load', response.data);
				                console.log(response.data);
				            },function(){
				        }           
				   )
			}else{
				alert('----------- date error--------');
			}
		}

        //自动加载
        ProgressFilterCtrl.prototype.loadingList = function(){
            var progressFilterCtrl = this;
                //table with json data
            $('#table').bootstrapTable({
//          	progressFilterCtrl.serviceUrl+'/inboxAppList',
                url: progressFilterCtrl.serviceUrl+'/progressFilter',
                method: 'POST',
                pagination: true, //开启分页
                pageNumber: 1, //初始化加载第一页，默认第一页
                pageSize: 1, // 单页记录数
                pageList: [5, 10, 25, 50],
                paginationHAlign: "right",
                paginationDetailHAlign: "left",
                showColumns: false,
                queryParams: queryParams(progressFilterCtrl), // 后台传参数的数据
                minimumCountColumns: 2,
                columns: progressFilterCtrl.$scope.appTable, // table头部信息 
                onLoadSuccess:function(data){ // 调用Popover
				progressFilterCtrl.initRadio();
				if(progressFilterCtrl.$scope.progressCount > 1){
					$("#table").bootstrapTable('load', data);
				}
				progressFilterCtrl.$scope.progressCount++;
				console.log(data);
				console.log("data :"+progressFilterCtrl.$scope.progressCount);
				}
            });
        }    
//$("#ckbx").prop("checked",true);  progressFilterCtrl.$compile($("#inProgress").attr("checked",true))(progressFilterCtrl.$scope);
		ProgressFilterCtrl.prototype.initRadio = function(){
			 var progressFilterCtrl = this;
			 console.log(progressFilterCtrl.$scope.searchParam);
		}

    // //请求后台参数
    function queryParams(progressFilterCtrl){
           	var data = {
            "roleName": progressFilterCtrl.$scope.muleRname,
            "progress": progressFilterCtrl.$scope.progressCount % 2 == 0 ? "In Progress" : "Completed",
			"approvalFrom":"",
			"approvalTo":"",
			"baFrom":"",
			"baTo": "",
			"appTypeNTB":"NTB",
			"appTypeETB":"ETB",
			"appointmentFrom":"",
			"appointmentTo":"",
			"completedFrom":"",
			"completedTo":"",
			"rpType":"",
			"nonType":"",
			"customerFrom":"",
			"customerTo": "",
			"url": "/progressFilter"
		};
		console.log("data :" + progressFilterCtrl.$scope.progressCount);
		var param = JSON.stringify(data);
        return param;
    }

    //自动加载Table头部信息
    ProgressFilterCtrl.prototype.titleTable = function(){
        var progressFilterCtrl = this;
//      progressFilterCtrl.$scope.rid progressFilterCtrl.searchParam.progess == undefined ? "In Progress" : "Compleat"
        var param = {
        	roleName:progressFilterCtrl.$scope.muleRname,
        	progress: progressFilterCtrl.$scope.progressCount % 2 == 0 ? "In Progress" : "Completed"
        }
        console.log("title :"+progressFilterCtrl.$scope.progressCount);
        console.log("title :"+progressFilterCtrl.$scope.progressCount);
        progressFilterCtrl.$http.post(progressFilterCtrl.serviceUrl+"/progressFields", param)
            .then(function (response) {
//          	var roleJson = JSON.parse(response.data[response.data.length-1]);
//          	progressFilterCtrl.$scope.rname = roleJson.roleName.replace(" ","_");
//          	response.data.splice(response.data.length-1,1);
                progressFilterCtrl.$scope.appTable = response.data;
                console.log(progressFilterCtrl.$scope.appTable);
//              console.log(response.sessionData);
//              console.log(response.data);
                progressFilterCtrl.loadingList(); // 自动加载方法
            }).catch(function(){

            });
    };
    
    module.exports = ProgressFilterCtrl;
});
