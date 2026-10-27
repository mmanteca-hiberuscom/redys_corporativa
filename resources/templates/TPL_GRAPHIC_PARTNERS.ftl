<#-- TPL_GRAPHIC_PARTNERS (Información Corporativa) -->
<#-- estructura - EST_GRAPHIC_PARTNERS -->
<#assign headerTitle="" />
<#assign descriptionLeftText="" />
<#assign descriptionRightText="" />

<#-- SI NO SE CONTRIBUYE NADA, NO APARECE NADA. -->
<#-- LAS IDS, DE EXISTIR, DEBEN TENER LA ID DEL ARTÍCULO -->
<#-- NO PUEDEN EXISTIR ETIQUETAS A SIN HREF, NI IMGS SIN ATRIBUTO ALT -->


<#assign numberOfPartners = checkAllFieldsNonEmpty(groupPartners.getSiblings()) />
<#if numberOfPartners gt 0 && title.getData()?has_content && (labelLeft.getData()?has_content || labelRight.getData()?has_content) >

<section class="partners">
  
	<div class="container">
	
		<#if title.getData()?has_content>
		  <#assign headerTitle=title.getData() />
			<h2 class="partners__title text-left">
				${headerTitle}
			</h2>
		</#if>
		<#if labelLeft.getData()?has_content || labelRight.getData()?has_content>
		<div class="partners__header">
			<#if labelLeft.getData()?has_content>
			  <#assign descriptionLeftText=labelLeft.getData() />
				<div class="partners__description">
					${descriptionLeftText}
				</div>
			</#if>
			<#if labelRight.getData()?has_content>
			  <#assign descriptionRightText=labelRight.getData() />
				<div class="partners__text">
					${descriptionRightText}
				</div>
			</#if>
		</div>
		</#if>
		<#if numberOfPartners gt 0>
		<div class="partners__content">
		<#--AQUÍ, SE COMPRUEBA EL LADO. PODEMOS HACERLO CON UNA MACRO-->
		<#assign elementOrderValue = "">
		<@cargarContenidosColumnas/>
		</div>
		</#if>
	</div>
</section>
</#if>

<#macro cargarContenidosColumnas>
		<@mostrarInfo />
		<@mostrarDetalles />
</#macro>

<#macro mostrarInfo>
<#if imgGraphs.imageDesktop.getData()?has_content && imgGraphs.imageTablet.getData()?has_content && imgGraphs.imageMobile.getData()?has_content>
<div class="partners__info">
	<div class="partners__graphic">
		<#assign imgGraphsAlt="" />
		<#assign imgGraphsUrl="" />
			<#assign imgGraphsAlt = languageUtil.get(locale, "img-auxiliar-alt") +" "+ imgGraphs.imageDesktop.getAttribute("title") />
			<#if imgGraphs.imageDesktop.getAttribute("alt")?has_content>
				<#assign imgGraphsAlt=imgGraphs.imageDesktop.getAttribute("alt") />
			</#if>
			<#assign imgGraphsUrl=imgGraphs.imageDesktop.getData() />
			<picture>
				<source 
					srcset="${imgGraphs.imageMobile.getData()}" 
					media="(max-width: 576px)" 
					data-fileentryid="${imgGraphs.imageMobile.getAttribute("fileEntryId")!}" />

				<source 
					srcset="${imgGraphs.imageTablet.getData()}" 
					media="(max-width: 1200px)" 
					data-fileentryid="${imgGraphs.imageTablet.getAttribute("fileEntryId")!}" />

				<img 
					class="partners__image"
					src="${imgGraphs.imageDesktop.getData()}" 
					alt="${imgGraphs.imageDesktop.getAttribute("alt")!imgGraphs.imageDesktop.getAttribute("title")!imgGraphs.imageDesktop.getAttribute("fileName")!"Imagen desktop"}" 
					data-fileentryid="${imgGraphs.imageDesktop.getAttribute("fileEntryId")!}" />
			</picture>
	</div>
</div>
</#if>
</#macro>
<#macro mostrarDetalles>
    <#assign result = checkAllFieldsNonEmpty(groupPartners.getSiblings()) />
    <#if groupPartners.getSiblings()?has_content && result gt 0>
    <div class="partners__details">
        
            <ul class="partners__list" role="list">
                <#list groupPartners.getSiblings() as currentPartner>
								    <#if currentPartner.partnerColor.getData()?has_content && currentPartner.partnerName.getData()?has_content && currentPartner.partnerValue.getData()?has_content>
                    <#assign partnerColor= "" />
                    <#if currentPartner.partnerColor.getData()?has_content>
                        <#assign partnerColor=currentPartner.partnerColor.getData() />
                    </#if>
                    <#assign partnerName= "" />
                    <#if currentPartner.partnerName.getData()?has_content>
                        <#assign partnerName=currentPartner.partnerName.getData() />
                    </#if>
                    <#assign partnerValue= 0 />
                    <#if currentPartner.partnerValue.getData()?has_content>
                        <#assign partnerValue = currentPartner.partnerValue.getData()?replace(",", ".")?number?string("0.0")?replace(",", ".") />
                    </#if>
                    <#assign partnerColorStyle= "" />
                    <#if partnerColor?length gt 0>
                        <#assign partnerColorStyle="style=\" background-color: ${partnerColor};\"" />
                    </#if>
                    <li class="partners__item" role="listitem">
                        <span class="partners__color" ${partnerColorStyle}></span>
                        <div class="partners__data">
                            <span class="partners__name">
                                <#if partnerName?length gt 0>
                                    ${partnerName}
                                </#if>
                            </span>
                            <#if partnerValue != "0.0"> 
                                <span class="partners__percentage">
                                    ${partnerValue}%
                                </span>
                            </#if>
                        </div>
                    </li>
					</#if>
                </#list>
            </ul>
				<#assign externalURL = "" />
        <#if fullListURL.getData()?has_content>
				   <#assign externalURL = "${fullListURL.getData()}" />
        </#if>
				<#if externalURL?has_content>
				   <a class="cta-btn-white" aria-label="${textLabel.getData()}" href="${externalURL}" target="_blank">
            ${textLabel.getData()}
        </a>
        </a>
				</#if>
        
    </div>
		</#if>
</#macro>

<#function checkAllFieldsNonEmpty elements>
    <#assign fullAttributeCount = 0 />
		<#list elements as element>
        <#if element.partnerName.getData()?has_content && element.partnerColor.getData()?has_content && element.partnerValue.getData()?has_content>
            <#assign fullAttributeCount += 1 />
        </#if>
    </#list>
    <#return fullAttributeCount />
</#function>