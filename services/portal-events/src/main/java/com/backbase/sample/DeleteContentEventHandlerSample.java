package com.backbase.sample;

import com.backbase.portal.foundation.business.events.impl.content.DeleteContentEvent;
import com.backbase.portal.foundation.extensionapi.event.domain.Event;
import com.backbase.portal.foundation.extensionapi.event.handler.AbstractSynchronousEventHandler;
import com.backbase.portal.foundation.extensionapi.event.handler.EventHandlerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * [DeleteContentEventHandler Sample class to provide an initial event handler setup.]
 */
@Component
public class DeleteContentEventHandlerSample extends AbstractSynchronousEventHandler {


    private static final Logger LOGGER = LoggerFactory.getLogger(DeleteContentEventHandlerSample.class);


    public DeleteContentEventHandlerSample() {
        super(DeleteContentEvent.class);
        LOGGER.info("DeleteContentEventHandlerSample Initialized");
    }

    @Override
    public void handleEvent(Event event) throws EventHandlerException {

        DeleteContentEvent content = (DeleteContentEvent) event;
        String contentType = content.getContentType();
        LOGGER.warn("An item of type {} is about to be deleted.", contentType);

    }
}
