package com.hase.cos.dashboard;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("responseGetSessionProcessor")
public class ResponseGetSessionProcessor implements Processor {

	@Autowired
	private HttpServletRequest request; 
	@Override
	public void process(Exchange exchange) throws Exception {
		
		HttpSession session = request.getSession();
		Object ss =  session.getAttribute("userData");
		System.out.println("----------ff-----------");
		System.out.println(ss.toString());
		System.out.println("---------------------");
        exchange.getOut().setHeader("content-type", "application/json");

        exchange.getOut().setBody(ss.toString());
	}

}
