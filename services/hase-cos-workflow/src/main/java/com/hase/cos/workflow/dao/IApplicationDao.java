package com.hase.cos.workflow.dao;

import java.util.Map;

public interface IApplicationDao {
    public int UpdateOperationType(Map<String,Object> map);
    public int UpdateProcessId(Map<String,Object> map);
    public int UpdateProcessIdTest(String process_id,String application_id);

}
