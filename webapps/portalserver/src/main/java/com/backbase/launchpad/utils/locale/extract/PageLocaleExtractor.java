package com.backbase.launchpad.utils.locale.extract;

import com.backbase.portal.foundation.domain.conceptual.Item;
import org.springframework.stereotype.Component;

@Component
class PageLocaleExtractor extends DefaultExtractor {

    private static final String LOCALE_PREFERENCE_KEY = "locale";

    @Override
    public boolean handle(Item item) {
        String pageLocale = getPageLocale(item);
        if (pageLocale.equals("")) {
            return false;
        } else {
            attachLocaleToRootItem(pageLocale, item);
            return true;
        }
    }

    private String getPageLocale(Item rootItem) {
        String propertyValue = rootItem.getPropertyValue(LOCALE_PREFERENCE_KEY);
        return propertyValue == null ? "" : propertyValue;
    }

    @Override
    public int getOrder() {
        return 1;
    }
}
