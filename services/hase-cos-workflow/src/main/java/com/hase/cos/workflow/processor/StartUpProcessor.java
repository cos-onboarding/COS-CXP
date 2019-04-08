package com.hase.cos.workflow.processor;


import com.hase.cos.workflow.service.ITaskFlowService;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;

import javax.annotation.Resource;
import java.io.InputStream;
import com.hase.cos.workflow.util.CamelProcessorUtils;

import org.springframework.stereotype.Component;

@Component("startUpProcessor")
public class StartUpProcessor implements Processor {
    @Resource
    private ITaskFlowService iTaskFlowService;
    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("StartUpProcessor_________________________________");
//        System.out.println("exchange" +exchange);
//        InputStream body  = exchange.getIn().getBody(InputStream.class);
//        String data = CamelProcessorUtils.setHttpBody(body);
//        System.out.println("data............"+data);
        Boolean flag = iTaskFlowService.StartTask("myProcess_1","a9eadaa33ef511e9944e68f728192098");
        System.out.println("flag....."+flag);
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(flag);
    }

}
