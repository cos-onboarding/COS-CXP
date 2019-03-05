package com.hase.cos.dashboard.processor;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.hase.cos.dashboard.properties.CosPropertyPlaceholder;


@Component
public class CosDashboardLoginProcessor implements Processor{

    @Autowired
    @Qualifier("cosPropertyPlaceholder")
    private CosPropertyPlaceholder cosPropertyPlaceholder;
    
	
	@Override
	public void process(Exchange exchange) throws Exception {
		Object obj = exchange.getIn().getBody();
		System.out.println(cosPropertyPlaceholder.getProperty("RSO.Search_by"));
		exchange.getIn().setBody("login successfully...");
	}

}
