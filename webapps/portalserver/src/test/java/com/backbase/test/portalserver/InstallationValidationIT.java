package com.backbase.test.portalserver;

import java.io.IOException;

import org.junit.Test;

import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.HttpResponse;
import org.apache.commons.codec.binary.Base64;

import static org.junit.Assert.fail;
import static org.junit.Assert.assertEquals;

public class InstallationValidationIT {

    /**
     * Test if the portal is running and if the admin user is available.
     *
     * @throws IOException when caused by executeMethod
     */
    @Test
    public void basicValidation() throws IOException {
        // request url assuming default set up
        String url = "http://localhost:${portal.port}/portalserver/users/admin";

        // set up the getMethod
        HttpGet method = new HttpGet(url);
        method.setHeader("Authorization", "Basic " + new String(Base64.encodeBase64(("admin:admin").getBytes())));
        method.setHeader("http.protocol.handle-redirects","false");

        // Execute the request
        CloseableHttpClient adminClient = HttpClients.createDefault();
        HttpResponse httpResponse = adminClient.execute(method);
        int resCode = httpResponse.getStatusLine().getStatusCode();

        // check if the http status code is 200 (OK)
        assertEquals("GET (" + url + ")", 200, resCode);
    }
}