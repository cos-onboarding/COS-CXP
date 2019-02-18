package com.backbase.launchpad.utils.locale;

import com.backbase.launchpad.utils.locale.extract.LocaleExtractorChain;
import com.backbase.portal.foundation.domain.conceptual.Item;
import com.backbase.portal.foundation.domain.presentation.event.BeforeServerSideRenderingEvent;
import com.backbase.portal.foundation.extensionapi.event.domain.Event;
import com.backbase.portal.foundation.extensionapi.event.handler.AbstractSynchronousEventHandler;
import com.backbase.portal.foundation.extensionapi.event.handler.EventHandlerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class AttachLocaleToItemHandler extends AbstractSynchronousEventHandler {

    public AttachLocaleToItemHandler() {
        super(BeforeServerSideRenderingEvent.class);
    }

    @Autowired
    private LocaleExtractorChain localeExtractor;

    @Override
    public void handleEvent(Event event) throws EventHandlerException {
        BeforeServerSideRenderingEvent ssRenderingEvent = (BeforeServerSideRenderingEvent) event;
        Item rootItem = ssRenderingEvent.getRootItem();
        localeExtractor.attachLocaleTo(rootItem);
    }

}
