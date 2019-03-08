package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

@Component("inboxAcceptProcessor")
public class inboxAcceptProcessor implements Processor {
    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("<============================== inboxAcceptProcessor ================================>");
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);
        data = data.substring(7,data.length());
        data.trim();
        Map<String,Object> map = new HashMap<>();
        map.put("roleId",data);
        JSONObject json = JSONObject.fromObject(map);
        json.toString();
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(json);
    }
}
