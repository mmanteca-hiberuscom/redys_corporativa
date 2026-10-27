<!-- ADT_LISTADO_FAQS -->

<#assign
	redsysService = serviceLocator.findService("com.redsys.service.ResysServiceImpl")
/>

<#if !entries?has_content>
		<#if !themeDisplay.isSignedIn()>
			${renderRequest.setAttribute("PORTLET_CONFIGURATOR_VISIBILITY", true)}
		</#if>

		<div class="alert alert-info">
			<@liferay_ui["message"] key="there-are-no-results" />
		</div>
	</#if>
	<div class="container-faqs container">
  <div class="row">
			<div class="col-12 col-md-12">
	<#list entries as entry>
		<#assign
			entry = entry

			assetRenderer = entry.getAssetRenderer()

			entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale))

			viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, entry, !stringUtil.equals(assetLinkBehavior, "showFullContent"))
		/>
					<h2 class="faqs-subtitle">
							        			      ${redsysService.getFieldByReference(entry,"titulo",locale)}
		</h2>
		<div class="accordion" id="faqAccordion${entry.entryId}">
						<@liferay_asset["asset-display"] assetEntry=entry />
		</div>

	</#list>
		</div>
	</div>
</div>