package com.hase.cos.workflow.processor;

import java.util.List;

import javax.annotation.Resource;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import com.hase.cos.workflow.entity.Staff;
import com.hase.cos.workflow.service.StaffService;

import net.sf.json.JSONArray;

@Component
public class GetAllStaffProcessor implements Processor {

	@Resource
	private StaffService staffService;
	
	@Override
	public void process(Exchange exchange) throws Exception {
		// TODO Auto-generated method stub
		List<Staff> staffs = staffService.findAllStaff();
		JSONArray jsonArray=JSONArray.fromObject(staffs);
		exchange.getOut().setBody(jsonArray);
	}

}
