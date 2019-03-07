package com.hase.cos.dashboard;

import com.hase.cos.dashboard.util.CamelProcessorUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component("fieldsProcessor")
public class FieldsProcessor implements Processor {
    @Override
    public void process(Exchange exchange) throws Exception {
        System.out.println("<============================== FieldsProcessor ================================>");
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);
        JSONArray appData = JSONArray.fromObject(data);
        List<Map<String,Object>> appList = (List<Map<String,Object>>) appData;
        for (int i = 0; i < appList.size(); i++) {
            if(appList.get(i).get("title").toString().equals("Company_Name") || appList.get(i).get("title").toString().equals("Appointment_Date_Time") ||
                    appList.get(i).get("title").toString().equals("Handling_Call_Agent") || appList.get(i).get("title").toString().equals("Task_Due_Date") ||
                    appList.get(i).get("title").toString().equals("Document_Last_Upload_Date") || appList.get(i).get("title").toString().equals("Last_Modified_Date") ||
                    appList.get(i).get("title").toString().equals("Received_Date") || appList.get(i).get("title").toString().equals("Account_Number")){

                appList.get(i).put("sortable",true);
            }
            appList.get(i).put("align","center");
        }
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(appList);
    }
}
