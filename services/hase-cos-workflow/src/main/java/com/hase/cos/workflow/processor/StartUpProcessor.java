package com.hase.cos.workflow.processor;

import com.hase.cos.workflow.service.ITaskFlowService;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;

import javax.annotation.Resource;

public class StartUpProcessor implements Processor {
    @Resource
    private ITaskFlowService taskFlowService;
    @Override
    public void process(Exchange exchange) throws Exception {
        Boolean flag = taskFlowService.StartTask("qq","qq");
        exchange.getOut().setBody(flag);
    }

}
