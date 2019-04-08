package com.hase.cos.workflow.serviceImpl;

import com.hase.cos.workflow.dao.IApplicationDao;
import com.hase.cos.workflow.service.IApplicationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;
@Service
public class ApplicationService implements IApplicationService {
    @Resource
    private IApplicationDao iApplicationDao;

    @Override
    public int UpdateOperationType(Map<String,Object> map){
        return iApplicationDao.UpdateOperationType(map);
    }
    @Override
    public int UpdateProcessId(Map<String,Object> map){
        return iApplicationDao.UpdateProcessId(map);
    }
    @Override
    public int UpdateProcessIdTest(String process_id,String application_id){
        return iApplicationDao.UpdateProcessIdTest(process_id,application_id);
    }

}
