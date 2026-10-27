
package com.redsys.linkedin.publications.portlet;

import com.liferay.petra.string.StringPool;
import com.liferay.portal.configuration.metatype.bnd.util.ConfigurableUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.redsys.linkedin.publications.configuration.LinkedinPortletConfiguration;
import com.redsys.linkedin.publications.constants.LinkedinPortletKeys;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Modified;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import java.io.IOException;
import java.util.Map;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.redsys.linkedin.publications.model.LinkedInPost;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;




/**
 * @author Abba Chej Dehan
 */

@Component(
		configurationPid = LinkedinPortletKeys.PORTLET_CONFIGURATION_ID,
		immediate = true,

		property = {
		"com.liferay.portlet.display-category=Redsys",
				"com.liferay.portlet.css-class-wrapper=redsys-linkedin-portlet",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=" + LinkedinPortletKeys.PORTLET_DISPLAY_NAME,
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
			"javax.portlet.name=" + LinkedinPortletKeys.PORTLET_ID,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class LinkedinPortlet extends MVCPortlet {

	private static final String ORGANIZATION_ID = ""; // Reemplázalo con el ID de la empresa en LinkedIn
	private static final String ACCESS_TOKEN = "";
	private static final Log _log = LogFactoryUtil.getLog(LinkedinPortlet.class);
	@Override

	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {

		ThemeDisplay themeDisplay = (ThemeDisplay)renderRequest.getAttribute(
				WebKeys.THEME_DISPLAY);
		String layoutMode = ParamUtil.getString(
				themeDisplay.getRequest(), "p_l_mode", "");
		renderRequest.setAttribute(
				LinkedinPortletConfiguration.class.getName(),
				_linkedinConfiguration);

		_log.debug("User ID: " + themeDisplay.getUserId());
		_log.debug("Company ID: " + themeDisplay.getCompanyId());
		_log.debug("Layout Name: " + themeDisplay.getLayout().getName(themeDisplay.getLocale()));

		if(layoutMode.equals("edit")){
			_log.debug("en modo edicion no se conecta a nada");
			return;
		}

		_log.debug("iniciando conexion con linkedin...");

		String organizationId = renderRequest.getPreferences().getValue(LinkedinPortletKeys.PARAM_ORGANIZATION_ID, _linkedinConfiguration.organizationId());
		String token = renderRequest.getPreferences().getValue(LinkedinPortletKeys.PARAM_TOKEN, _linkedinConfiguration.token());

		_log.debug("organizationId: " + organizationId);
		_log.debug("token: " + token);

		boolean simulation = GetterUtil.getBoolean(renderRequest.getPreferences().getValue(LinkedinPortletKeys.PARAM_SIMULATON,
				_linkedinConfiguration.simulation()));
		String modoPeticion = renderRequest.getPreferences().getValue(LinkedinPortletKeys.PARAM_MODO_PETICION,
				_linkedinConfiguration.modoPeticion());
		String contexto = renderRequest.getPreferences().getValue(LinkedinPortletKeys.PARAM_CONTEXTO,
				_linkedinConfiguration.contexto());
		int cantidadPublicaciones = GetterUtil.getInteger(renderRequest.getPreferences().getValue(LinkedinPortletKeys.PARAM_CANTIDAD_PUBLICACIONES,
						String.valueOf(_linkedinConfiguration.cantidadPublicaciones())));

				 List<LinkedInPost> publicaciones = new ArrayList<>();
				 try {
					 _log.debug("themeDisplay.getPathImage(): " + themeDisplay.getPathImage());
					 _log.debug("themeDisplay.getPathJavaScript(): " + themeDisplay.getPathJavaScript());


					 String response = LinkedinPortletKeys.JSON_SIMULATION;
					 if(!simulation){
						 _log.debug("Inicio llamada para obtener publicaciones con organizationId: "+ organizationId + " token: " + token);
						 if ("curl".equalsIgnoreCase(modoPeticion)) {
							 response = obtenerPublicacionesDeLinkedInCURL(organizationId, token, cantidadPublicaciones);
							 _log.debug("Se hace la llamada por CURL");

						 } else {
							 response = obtenerPublicacionesDeLinkedIn(organizationId, token);
							 _log.debug("Se hace la llamada por Java");

						 }
						 _log.debug("Fin llamada para obtener publicaciones con organizationId: "+ organizationId + " token: " + token);
					 }
					 if (response == null || response.isEmpty()) {
						 _log.debug("La respuesta de LinkedIn es nula o vacía");
					 } else {
						 _log.debug("Respuesta cruda de LinkedIn: " + response);
					 }

					 JSONObject jsonResponse = JSONFactoryUtil.createJSONObject(response);
					 publicaciones = deserializacionPostLinkedin(jsonResponse.getJSONArray("elements"), contexto);

				 } catch (Exception e) {
					 e.printStackTrace();
					 _log.debug("Error al obtener publicaciones de LinkedIn: " + e.getMessage(), e);

				 } finally {
					 _log.debug("Finaliza la conexión con LinkedIn (éxito o error) ");
				 }

				  _log.debug("Num de publicaciones: " + publicaciones.size());
				 renderRequest.setAttribute("linkedinPosts", publicaciones);

				 super.doView(renderRequest, renderResponse);

			 }


	private List<LinkedInPost> deserializacionPostLinkedin(com.liferay.portal.kernel.json.JSONArray elements, String contexto) {
		List<LinkedInPost> publicaciones = new ArrayList<>();

		if (elements.length() > 0) {
			_log.debug("Procesando " + elements.length() + " elementos desde LinkedIn");

			for (int i = 0; i < elements.length(); i++) {
				try {
					com.liferay.portal.kernel.json.JSONObject post = elements.getJSONObject(i);
					_log.debug("JSON completo del post: " + post.toString());

					String text = "Sin texto";
					String postId = post.getString("id");
					String shareUrl = "";
					String imageUrl = "";
					long lastModifiedTimestamp = 0;

					//  UGC POST
					if (post.has("specificContent")) {
						com.liferay.portal.kernel.json.JSONObject shareContent =
								post.getJSONObject("specificContent").getJSONObject("com.linkedin.ugc.ShareContent");

						if (shareContent.has("shareCommentary")) {
							com.liferay.portal.kernel.json.JSONObject commentary = shareContent.getJSONObject("shareCommentary");
							if (commentary.has("text")) {
								text = commentary.getString("text");
							}
						}

						shareUrl = "https://www.linkedin.com/feed/update/" + postId;

						if (shareContent.has("media")) {
							com.liferay.portal.kernel.json.JSONArray mediaArray = shareContent.getJSONArray("media");
							if (mediaArray.length() > 0) {
								com.liferay.portal.kernel.json.JSONObject firstMedia = mediaArray.getJSONObject(0);
								if (firstMedia.has("thumbnails")) {
									com.liferay.portal.kernel.json.JSONArray thumbnails = firstMedia.getJSONArray("thumbnails");
									if (thumbnails.length() > 0 && thumbnails.getJSONObject(0).has("url")) {
										imageUrl = thumbnails.getJSONObject(0).getString("url");
									}
								} else if (firstMedia.has("originalUrl")) {
									imageUrl = firstMedia.getString("originalUrl");
								}
							}
						}

						if (post.has("lastModified")) {
							lastModifiedTimestamp = post.getJSONObject("lastModified").getLong("time");
						} else if (post.has("firstPublishedAt")) {
							lastModifiedTimestamp = post.getLong("firstPublishedAt");
						}

						//  SHARE POST
					} else if (post.has("text")) {
						com.liferay.portal.kernel.json.JSONObject textObj = post.getJSONObject("text");
						if (textObj.has("text")) {
							text = textObj.getString("text");
						}

						String activityId = post.getString("activity").replace("urn:li:activity:", "");
						shareUrl = "https://www.linkedin.com/feed/update/urn:li:activity:" + activityId;

						if (post.has("content")) {
							com.liferay.portal.kernel.json.JSONObject content = post.getJSONObject("content");
							if (content.has("contentEntities")) {
								com.liferay.portal.kernel.json.JSONArray contentEntities = content.getJSONArray("contentEntities");
								if (contentEntities.length() > 0) {
									com.liferay.portal.kernel.json.JSONObject firstEntity = contentEntities.getJSONObject(0);
									if (firstEntity.has("thumbnails")) {
										com.liferay.portal.kernel.json.JSONArray thumbnails = firstEntity.getJSONArray("thumbnails");
										if (thumbnails.length() > 0) {
											com.liferay.portal.kernel.json.JSONObject thumb = thumbnails.getJSONObject(0);
											if (thumb.has("resolvedUrl")) {
												imageUrl = thumb.getString("resolvedUrl");
											}
										}
									}
								}
							}
						}

						if (post.has("lastModified")) {
							lastModifiedTimestamp = post.getJSONObject("lastModified").getLong("time");
						}
					}

					// Limpieza del texto
					text = text.replaceAll("\\r\\n", "\n")
							.replaceAll("\\r", "\n")
							.replaceAll("\\u2028|\\u2029", "\n")
							.replaceAll("\\u00a0", "")
							.replaceAll("&nbsp", "");

					List<String> textParts = Arrays.asList(text.split("\n+"));

					if (Validator.isNull(imageUrl)) {
						imageUrl = (Validator.isNotNull(contexto) ? contexto : "") + "/o/redsys-theme/images/defaultImg.jpg";
					}

					_log.debug("############################# POST");
					_log.debug("postId: " + postId);
					_log.debug("textParts: " + textParts);
					_log.debug("imageUrl: " + imageUrl);
					_log.debug("shareUrl: " + shareUrl);
					_log.debug("lastModifiedTimestamp: " + lastModifiedTimestamp);

					LinkedInPost linkedInPost = new LinkedInPost(postId, textParts, imageUrl, 0, shareUrl, lastModifiedTimestamp);
					publicaciones.add(linkedInPost);

				} catch (Exception e) {
					_log.error("Error al procesar post de LinkedIn: ", e);
				}
			}
		}

		return publicaciones;
	}


	private boolean isWindows() {
		boolean output = false;
		String osName = System.getProperty("os.name");
		if (Validator.isNotNull(osName)
				&& osName.startsWith("Win")) {
			output = true;
		}
		return output;
	}

	private String obtenerPublicacionesDeLinkedInCURL(String organizationId, String token, int cantidadPublicaciones) throws IOException, JSONException {
		String output = "";
		String shellCmd1 = "C:/Windows/System32/cmd.exe";
		String shellCmd2 = "/c";
		if (!isWindows()) {
			shellCmd1 = "/bin/sh";
			shellCmd2 = "-c";
		}
		String[] cmd = {shellCmd1, shellCmd2, "curl -X GET \"https://api.linkedin.com/v2/ugcPosts?q=authors&authors=List(urn%3Ali%3Aorganization%3A" + organizationId
				+")&sortBy=LAST_MODIFIED&count=" + cantidadPublicaciones + "\" " +
				"-H \"X-Restli-Protocol-Version: 2.0.0\" " +
				"-H \"Authorization: Bearer " + token + "\""};
		Object[] response = shellExec(cmd);
		if (response != null) {
			int codeResponse = (int) response[1];
			if (codeResponse == 200) {
				output = (String) response[0];
			}
		}
		return output;
	}

	private static Object[] shellExec(String[] cmd) {
		Object[] output = null;
		try {
			final StringBuilder stringBuilder = new StringBuilder();
			_log.debug("exec command: " + String.join(StringPool.SPACE, cmd));
			final Process process = Runtime.getRuntime().exec(cmd);
			final BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line;
			while ((line = bufferedReader.readLine()) != null) {
				stringBuilder.append(line);
			}
			// prepare response
			if (stringBuilder.toString().startsWith("{")) {
				output = new Object[2];
				output[0] = stringBuilder.toString();
				output[1] = 200;
			}
		} catch (Exception e) {
			_log.error("cannot exec command: " + String.join(StringPool.SPACE, cmd));
		}
		return output;
	}


	private String obtenerPublicacionesDeLinkedIn(String organizationId, String token) throws IOException, JSONException {



		URL url = new URL("https://api.linkedin.com/v2/shares?q=owners&owners=urn:li:organization:" +organizationId);
		_log.debug("url: " + url);
		_log.debug("token: " + token);
		_log.debug("Antes de establecer conn ");

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		_log.debug("Despues de conn");

		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", "Bearer " + token);
		conn.setRequestProperty("Content-Type", "application/json");
        conn.setConnectTimeout(5000);
		conn.setReadTimeout(5000);

		_log.debug("Llamamos a conn.getResponseCode() ");
		int responseCode = conn.getResponseCode();
		_log.debug("Codigo respuesta: " + responseCode + ", Mensaje: " + conn.getResponseMessage());

		if (responseCode == 200) {
			_log.debug("responseCode: 200 ");
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			StringBuilder response = new StringBuilder();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			String resp = response.toString();
			_log.debug("respuesta: " + resp);
			return resp;
		}
		_log.debug("return null");
		return null;

	}
	private int obtenerReaccionesDePublicacion(String postId) throws IOException, JSONException {
		//URL url = new URL("https://api.linkedin.com/rest/reactions/(entity:urn:li:ugcPost:" + postId + ")");

		String urlString = "https://api.linkedin.com/rest/reactions/"
				+ "(entity:urn:li:activity:" + postId + ")?q=entity&sort=(value:REVERSE_CHRONOLOGICAL)";

		URL url = new URL(urlString);

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestProperty("Authorization", "Bearer " + _linkedinConfiguration.token());
		conn.setRequestProperty("Linkedin-Version", "202411");
		conn.setRequestProperty("X-Restli-Protocol-Version", "2.0.0");
		conn.setRequestProperty("Accept", "application/json");

		int responseCode = conn.getResponseCode();
		if (responseCode == 200) {
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			StringBuilder response = new StringBuilder();
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			JSONObject jsonResponse = JSONFactoryUtil.createJSONObject(response.toString());
			 _log.debug(jsonResponse);
			JSONArray reactions = jsonResponse.getJSONArray("elements");
			return reactions != null ? reactions.length() : 0;
		}
		return 0;
	}
	/*
	 * The method used to intantiate our configuration field
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
}