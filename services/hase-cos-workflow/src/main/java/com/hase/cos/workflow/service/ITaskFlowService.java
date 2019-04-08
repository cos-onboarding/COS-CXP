package com.hase.cos.workflow.service;
import net.sf.json.JSONObject;

public interface ITaskFlowService {

    boolean StartTask(String workFlowId,String applicationId);
    boolean UpdateTaskType(JSONObject object);
}
