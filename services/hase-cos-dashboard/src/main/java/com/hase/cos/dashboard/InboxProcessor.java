package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

@Component("inboxProcessor")
public class InboxProcessor implements Processor {


    @Override
    public void process(Exchange exchange) throws Exception {
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);
        JSONArray appData = JSONArray.fromObject(data);
        List<Map<String,Object>> appList = (List<Map<String,Object>>) appData;
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(appList);
    }
}
