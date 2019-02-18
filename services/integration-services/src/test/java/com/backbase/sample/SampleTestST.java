package com.backbase.sample;

import com.backbase.extensions.mosaic.camel.test.AbstractBackbaseIntegrationTest;
import com.backbase.extensions.mosaic.camel.test.RestletCall;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.restlet.data.Status;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.assertNotEquals;

/**
 * Sample Test Class
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SampleTestST extends AbstractBackbaseIntegrationTest {

    private static final Logger LOGGER = LoggerFactory.getLogger(SampleTestST.class);
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private ResourceLoader resourceLoader;

    @Before
    public void init() {
        objectMapper.configure(SerializationConfig.Feature.INDENT_OUTPUT, true);
    }

    @Test
    public void getSampleService() throws IOException {
        RestletCall restletCall = new RestletCall("/sample").expectedStatus(Status.SUCCESS_OK);

        Map response = restlet.get(restletCall, HashMap.class);
        LOGGER.debug("Response: {}", objectMapper.writeValueAsString(response));

        Map data = (HashMap) response.get("data");
        assertNotEquals(0, data.size());
    }

    @Test
    public void getNotFoundService() throws IOException {
        RestletCall restletCall = new RestletCall("/notfound").expectedStatus(Status.CLIENT_ERROR_NOT_FOUND);
        restlet.get(restletCall);
    }

}
