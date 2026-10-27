package com.redsys.linkedin.publications.configuration;

import aQute.bnd.annotation.metatype.Meta;
import com.redsys.linkedin.publications.constants.LinkedinPortletKeys;

/*
 * This interface is where we describe our configuration.
 * Here is where we declare our configuration fields and their respective types.
 *
 * You can see what each annotation attribute means by inspecting the
 * aQute.bnd.annotation.metatype.Meta interface.
 */
@Meta.OCD(
    id = LinkedinPortletKeys.PORTLET_CONFIGURATION_ID,
    localization = "content/Language",
    name = "linkedin-portlet-configuration"
)
public interface LinkedinPortletConfiguration {

	/*
	 * Each method describes a configuration field. The method return type
	 * indicates the field type. In this case, it is a String.
	 */
    @Meta.AD(required = false, deflt = "")
    public String title();

    @Meta.AD(required = false, deflt = "")
    public String organizationId();

    @Meta.AD(required = false, deflt = "")
    public String token();
    @Meta.AD(required = false, deflt = "")
    public String urlHome();

    @Meta.AD(required = false, deflt = "")
    public String clientId();

    @Meta.AD(required = false, deflt = "")
    public String clientSecret();
    @Meta.AD(required = false, deflt = "")
    public String simulation();

    @Meta.AD(required = false, deflt = "curl")
    public String modoPeticion();

    @Meta.AD(required = false, deflt = "")
    public String contexto();

    @Meta.AD(required = false, deflt = "6")
    public int cantidadPublicaciones();

}
