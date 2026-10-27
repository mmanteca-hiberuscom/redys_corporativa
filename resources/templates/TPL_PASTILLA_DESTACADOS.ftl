<#-- TPL_PASTILLA_DESTACADOS (Landing) -->
<#-- estructura - EST_PASTILLA_DESTACADOS -->

<#assign headerTitle = "" />
<#assign descriptionText = "" />

<section aria-label='<@liferay.language key="redsys-highlight-numbers" />' class="animate-assets">
	<div class="animate-assets-container container">
		<#if titulo.getData()?trim?has_content>
			<#assign headerTitle = titulo.getData() />
			<h2 class="animate-assets__title">${headerTitle}</h2>
		</#if>
		<#assign descriptionId="id=\"dynamicText${.vars['reserved-article-id'].data}\"" />
		<#if descripcion.getData()?trim?has_content>
			<#assign descriptionText = descripcion.getData() />
            <div aria-live="polite" class="animate-assets__description" ${descriptionId}>
                ${descriptionText}
            </div>
        </#if>
		<#assign siblings = "" />
        <#assign total = "" />
        <#assign totalGroups = "" />
		
		<#if grupoPastillas.getSiblings()?has_content>
			<#assign siblings = grupoPastillas.getSiblings() />
			<div class="row" role="list">
				<#list siblings as item>
					<#assign pillTitle = "" />
					<#assign pillSubtitle = "" />
					<#assign hasHoverEffect = "" />
					<#assign pillBorderColor = "" />
					<#assign pillBackgroundColor = "" />
					<#assign videoFile = "" />
					
					<#if item.tituloPastilla.getData()?trim?has_content>
						<#assign pillTitle = item.tituloPastilla.getData() />
					</#if>
					<#if item.subtituloPastilla.getData()?trim?has_content>
						<#assign pillSubtitle = item.subtituloPastilla.getData() />
					</#if>
					<#if item.efectoHover.getData()?trim?has_content>
						<#assign hasHoverEffect = item.efectoHover.getData() />
					</#if>
					<#if item.colorBordePastilla.getData()?trim?has_content>
						<#assign pillBorderColor = item.colorBordePastilla.getData() />
					</#if>
					<#if item.bordePastilla.getData()?trim?has_content>
						<#assign hasBorderColor = item.bordePastilla.getData() />
					</#if>
					<#if item.fondoPastilla.getData()?trim?has_content>
						<#assign pillBackgroundColor = item.fondoPastilla.getData() />
					</#if>
					<#if item.videoEfectoHover.getData()?trim?has_content>
						<#assign videoFile = item.videoEfectoHover.getData() />
						<#assign lastSlashPos = videoFile?last_index_of("/") />
						<#assign penultimateSlashPos = videoFile?substring(0, lastSlashPos)?last_index_of("/") />
						<#assign fileNameWithExtension = videoFile?substring(penultimateSlashPos + 1, lastSlashPos) />
						<#assign fileName = fileNameWithExtension?substring(0, fileNameWithExtension?last_index_of(".")) />
						<#assign fileExtension = fileNameWithExtension?substring(fileNameWithExtension?last_index_of(".") + 1) />
						<#assign videoExtensions = "mp4,avi,mov,wmv,flv,mkv,webm,mpg,mpeg,3gp,m4v,ogv,vob,f4v" />
					</#if>

					<#assign pillContent = "" />
					<#assign ariaLabelPill='aria-label=\"${pillTitle} ${pillSubtitle}\"' />
					<#assign cssPillClassStyle = "" />
					<#assign cssPillBackgroundStyle = "" />
					<#assign cssPillBorderStyle = "" />
					
					<#if pillBackgroundColor?has_content && pillBackgroundColor?trim?has_content>
						<#assign cssPillBackgroundStyle = 'style=\"background-color:${pillBackgroundColor}\"' />
					</#if>
					<#if hasBorderColor=="border-solid" && pillBorderColor?has_content && pillBorderColor?trim?has_content>
						<#assign cssPillBorderStyle = 'style=\"border-color:${pillBorderColor}\"' />
					</#if>
					<#if hasHoverEffect=="hover-true">
						<#assign cssPillClassStyle='class=\"animate-assets__card animate-assets__card--video\" ${cssPillBackgroundStyle}'  />
						<#if videoFile?has_content && videoExtensions?index_of(fileExtension) != -1>
						<#assign pillContent = '<video aria-label="${fileName}" autoplay="" loop="" muted="" src="${videoFile}">&nbsp;</video>' />
						</#if>
						<#if item.imagenEfectoHover.getData()?trim?has_content>
						<#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") +" "+ item.imagenEfectoHover.getAttribute("title") />
							<#if item.imagenEfectoHover.getAttribute("alt")?trim?has_content>
							<#assign altImg = item.imagenEfectoHover.getAttribute("alt") />
							</#if>
						<#assign pillContent = '<img alt="${altImg}" data-fileentryid="${item.imagenEfectoHover.getAttribute(\"fileEntryId\")}" src="${item.imagenEfectoHover.getData()}" />' />
						</#if>
					<#elseif hasHoverEffect=="hover-false" && hasBorderColor=="border-solid">
						<#assign cssPillClassStyle = 'class=\"animate-assets__card animate-assets__border\" ${cssPillBorderStyle}' />
					<#else>
						<#assign cssPillClassStyle = 'class=\"animate-assets__card\"' />
					</#if>

					<#if pillTitle?has_content && pillTitle?trim?has_content >
						<div ${ariaLabelPill} class="col-12 col-lg-6 col-xl-4" role="listitem">
							<div ${cssPillClassStyle} >
								${pillContent}
								<p class="animate-assets__number">
									${pillTitle}
								</p>
								<div class="animate-assets__text">
									${pillSubtitle}
								</div>
							</div>
						</div>  
					</#if>
				</#list>
			</div>
		</#if>

		<#assign linkHREF = "href=" />
		<#assign linkText = "" />
		<#if linkURL.getData()?trim?has_content>
			<#assign linkHREF += linkURL.getData() />
			<#assign linkCSS = "cta-btn-orange" />
		<#else>
			<#assign linkCSS = "btn btn-link" />
		</#if>
		<#if linkLabel.getData()?trim?has_content>
			<#assign linkText = linkLabel.getData() />
		</#if>
		
    	<#if linkText?has_content & linkCSS == "cta-btn-orange">
			<div class="content-btn">
				<a aria-label='<@liferay.language key="go-to-more-activities" />' class="${linkCSS}" ${linkHREF} >
					${linkText}
				</a>
			</div>
		</#if>
    </div>
</section> 