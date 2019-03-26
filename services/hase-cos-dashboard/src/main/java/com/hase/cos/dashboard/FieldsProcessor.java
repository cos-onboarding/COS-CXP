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
        InputStream body = null;
        body = exchange.getIn().getBody(InputStream.class);
        String data = CamelProcessorUtils.setHttpBody(body);
        JSONArray appData = JSONArray.fromObject(data);
        List<Map<String,Object>> appList = (List<Map<String,Object>>) appData;
        for (int i = 0; i < appList.size(); i++) {
            if("Company_Name".equals(appList.get(i).get("field").toString()) || "Appointment_Date_Time".equals(appList.get(i).get("field").toString()) ||
                    "Task_Due_Date".equals(appList.get(i).get("field").toString()) ||
                    "Document_Last_Upload_Date".equals(appList.get(i).get("field").toString()) || "Last_Modified_Date".equals(appList.get(i).get("field").toString()) ||
                    "Received_Date".equals(appList.get(i).get("field").toString()) || "Account_Number".equals(appList.get(i).get("field").toString())){

                appList.get(i).put("sortable",true);
            }
            appList.get(i).put("align","center");
        }
        exchange.getOut().setHeader("content-type", "application/json");
        exchange.getOut().setBody(appList);
    }
}
