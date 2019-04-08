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
		InputStream isbpmn = DeploymentProcessor.class.getResourceAsStream("/META-INF/activiti/mymassflow.bpmn");
		InputStream isPng = DeploymentProcessor.class.getResourceAsStream("/META-INF/activiti/mymassflow.png");
		repositoryService.createDeployment()
		.name("mymassflow")
		.addInputStream("mymassflow.bpmn",isbpmn)
		.addInputStream("mymassflow.png", isPng)
		.deploy();
		exchange.getOut().setHeader("content-type", "application/json");
		exchange.getOut().setBody("deploy success.......");
	}
}
