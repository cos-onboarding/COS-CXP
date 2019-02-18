package com.backbase.launchpad.utils.locale.extract;

import com.backbase.portal.foundation.domain.conceptual.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.AnnotationAwareOrderComparator;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collections;
import java.util.List;

/**
 * Implements Chain of Responsibility pattern
 */
@Component
public class LocaleExtractorChain {

    @Autowired
    private List<LocaleExtractor> extractorsList;

    @PostConstruct
    public void init() {
        Collections.sort(extractorsList, AnnotationAwareOrderComparator.INSTANCE);
    }

    public void attachLocaleTo(Item item) {
        for (LocaleExtractor extractor : extractorsList) {
            boolean handled = extractor.handle(item);
            if (handled) {
                break;
            }
        }
    }

}
