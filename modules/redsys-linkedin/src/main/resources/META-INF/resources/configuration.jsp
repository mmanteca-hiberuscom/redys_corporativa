<%@ include file="./init.jsp" %>
<%@page import="com.liferay.portal.kernel.util.Constants"%>

<!-- Our configuration action URL -->
<liferay-portlet:actionURL portletConfiguration="<%= true %>" var="configurationActionURL" />

<!-- URL to redirect to after the form is submitted -->
<liferay-portlet:renderURL portletConfiguration="<%= true %>" var="configurationRenderURL" />

<aui:form action="<%= configurationActionURL %>" method="post" name="fm">

<aui:input
            name="<%= Constants.CMD %>"
            type="hidden"
            value="<%= Constants.UPDATE %>"
    />

    <aui:input
            name="redirect"
            type="hidden"
            value="<%= configurationRenderURL %>"
    />

		<div class="portlet-configuration-body-content">
        		<div class="container-fluid container-fluid-max-xl">
        			<div class="sheet">
			<aui:input checked="<%= simulation %>" label="simulation" name="<%= LinkedinPortletKeys.PARAM_SIMULATON %>" type="checkbox" />
			 <aui:select name="<%= LinkedinPortletKeys.PARAM_MODO_PETICION %>" label="Modo de traer las publicaciones:" >
                                 <aui:option value="curl" selected="<%= "curl".equals(modoPeticion) %>">Por CURL</aui:option>
                                 <aui:option value="java" selected="<%= "java".equals(modoPeticion) %>">Por Java</aui:option>
                             </aui:select>
    			<aui:input label="Titulo" name="<%= LinkedinPortletKeys.PARAM_TITLE %>" value="<%= titleCompany %>" />
    			<aui:input label="Organization Id" name="<%= LinkedinPortletKeys.PARAM_ORGANIZATION_ID %>" value="<%= organizationId %>" />
    			<aui:input label="Token" name="<%= LinkedinPortletKeys.PARAM_TOKEN %>" value="<%= token %>" />
    			<aui:input label="Url Linkedin Home" name="<%= LinkedinPortletKeys.PARAM_URL_HOME %>" value="<%= urlHome %>" />
    			<aui:input label="Cantidad de publicaciones a mostrar" name="<%= LinkedinPortletKeys.PARAM_CANTIDAD_PUBLICACIONES %>" value="<%= cantidadPublicaciones  %>" />
    			<aui:input label="Contexto" name="<%= LinkedinPortletKeys.PARAM_CONTEXTO %>" value="<%= contexto %>" />
    			<aui:input label="clientId" name="<%= LinkedinPortletKeys.PARAM_CLIENT_ID %>" value="<%= clientId %>" />
    			<aui:input label="clientSecret" name="<%= LinkedinPortletKeys.PARAM_CLIENT_SECRET %>" value="<%= clientSecret %>" />

        </div>
        </div>
        </div>

<aui:button-row>
		<aui:button cssClass="btn-lg" name="submitButton" type="submit" value="save" />
	</aui:button-row>
</aui:form>

