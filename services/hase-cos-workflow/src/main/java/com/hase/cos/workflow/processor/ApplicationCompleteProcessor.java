package com.hase.cos.workflow.processor;

import com.hase.cos.workflow.service.ITaskFlowService;
import com.hase.cos.workflow.util.CamelProcessorUtils;
import net.sf.json.JSONObject;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.InputStream;
@Component("applicationCompleteProcessor")
public class ApplicationCompleteProcessor implements Processor {
    @Resource
    private ITaskFlowService taskFlowService;
    @Resource
    private TaskService taskService;
    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("exchange" +exchange);
//        InputStream body  = exchange.getIn().getBody(InputStream.class);
//        String data = CamelProcessorUtils.setHttpBody(body);
//        JSONObject jsonStr = JSONObject.fromObject(data);
        //exchange.getIn().getHeaders().get()
//        String assignUser = jsonStr.getString("name");
//        String processInstanceId = jsonStr.getString("processInstanceId");
        String assignUser = exchange.getIn().getHeaders().get("name").toString();
        String processInstanceId = exchange.getIn().getHeaders().get("id").toString();
        Task task = taskService.createTaskQuery()
                    .taskAssignee(assignUser)
                    .processInstanceId(processInstanceId)
                    .singleResult();
        String taskId= taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult().getId();
        taskService.complete(taskId);
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody("true");
    }
}
