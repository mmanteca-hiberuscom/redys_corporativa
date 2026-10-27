<#--PLANTILLA DE BANNER 2 COLUMNAS (Landing, empleo e información corporativa) -->
<#-- ESTRUCTURA EST_BANNER_TWO_COLUMNS -->

<#assign classPK = .vars["reserved-article-id"].data />

<#assign isV2 = sectionGroup.optionalCard.getData()?has_content || getterUtil.getBoolean(sectionGroup.checkbox.getData()) />
<#assign altImg = "" />
<section class="two-columns${isV2?then(' two-columns-v2','')}">

    <#assign classFirst = "two-columns__container" />
    <#if isV2>
        <#assign classFirst = "two-columns__container-v2" />
    </#if>
		
	<#assign fileEntryId = "" />
    <div class="${classFirst} container">
        <#if mainTitle.getData()?has_content || mainDescription.getData()?has_content>
            <div class="two-columns__header" role="region" aria-labelledby="content-title-first-${classPK}">
                <#if mainTitle.getData()?has_content>
                    <h2 id="content-title-first-${classPK}" class="two-columns__header-title">
                        ${mainTitle.getData()}
                    </h2>
                </#if>

                <#if mainDescription.getData()?has_content>
                    <div aria-live="polite" class="two-columns__header-description">
                        ${mainDescription.getData()}
                    </div>
                </#if>
            </div>
        </#if>
        <#if sectionGroup.getSiblings()?has_content>
            <#list sectionGroup.getSiblings() as cur_sectionGroup>
						    <#assign styleCss="style=\"background-color: #FAB81E\"" />
                <#assign sideImg=(cur_sectionGroup.sideImage.getData()?? && cur_sectionGroup.sideImage.getData()?trim
                    !="" )?then(cur_sectionGroup.sideImage.getData()?trim, "right" ) />
                <#assign classSideContent="two-columns__" + sideImg + "-column" />
                <#assign classSideRow="two-columns__" + sideImg + "-row" />
								<#assign idRow = '' />
								<#if cur_sectionGroup.title.getData()?has_content && cur_sectionGroup.title.getData()?trim?has_content>
								   <#assign palabras = cur_sectionGroup.title.getData()?split(" ") />
									 <#assign palabraId = palabras[palabras?size-1] />
								   <#assign idRow = 'id="redsys-${cur_sectionGroup?index}-${palabraId?lower_case?replace("á", "a" )?replace("é", "e")?replace("í", "i")?replace("ó", "o")?replace("ú", "u")}"' /> 
								</#if>
                <div class="row ${classSideRow}" role="region" aria-label="title-${cur_sectionGroup?index}" aria-labelledby="title-${cur_sectionGroup?index}-${classPK}" ${idRow}>
                    <#if sideImg=="left">
                        <div class="col-xl-5 col-12">
                            <div class="two-columns__left-column">
														    <#if cur_sectionGroup.optionalCard.getData()?has_content && !(getterUtil.getBoolean(cur_sectionGroup.checkbox.getData()) && cur_sectionGroup.image.getData()?has_content) >
                                    <div class="two-columns__optional-card">
                                        ${cur_sectionGroup.optionalCard.getData()}
                                    </div>
                                </#if>
                                <#if cur_sectionGroup.image.getData()?has_content >
																   <#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_sectionGroup.image.getAttribute("title") />
                                   <#if cur_sectionGroup.image.getAttribute("alt")?has_content>
														       <#assign altImg = cur_sectionGroup.image.getAttribute("alt") />
														       </#if>
														       <#if cur_sectionGroup.image.getAttribute("fileEntryId")?has_content>
  																  <#assign fileEntryId = '${cur_sectionGroup.image.getAttribute("fileEntryId")}' />
																   </#if>
																	  <#assign urlImg= cur_sectionGroup.image.getData() />
																	  <div class="two-columns__image" role="img" aria-labelledby="image-desc-${fileEntryId}" aria-label="${altImg}" data-fileentryid="${fileEntryId}" style="background-image:url(${urlImg})">
																		      <span id="image-desc-${fileEntryId}" class="sr-only">${altImg}</span>
                                    </div>
                                </#if>
                                <#if getterUtil.getBoolean(cur_sectionGroup.checkbox.getData())>
																        <#if cur_sectionGroup.boxBackground.getData()?has_content>
																			     <#assign styleCss = "style=\"background-color: ${cur_sectionGroup.boxBackground.getData()}\"" />
    																    </#if>
                                        <div class="two-columns__optional-background" ${styleCss}></div>
                                </#if>
                            </div>
                        </div>
                    </#if>

                    <div class="col-xl-7 col-12">
                        <div class="${classSideContent}">
                            <div class="two-columns__card">
                                <div class="two-columns__content">
                                    <#if (cur_sectionGroup.title.getData())?? && cur_sectionGroup.title.getData()?trim
                                        !="">
                                        <h2 id="title-${cur_sectionGroup?index}-${classPK}" class="two-columns__content-title">
                                            ${cur_sectionGroup.title.getData()}
                                        </h2>
                                    </#if>
                                    <#if (cur_sectionGroup.description.getData())?? &&
                                        cur_sectionGroup.description.getData()?trim !="">
                                        <div aria-live="polite" class="two-columns__content-description">
                                            ${cur_sectionGroup.description.getData()}
                                        </div>
                                    </#if>
                                </div>
                                <#if cur_sectionGroup.linkUrl.getData()?has_content && cur_sectionGroup.linkLabel.getData()?has_content>

                                    <#assign textLabel="" />
                                    <#assign urlLink="${cur_sectionGroup.linkUrl.getData()}" />
                                    <#if (cur_sectionGroup.linkLabel.getData())??>
                                        <#assign textLabel="${cur_sectionGroup.linkLabel.getData()}" />
                                    </#if>
																	
                                    <div class="two-columns__content-btn">
                                        <a aria-label="${textLabel}" class="cta-btn-white"
                                            href="${urlLink}">
                                             ${textLabel}
                                        </a>
                                    </div>
                                </#if>
                            </div>
                        </div>
                    </div>

                    <#if sideImg=="right">
                        <div class="col-xl-5 col-12">
                            <div class="two-columns__right-column">
														    <#if cur_sectionGroup.optionalCard.getData()?has_content && !(getterUtil.getBoolean(cur_sectionGroup.checkbox.getData()) && cur_sectionGroup.image.getData()?has_content) >
                                    <div class="two-columns__optional-card">
                                        ${cur_sectionGroup.optionalCard.getData()}
                                    </div>
                                </#if>
                                <#if cur_sectionGroup.image.getData()?has_content >
														       <#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_sectionGroup.image.getAttribute("title") />
                                   <#if cur_sectionGroup.image.getAttribute("alt")?has_content>
														       <#assign altImg = cur_sectionGroup.image.getAttribute("alt") />
														       </#if>
														       <#if cur_sectionGroup.image.getAttribute("fileEntryId")?has_content>
  																  <#assign fileEntryId = '${cur_sectionGroup.image.getAttribute("fileEntryId")}' />
																   </#if>
																	 	  <div class="two-columns__image" role="img"   data-fileentryid="${fileEntryId}" aria-label="${altImg}" style="background-image:url(${cur_sectionGroup.image.getData()})">
																			    <span id="image-desc-${fileEntryId}" class="sr-only">${altImg}</span>
                                    </div>
                                </#if>
                                <#if getterUtil.getBoolean(cur_sectionGroup.checkbox.getData())>
																        <#if cur_sectionGroup.boxBackground.getData()?has_content>
																			     <#assign styleCss = "style=\"background-color: ${cur_sectionGroup.boxBackground.getData()}\"" />
    																    </#if>
                                        <div class="two-columns__optional-background" ${styleCss}></div>
                                </#if>
												
                            </div>
                        </div>
                    </#if>

                </div>
            </#list>
        </#if>
    </div>
</section>