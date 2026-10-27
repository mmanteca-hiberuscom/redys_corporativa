<#if !entries?has_content>
		<#if !themeDisplay.isSignedIn()>
			${renderRequest.setAttribute("PORTLET_CONFIGURATOR_VISIBILITY", true)}
		</#if>

		<div class="alert alert-info">
			<@liferay_ui["message"] key="there-are-no-results" />
		</div>
	</#if>
	<#list entries as entry>
		<#assign
			entry = entry

			assetRenderer = entry.getAssetRenderer()

			entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale))

			viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, assetRenderer, entry, !stringUtil.equals(assetLinkBehavior, "showFullContent"))
		/>
		<#assign renderer = entry.getAssetRenderer() />
        <#assign journalArticle = renderer.getArticle() />
		<#assign tpl_noticias = "TPL_NOTICIAS">
         <#if orderByColumn1 == "priority" || orderByColumn1 == "title">
            <#assign tpl_noticias = "TPL_NOTICIAS_PRIORITY">
         <#else>
            <#assign tpl_noticias = "TPL_NOTICIAS_LAST">
         </#if>


	 <div id="noticia${entry.entryId}" class="${(entry?index % 2 == 0)?string('news news__right', 'news news__left')}">
<@liferay_journal["journal-article"]
            articleId=journalArticle.getArticleId()
            ddmTemplateKey=tpl_noticias
            groupId=journalArticle.getGroupId() />
    </div>

	</#list>