package com.hase.cos.workflow.dao;

import java.util.Map;

public interface IApplicationDao {
    boolean UpdateOperationType(Map<String,Object> map);
    int UpdateProcessId(Map<String,Object> map);
}
