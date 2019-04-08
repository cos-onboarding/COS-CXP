package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import net.sf.json.JSONArray;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.InputStream;

@Component("progressSessionProcessor")
public class ProgressSessionProcessor implements Processor {

    @Autowired
    private HttpServletRequest request;
    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("<==============================Progress Session Filter================================>");
        HttpSession session = request.getSession();
        Object sessionData =  session.getAttribute("data");
        System.out.println("sessionData"+sessionData);
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);
        System.out.println("data"+data);
        JSONArray jsonObject = JSONArray.fromObject(data);
        System.out.println("jsonObject"+jsonObject);
        if(sessionData!=null){
            jsonObject.add(sessionData);
        }
        System.out.println(jsonObject);
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(jsonObject.toString());
    }
}
