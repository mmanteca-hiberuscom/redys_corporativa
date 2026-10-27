package com.redsys.linkedin.publications.configuration;

import com.liferay.portal.configuration.metatype.bnd.util.ConfigurableUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.util.ParamUtil;
import com.redsys.linkedin.publications.constants.LinkedinPortletKeys;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.ConfigurationPolicy;
import org.osgi.service.component.annotations.Modified;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;


@Component(
        configurationPid = LinkedinPortletKeys.PORTLET_CONFIGURATION_ID,
	configurationPolicy = ConfigurationPolicy.OPTIONAL, immediate = true,
    property = {
        "javax.portlet.name=" + LinkedinPortletKeys.PORTLET_ID
    },
    service = ConfigurationAction.class
)
public class LinkedinConfigurationAction extends DefaultConfigurationAction {

    @Override
    public void processAction(
            PortletConfig portletConfig, ActionRequest actionRequest,
            ActionResponse actionResponse)
        throws Exception {

        String title = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_TITLE);
        String token = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_TOKEN);
        String urlHome = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_URL_HOME);
        String clientId = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_CLIENT_ID);
        String clientSecret = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_CLIENT_SECRET);
        String organizationId = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_ORGANIZATION_ID);
        String simulation = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_SIMULATON);
        String modoPeticion = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_MODO_PETICION, "java");
        String contexto = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_CONTEXTO);
        String cantidadPublicaciones = ParamUtil.getString(actionRequest, LinkedinPortletKeys.PARAM_CANTIDAD_PUBLICACIONES);


        _log.debug("Title: \"" + title + "\"");
        _log.debug("token: \"" + token + "\"");
        _log.debug("urlHome: \"" + urlHome + "\"");
        _log.debug("clientId: \"" + clientId + "\"");
        _log.debug("clientSecret: \"" + clientSecret + "\"");
        _log.debug("organizationId: \"" + organizationId + "\"");
        _log.debug("simulation: \"" + simulation + "\"");
        _log.debug("modoPeticion: \"" + modoPeticion + "\"");
        _log.debug("contexto: \"" + contexto + "\"");
        _log.debug("cantidadPublicaciones: \"" + cantidadPublicaciones + "\"");

        setPreference(actionRequest, LinkedinPortletKeys.PARAM_TITLE, title);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_TOKEN, token);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_URL_HOME, urlHome);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_CLIENT_ID, clientId);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_CLIENT_SECRET, clientSecret);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_ORGANIZATION_ID, organizationId);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_SIMULATON, simulation);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_MODO_PETICION, modoPeticion);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_CONTEXTO, contexto);
        setPreference(actionRequest, LinkedinPortletKeys.PARAM_CANTIDAD_PUBLICACIONES, cantidadPublicaciones);


        super.processAction(portletConfig, actionRequest, actionResponse);
    }

	@Override
	public void include(PortletConfig portletConfig, HttpServletRequest httpServletRequest,
			HttpServletResponse httpServletResponse) throws Exception {

		httpServletRequest.setAttribute(
                LinkedinPortletConfiguration.class.getName(),
                _linkedinConfiguration);

		super.include(portletConfig, httpServletRequest, httpServletResponse);
	}

	/*
	 * The method used to instantiate our configuration field
	 */
    @Activate
    @Modified
    protected void activate(Map<Object, Object> properties) {
        _linkedinConfiguration = ConfigurableUtil.createConfigurable(
                LinkedinPortletConfiguration.class, properties);
    }

    /*
     * Field used to access configuration values
     */
    private volatile LinkedinPortletConfiguration _linkedinConfiguration;


    private static final Log _log = LogFactoryUtil.getLog(
            ConfigurationAction.class);
}
