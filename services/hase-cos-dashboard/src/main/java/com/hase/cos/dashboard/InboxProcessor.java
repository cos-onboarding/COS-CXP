package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import net.sf.json.JSONObject;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import java.io.InputStream;

@Component("inboxProcessor")
public class InboxProcessor implements Processor {


    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("<============================== inboxProcessor ================================>");
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);
        JSONObject appData = JSONObject.fromObject(data);

        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(data);
    }
}
