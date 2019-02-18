package com.backbase.launchpad.utils.locale.extract;

import com.backbase.portal.foundation.business.service.UserBusinessService;
import com.backbase.portal.foundation.commons.exceptions.ItemNotFoundException;
import com.backbase.portal.foundation.domain.conceptual.Item;
import com.backbase.portal.foundation.domain.conceptual.UserPropertyDefinition;
import com.backbase.portal.foundation.domain.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
class UserLocaleExtractor extends DefaultExtractor {

    private static final String LOCALE_PREFERENCE_KEY = "lpLocale";

    @Autowired
    private UserBusinessService userService;

    @Override
    public boolean handle(Item item) {
        String userLocale = getUserLocale(getCurrentUser());
        if (userLocale.equals("")) {
            return false;
        } else {
            attachLocaleToRootItem(userLocale, item);
            return true;
        }
    }

    private String getUserLocale(User user) {
        Map<String, UserPropertyDefinition> propertyDefinitions = user.getPropertyDefinitions();
        for (String key : propertyDefinitions.keySet()) {
            if (key.equals(LOCALE_PREFERENCE_KEY)) {
                return propertyDefinitions.get(key).getValue().toString();
            }
        }
        return "";
    }

    private User getCurrentUser() {
        String username = userService.getCurrentUser().getUsername();
        try {
            return userService.getUser(username);
        } catch (ItemNotFoundException e) {
            User emptyUser = new User();
            emptyUser.setPropertyDefinitions(new HashMap<String, UserPropertyDefinition>());
            return emptyUser;
        }
    }

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE;
    }

}
