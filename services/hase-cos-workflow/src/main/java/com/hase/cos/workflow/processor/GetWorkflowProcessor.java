package com.hase.cos.workflow.processor;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentQuery;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Component
public class GetWorkflowProcessor implements Processor {

	@Resource
	private RepositoryService repositoryService;
	
	@Override
	public void process(Exchange exchange) throws Exception {
		
		DeploymentQuery deploymentQuery=repositoryService.createDeploymentQuery();
		
		List<Deployment> flows = deploymentQuery.list();
		
		JsonConfig jsonConfig=new JsonConfig();
		
		jsonConfig.setExcludes(new String[]{"resources"});
		
		JSONObject result=new JSONObject();
		
		JSONArray jsonArray=JSONArray.fromObject(flows,jsonConfig);
		
		exchange.getOut().setBody(jsonArray);
	}

}
