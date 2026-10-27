<%@page import="com.redsys.linkedin.publications.configuration.LinkedinPortletConfiguration"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
	taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
	taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
	taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@page import="com.liferay.petra.string.StringPool" %>
<%@page import="com.redsys.linkedin.publications.constants.LinkedinPortletKeys" %>
<%@
taglib uri="http://liferay.com/tld/clay" prefix="clay" %>
<%@
page import="com.liferay.portal.kernel.util.GetterUtil" %>
<liferay-theme:defineObjects />

<portlet:defineObjects />

<%
    String titleCompany = StringPool.BLANK;
    boolean simulation = false;
    String token = StringPool.BLANK;
    String clientId = StringPool.BLANK;
    String clientSecret = StringPool.BLANK;
    String organizationId = StringPool.BLANK;
    String urlHome = StringPool.BLANK;
    String modoPeticion = StringPool.BLANK;
    String contexto = StringPool.BLANK;
    int cantidadPublicaciones = 6;

    LinkedinPortletConfiguration displayConfiguration =
	(LinkedinPortletConfiguration) request.getAttribute(LinkedinPortletConfiguration.class.getName());

    titleCompany = portletPreferences.getValue(LinkedinPortletKeys.PARAM_TITLE, displayConfiguration.title());
    token = portletPreferences.getValue(LinkedinPortletKeys.PARAM_TOKEN, displayConfiguration.token());
    clientId = portletPreferences.getValue(LinkedinPortletKeys.PARAM_CLIENT_ID, displayConfiguration.clientId());
    clientSecret = portletPreferences.getValue(LinkedinPortletKeys.PARAM_CLIENT_SECRET, displayConfiguration.clientSecret());
    organizationId = portletPreferences.getValue(LinkedinPortletKeys.PARAM_ORGANIZATION_ID, displayConfiguration.organizationId());
    urlHome = portletPreferences.getValue(LinkedinPortletKeys.PARAM_URL_HOME, displayConfiguration.urlHome());
    simulation = GetterUtil.getBoolean(portletPreferences.getValue(LinkedinPortletKeys.PARAM_SIMULATON, displayConfiguration.simulation()));
    modoPeticion = portletPreferences.getValue(LinkedinPortletKeys.PARAM_MODO_PETICION, displayConfiguration.modoPeticion());
    contexto = portletPreferences.getValue(LinkedinPortletKeys.PARAM_CONTEXTO, displayConfiguration.contexto());
    cantidadPublicaciones = GetterUtil.getInteger(portletPreferences.getValue(LinkedinPortletKeys.PARAM_CANTIDAD_PUBLICACIONES,String.valueOf(displayConfiguration.cantidadPublicaciones())));


%>