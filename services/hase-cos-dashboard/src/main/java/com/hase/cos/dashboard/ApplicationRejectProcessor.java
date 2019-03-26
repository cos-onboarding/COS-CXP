package com.hase.cos.dashboard;

import java.io.InputStream;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
@Component("applicationRejectProcessor")
public class ApplicationRejectProcessor implements Processor {

<<<<<<< HEAD:services/hase-cos-dashboard/src/main/java/com/hase/cos/dashboard/LoginProcessor.java
@Component("loginProcessor")
public class LoginProcessor implements Processor {


=======
>>>>>>> 6e8428dc8e8cd1cd4881a52e973ab598e4ebab0d:services/hase-cos-dashboard/src/main/java/com/hase/cos/dashboard/ApplicationRejectProcessor.java
	@Override
	public void process(Exchange exchange) throws Exception {
		InputStream body = null;
		body = exchange.getIn().getBody(InputStream.class);
		String data = CamelProcessorUtils.setHttpBody(body);
		
        exchange.getOut().setHeader("content-type", "application/json");

        exchange.getOut().setBody(data);
		
	}
	
	

}
