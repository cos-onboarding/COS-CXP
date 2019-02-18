package com.hase.cos.dashboard;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

@Component
public class DashboardProcessor implements Processor{

	@Override
	public void process(Exchange exchange) throws Exception {
		
		System.out.println("================");
		String str = "{\"staffId\":\"lisi\"}";
		exchange.getOut().setHeader("content-type", "application/json");
		exchange.getOut().setBody(str);
		System.out.println(exchange);
	}

}
