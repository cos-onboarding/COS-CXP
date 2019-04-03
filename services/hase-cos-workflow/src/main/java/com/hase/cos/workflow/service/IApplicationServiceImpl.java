package com.hase.cos.workflow.service;

import java.util.Map;

public interface IApplicationServiceImpl {
    public boolean UpdateOperationType(Map<String,Object> map);
    public int UpdateProcessId(Map<String,Object> map);
}
