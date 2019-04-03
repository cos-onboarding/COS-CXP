package com.hase.cos.workflow.serviceImpl;

import com.hase.cos.workflow.dao.IApplicationDao;
import com.hase.cos.workflow.service.IApplicationServiceImpl;

import javax.annotation.Resource;
import java.util.Map;

public class ApplicationService implements IApplicationServiceImpl {
    @Resource
    private IApplicationDao applicationDao;

    @Override
    public boolean UpdateOperationType(Map<String,Object> map){
        return applicationDao.UpdateOperationType(map);
    }
    @Override
    public int UpdateProcessId(Map<String,Object> map){
        return applicationDao.UpdateProcessId(map);
    }

}
