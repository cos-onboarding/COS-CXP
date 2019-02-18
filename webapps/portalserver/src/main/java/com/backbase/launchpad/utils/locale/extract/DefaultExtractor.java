package com.backbase.launchpad.utils.locale.extract;

import com.backbase.portal.foundation.domain.conceptual.Item;
import com.backbase.portal.foundation.domain.conceptual.PropertyDefinition;
import com.backbase.portal.foundation.domain.conceptual.StringPropertyValue;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;

@Component
public class DefaultExtractor implements LocaleExtractor, Ordered {

    private static final String LP_LOCALE_PREFERENCE_KEY = "lpLocale";

    @Override
    public boolean handle(Item item) {
        throw new IllegalStateException("No property defined for locale in properties file");
    }

    @Override
    public int getOrder() {
        return Ordered.LOWEST_PRECEDENCE;
    }

    protected void attachLocaleToRootItem(String locale, Item rootItem) {
        PropertyDefinition localeProperty = createLocaleProperty(locale);
        rootItem.setProperty(localeProperty);
    }

    private PropertyDefinition createLocaleProperty(String value) {
        StringPropertyValue propertyValue = new StringPropertyValue(value.trim());
        PropertyDefinition propertyDefinition = new PropertyDefinition(LP_LOCALE_PREFERENCE_KEY, propertyValue);
        propertyDefinition.setValue(propertyValue);
        return propertyDefinition;
    }
}
