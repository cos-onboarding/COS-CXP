package com.hase.cos.workflow.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.hase.cos.workflow.entity.Staff;

public interface IStaffDao {
	
    public List<Staff> findAllStaff() throws Exception;

}
