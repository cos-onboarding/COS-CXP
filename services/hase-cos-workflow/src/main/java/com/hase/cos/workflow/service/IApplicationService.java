package com.hase.cos.workflow.service;

import java.util.Map;

public interface IApplicationService {
    public int UpdateOperationType(Map<String,Object> map);
    public int UpdateProcessId(Map<String,Object> map);
    public int UpdateProcessIdTest(String process_id,String application_id);
}
