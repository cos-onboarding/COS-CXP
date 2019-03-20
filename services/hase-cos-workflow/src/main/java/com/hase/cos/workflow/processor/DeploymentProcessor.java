package com.hase.cos.workflow.processor;

import java.io.InputStream;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

@Component
public class DeploymentProcessor implements Processor {

	@Resource
	private RepositoryService repositoryService;
	
	@Override
	public void process(Exchange exchange) throws Exception {
		InputStream isbpmn = DeploymentProcessor.class.getResourceAsStream("/META-INF/activiti/Myprocess.bpmn");
		InputStream isPng = DeploymentProcessor.class.getResourceAsStream("/META-INF/activiti/Myprocess.png");
		repositoryService.createDeployment()
		.name("MyProcess")
		.addInputStream("MyProcess.bpmn",isbpmn)
		.addInputStream("MyProcess.png", isPng)
		.deploy();
		exchange.getOut().setBody("success");
	}
}
