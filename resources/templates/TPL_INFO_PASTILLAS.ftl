<#-- TPL_INFO_PASTILLAS (Canal Ético, Empleo, Información Corporativa) -->
<#-- estructura - EST_INFO_PASTILLAS -->

<#assign headerTitle = "" />
<#assign descriptionText = "" />
<#assign numberOfPills = checkAllFieldsWithAnyAttribute(imagesGroup.getSiblings()) />
<#-- 
ELEMENTOS QUE DEBEN EXISTIR:
- Título
- Descripcion
- Número de pastillas seleccionado
- Al menos 1 pastilla
-->

   <#if (title.getData()?has_content || description.getData()?has_content) || ((numberOfImages.getData() == "three_images" || numberOfImages.getData() == "four_images") && numberOfPills gt 0)>
	 <section aria-labelledby="mosaic-title${.vars['reserved-article-id'].data}" class="cmp-image-mosaic">
    <div class="container">
        
		<#assign cssClassPrincipal="" />
		<#assign numImages = "" />
        <#if numberOfImages.getData()?has_content>
            <#assign numImages = numberOfImages.getData() />
			      <#assign cssClassPrincipal="image-mosaic--four" />
			      <#if numImages=="three_images">
				        <#assign cssClassPrincipal="image-mosaic--three" />
						</#if>
								  
			      
        </#if>
				
				<#if title.getData()?has_content || description.getData()?has_content>
                  <div class="row">
                     <div class="image-mosaic__header">
                        <#if title.getData()?has_content>
                          <#assign headerTitle = title.getData() />
													<#if description.getData()?has_content>
													<#assign titleClass = "image-mosaic__title" />
													<#else>
													<#assign titleClass = "image-mosaic__title--centered" />
													</#if>
                          <h2 class=${titleClass} id="mosaic-title${.vars['reserved-article-id'].data}">
                              ${headerTitle}
                          </h2>
                        </#if>
                        <#if description.getData()?has_content>
                          <#assign descriptionText = description.getData() />
                          <div class="image-mosaic__description">${descriptionText}</div>
                        </#if>
                    </div>
                  </div> 
									</#if>
        <#if numberOfPills gt 0>
				
        <div class="${cssClassPrincipal}" id="${cssClassPrincipal}${.vars['reserved-article-id'].data}">
            <div class="row">
                <#if imagesGroup.getSiblings()?has_content>
                    <#assign containerClass = "">
                    <#list imagesGroup.getSiblings() as item>
                        <#if cssClassPrincipal=="image-mosaic--three">
                            <#assign containerClass="col-12 col-lg-6 mb-3" />
                            <#if item?index==1>
                                <#assign containerClass="col-8 col-lg-4" />
                            <#elseif item?index==2>
                                <#assign containerClass="col-4 col-lg-2" />
                            </#if>
                        <#else>
                            <#assign containerClass = "col-6 col-lg-3 mb-3" />
                            <#if item?index==1 || item?index==2>
                                <#assign containerClass = "col-6 col-lg-3" />
                            </#if>
                        </#if>
                        <div class="${containerClass}">
                            <#assign imgBackgroundColor = "" />
                            <#if item.imgBackgroundColor.getData()?has_content>
                                <#assign imgBackgroundColor = item.imgBackgroundColor.getData() />
                                <#assign styleCss="style=\"background-color: ${imgBackgroundColor}\"" /> 
                            </#if>
                            <div class="image-mosaic__item" ${styleCss}>
                                <#assign inputText = "" />
                                <#if item.imgLabel.getData()??>
                                    <#assign inputText = item.imgLabel.getData() />
                                    <#assign imgFontColor = "" />
                                    <#if (item.imgFontColor.getData())??>
                                        <#assign imgFontColor = item.imgFontColor.getData() />
                                        <#assign styleColorCss="style=\"color: ${imgFontColor}\"" /> 
                                    </#if>
																	
                                    <#assign classImageCss= "" />
                                    <#if getterUtil.getBoolean(item.animationEffect.getData())>
                                        <#assign classImageCss="class=\"image-mosaic__arrow\"" />
                                    <#else>
                                        <#assign classImageCss="class=\"image-mosaic__image\"" />
                                    </#if>
                                    <#assign imgAlt="" /> 
                                    <#assign imgEntryId="" /> 
                                    <#assign imgSrc="" /> 
                                    <#if (item.img.getData())?? && item.img.getData() != "">
																		    <#assign imgAlt= languageUtil.get(locale, "img-auxiliar-alt") +" "+ item.img.getAttribute("title") /> 
																		    <#if item.img.getAttribute("alt")?has_content>
                                           <#assign imgAlt=item.img.getAttribute("alt") />   
																				</#if>
                                        <#assign imgEntryId=item.img.getAttribute("fileEntryId") /> 
                                        <#assign imgSrc=item.img.getData() />
																				
																					<span role="region" aria-label="${imgAlt}" class="image-mosaic__text" ${styleColorCss} >${inputText}
																		</span>
                                    
																				
                                        <#if classImageCss?contains("image-mosaic__image")>
                                            <div class="image-mosaic__image">
                                                <img alt="${imgAlt}" data-fileentryid="${imgEntryId}" src="${imgSrc}" />
                                            </div>
                                        <#else>
                                            <img ${classImageCss} alt="${imgAlt}" data-fileentryid="${imgEntryId}" src="${imgSrc}" />
                                        </#if>
																		<#else>
																		<span role="region" class="image-mosaic__text" ${styleColorCss} aria-label="${inputText}" >${inputText}
																		</span>
																		
                                    </#if>
                                </#if>														 
                            </div>
                        </div>
                    </#list>
                </#if>
            </div>
        </div>	
				</#if>
	</div> 
</section>

	 </#if>


<#function checkAllFieldsWithAnyAttribute elements>
    <#assign anyAttributeCount = 0 />
		<#list elements as element>
        <#if element.img.getData()?has_content || element.imgLabel.getData()?has_content>
            <#assign anyAttributeCount += 1 />
        </#if>
    </#list>
    <#return anyAttributeCount />
</#function>