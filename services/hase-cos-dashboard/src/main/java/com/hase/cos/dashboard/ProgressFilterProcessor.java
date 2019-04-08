package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import java.io.InputStream;


@Component("progressFilterProcessor")
public class ProgressFilterProcessor implements Processor {


    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("<==============================Progress Filter================================>");
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);

        exchange.getOut().setHeader("content-type", "application/json");

        exchange.getOut().setBody(data);

    }
}
