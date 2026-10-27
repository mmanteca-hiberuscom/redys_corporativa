package com.redsys.language;

import com.liferay.portal.kernel.language.UTF8Control;

import java.util.Enumeration;
import java.util.ResourceBundle;

import org.osgi.service.component.annotations.Component;
/**
 * @author Yordy Tafur
 */
@Component(
        property = { "language.id=pt_PT" },
        service = ResourceBundle.class
)public class PortugueseResourceBundle extends ResourceBundle {

    @Override
    protected Object handleGetObject(String key) {
        return _resourceBundle.getObject(key);
    }

    @Override
    public Enumeration<String> getKeys() {
        return _resourceBundle.getKeys();
    }

    private final ResourceBundle _resourceBundle = ResourceBundle.getBundle(
            "content.Language_pt", UTF8Control.INSTANCE);

}
