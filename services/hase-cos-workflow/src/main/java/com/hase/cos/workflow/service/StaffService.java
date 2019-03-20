package com.hase.cos.workflow.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hase.cos.workflow.dao.IStaffDao;
import com.hase.cos.workflow.entity.Staff;

@Service
public class StaffService {

	public StaffService() {
		System.out.println("123123123123");
	}
	
	@Resource
	private IStaffDao staffDao;
	
	public List<Staff> findAllStaff() throws Exception {
		
		return staffDao.findAllStaff();
	}
}
