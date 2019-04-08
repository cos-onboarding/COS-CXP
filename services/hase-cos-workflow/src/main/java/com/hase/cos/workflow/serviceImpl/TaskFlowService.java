package com.hase.cos.workflow.serviceImpl;

import com.hase.cos.workflow.service.IApplicationService;
import com.hase.cos.workflow.service.ITaskFlowService;
import net.sf.json.JSONObject;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
@Service
public class TaskFlowService implements ITaskFlowService {
    @Resource
    private RepositoryService repositoryService;

    @Resource
    private RuntimeService runtimeService;

    @Resource
    private TaskService taskService;

    @Resource
    private IApplicationService iApplicationService ;
    @Override
    public boolean StartTask(String deploymentKey,String applicationId){
        try {
            ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(deploymentKey);
            // 启动流程服务
            Task task = taskService.createTaskQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .singleResult();

            Map<String, Object> map =new HashMap<String,Object>();
            map.put("process_id", task.getProcessInstanceId());
            map.put("application_id", applicationId);
            //int b = iApplicationService.UpdateProcessIdTest(task.getProcessInstanceId(),applicationId);
            int a = iApplicationService.UpdateProcessId(map);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * update processor status
     * @param object
     * @return
     */
    @Override
    public boolean UpdateTaskType(JSONObject object){
        String taskId = object.getString("taskId");
        String remarks = object.getString("remarks");
        String state = object.getString("state");
        String username = object.getString("username");

        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        Map<String, Object> map = new HashMap<String, Object>();

        String processInstanceId = task.getProcessInstanceId();
        // 给表act_hi_comment添加user_ID
        Authentication.setAuthenticatedUserId(username);
        // 添加流程操作信息
        taskService.addComment(taskId, processInstanceId, remarks);
        if (state.equals("1")) {
            map.put("msg", "pass");
        } else {
            map.put("msg", "Reject");
        }
        // 判断条件存在不
        if (object.containsKey("condition")) {
            String condition = object.getString("condition");
            map.put("condition", condition);
        }
        // 完成流程操作
        try {
            //taskService.complete(taskId, map);
            taskService.complete(taskId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
