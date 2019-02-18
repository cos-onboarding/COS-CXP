package com.backbase.sample;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * Describes a processor that will logs the {@link Exchange} body
 */
@Component
public class SampleProcessor implements Processor {

    private static final Logger LOGGER = LoggerFactory.getLogger(SampleProcessor.class);

    @Override
    public void process(Exchange exchange) throws Exception {
        LOGGER.warn("Processing exchange : {}", exchange.getIn().getBody(String.class));
    }
}
