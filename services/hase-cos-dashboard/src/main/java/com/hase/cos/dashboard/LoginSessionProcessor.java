package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.InputStream;

@Component("responseLoginSession")
public class LoginSessionProcessor implements Processor {
	
	@Autowired
	private HttpServletRequest request;
	@Override
	public void process(Exchange exchange) throws Exception {
		InputStream body = null;
		body = exchange.getIn().getBody(InputStream.class);
		String sessionData = CamelProcessorUtils.setHttpBody(body);
		System.out.println("+++++++++++");
		System.out.println(sessionData);
		HttpSession session = request.getSession();
		session.setAttribute("data",sessionData);
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(sessionData);
	}
}
