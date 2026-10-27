package com.redsys.language;

import com.liferay.portal.kernel.language.UTF8Control;
import com.liferay.portal.kernel.util.LocaleUtil;
import com.liferay.portal.kernel.util.ResourceBundleUtil;

import java.util.Enumeration;
import java.util.ResourceBundle;

import org.osgi.service.component.annotations.Component;
/**
 * @author Yordy Tafur
 */
@Component(
        property = { "language.id=fr_FR" },
        service = ResourceBundle.class
)public class FrenchResourceBundle extends ResourceBundle {

    @Override
    protected Object handleGetObject(String key) {
        return _resourceBundle.getObject(key);
    }

    @Override
    public Enumeration<String> getKeys() {
        return _resourceBundle.getKeys();
    }

    private final ResourceBundle _resourceBundle = ResourceBundle.getBundle(
            "content.Language_fr", UTF8Control.INSTANCE);

}

