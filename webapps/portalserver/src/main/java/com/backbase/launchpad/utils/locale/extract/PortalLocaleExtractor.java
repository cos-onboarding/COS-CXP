package com.backbase.launchpad.utils.locale.extract;

import com.backbase.portal.foundation.business.service.PortalBusinessService;
import com.backbase.portal.foundation.commons.exceptions.ItemNotFoundException;
import com.backbase.portal.foundation.domain.conceptual.Item;
import com.backbase.portal.foundation.domain.conceptual.PropertyDefinition;
import com.backbase.portal.foundation.domain.model.Portal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
class PortalLocaleExtractor extends DefaultExtractor {

    private static final String LOCALE_PREFERENCE_KEY = "locale";

    @Autowired
    private PortalBusinessService portalBusinessService;

    @Override
    public boolean handle(Item item) {
        String portalLocale = getPortalLocale(item);
        if (portalLocale.equals("")) {
            return false;
        } else {
            attachLocaleToRootItem(portalLocale, item);
            return true;
        }
    }

    private String getPortalLocale(Item rootItem) {
        Portal portal = getPortal(rootItem);
        String propertyValue = portal.getPropertyValue(LOCALE_PREFERENCE_KEY);
        return propertyValue == null ? "" : propertyValue;
    }

    private Portal getPortal(Item item) {
        try {
            return portalBusinessService.getPortal(item.getParentItemName(), false);
        } catch (ItemNotFoundException e) {
            Portal emptyPortal = new Portal();
            emptyPortal.setPropertyDefinitions(new HashMap<String, PropertyDefinition>());
            return emptyPortal;
        }
    }

    @Override
    public int getOrder() {
        return 2;
    }
}

