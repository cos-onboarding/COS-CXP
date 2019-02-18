package com.backbase.launchpad.utils.locale.extract;

import com.backbase.portal.commons.configuration.BackbaseConfiguration;
import com.backbase.portal.foundation.domain.conceptual.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
class PropertyLocaleExtractor extends DefaultExtractor {

    private static final String LOCALE_PROPERTY_KEY = "launchpad.defaultLocale";

    @Autowired
    @Qualifier("backbaseConfiguration")
    private BackbaseConfiguration backbaseConfiguration;

    @Override
    public boolean handle(Item item) {
        String propertyLocale = getPropertyLocale();
        if (propertyLocale.equals("")) {
            return false;
        } else {
            attachLocaleToRootItem(propertyLocale, item);
            return true;
        }
    }

    private String getPropertyLocale() {
        String propertyValue = backbaseConfiguration.getString(LOCALE_PROPERTY_KEY);
        return propertyValue == null ? "" : propertyValue;
    }

    @Override
    public int getOrder() {
        return 3;
    }
}




