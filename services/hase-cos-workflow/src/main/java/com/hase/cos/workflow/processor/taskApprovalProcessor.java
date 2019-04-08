package com.hase.cos.workflow.processor;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.activiti.engine.TaskService;
import javax.annotation.Resource;
import org.activiti.engine.task.Task;

public class taskApprovalProcessor implements Processor {

    @Resource
    private TaskService taskService;
    @Override
    public void process(Exchange exchange) throws Exception {
        // 创建任务查询 根据任务id查询
        Task task=taskService.createTaskQuery()
                .taskId("taskId")
                .singleResult();
    }


}
