package com.redsys.language;

import com.liferay.portal.kernel.language.UTF8Control;
import com.liferay.portal.kernel.util.LocaleUtil;
import com.liferay.portal.kernel.util.ResourceBundleUtil;
import org.osgi.service.component.annotations.Component;

import java.util.Enumeration;
import java.util.ResourceBundle;

/**
 * @author Abba Chej Dehan
 */
@Component(property = "language.id=es_ES", service = ResourceBundle.class)
public class SpanishResourceBundle extends ResourceBundle {

    @Override
    protected Object handleGetObject(String key) {
        return _resourceBundle.getObject(key);
    }

    @Override
    public Enumeration<String> getKeys() {
        return _resourceBundle.getKeys();
    }

    private final ResourceBundle _resourceBundle = ResourceBundle.getBundle(
            "content.Language_es", UTF8Control.INSTANCE);

}
