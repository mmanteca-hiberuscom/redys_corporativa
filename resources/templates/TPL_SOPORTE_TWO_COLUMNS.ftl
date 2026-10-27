<#-- TPL_SOPORTE_TWO_COLUMNS (Soporte a Comercios) -->
<#-- estructura - EST_SOPORTE_TWO_COLUMNS -->
    <#assign AssetEntryLocalServiceUtil = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
    <#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
    <#assign idGlobal=0 />
    <#assign dinamicId=.vars["reserved-article-id"].data />
    <#assign activeTabsContent=0 />
		<#assign numberOfComponentsInPage = 0 />
    <#assign numberOfTab=0 />
		
        <#if supportInfoGroup.getSiblings()?has_content>
            <#list supportInfoGroup.getSiblings() as currentSupportInfoGroup>
                <#assign classContent="tab-panel-support right-tabs" />
                <#assign currentIndex=currentSupportInfoGroup_index />
                <#if currentIndex%2==0>
                    <#assign classContent="tab-panel-support" />
                </#if>
                <section class="${classContent}">
                    <div class="tab-panel-support__container container" aria-labelledby="tab-panel-title">
                        <div class="row tab-panel-support__main-row">
                            <div class="col-12 col-xl-4 tab-panel-support__column-left">
                                    <#assign imgSupportAlt="" />
                                    <#assign imgSupportSrc="" />
                                    <#if currentSupportInfoGroup.imgSupport.getData()?has_content>
																		    <#assign imgSupportAlt = languageUtil.get(locale, "img-auxiliar-alt") +" "+ currentSupportInfoGroup.imgSupport.getAttribute("title") />
                                        <#if currentSupportInfoGroup.imgSupport.getAttribute("alt")?has_content && currentSupportInfoGroup.imgSupport.getAttribute("alt")?trim?has_content>
                                            <#assign imgSupportAlt=currentSupportInfoGroup.imgSupport.getAttribute("alt") />
                                        </#if>
                                        <#assign imgSupportSrc=currentSupportInfoGroup.imgSupport.getData() />
																				<div class="tab-panel-support__image-wrapper" aria-hidden="true">
                                           <img src="${imgSupportSrc}" alt="${imgSupportAlt}" class="tab-panel-support__image">
                                        </div>
                                    </#if>
                                    <#assign webContentData=jsonFactoryUtil.createJSONObject(currentSupportInfoGroup.supportDataArticle.getData()) />
                                    <#if webContentData?? && webContentData.title??>
																				
																				  
                                          <div class="tab-panel-support__card card">
																				    
																				    <#if redsysService.getFieldByReference(webContentData.classPK,"infoTitle",locale)?has_content && redsysService.getFieldByReference(webContentData.classPK,"infoTitle",locale)?trim?has_content>
																						   <#assign infoTitleLabel = redsysService.getFieldByReference(webContentData.classPK,"infoTitle",locale) />
                                               <h2 class="tab-panel-support__card-title">
                                                   ${infoTitleLabel}
                                               </h2>
																						</#if>
																					<#if (redsysService.getFieldByReference(webContentData.classPK,"leftLinkURL",locale)?trim?has_content &&
																					redsysService.getFieldByReference(webContentData.classPK,"leftLinkLabel",locale)?trim?has_content) ||
																					 (redsysService.getFieldByReference(webContentData.classPK,"rightLinkURL",locale)?trim?has_content &&
																					 redsysService.getFieldByReference(webContentData.classPK,"rightLinkLabel",locale)?trim?has_content) >
                                            <div class="tab-panel-support__card-buttons">
																						    <#if redsysService.getFieldByReference(webContentData.classPK,"leftLinkURL",locale)?trim?has_content &&
																					       redsysService.getFieldByReference(webContentData.classPK,"leftLinkLabel",locale)?trim?has_content>
                                                <#assign jsonResponse = redsysService.getFieldByReference(webContentData.classPK, "leftLinkURL", locale)?eval /> 
																								<#assign cleanUrl = jsonResponse.url?split("?")[0] />
																								<a href="${cleanUrl}"
                                                    target="_blank" 
																										class="cta-btn-orange" aria-label="${redsysService.getFieldByReference(webContentData.classPK,"leftLinkLabel",locale)}">
                                                    ${redsysService.getFieldByReference(webContentData.classPK,"leftLinkLabel",locale)}
                                                </a>
																						    </#if>
																								<#if redsysService.getFieldByReference(webContentData.classPK,"rightLinkURL",locale)?trim?has_content &&
																					           redsysService.getFieldByReference(webContentData.classPK,"rightLinkLabel",locale)?trim?has_content>
																					      <#assign jsonResponse = redsysService.getFieldByReference(webContentData.classPK, "rightLinkURL", locale)?eval />
																								<#assign cleanUrl = jsonResponse.url?split("?")[0] />
																								<a href="${cleanUrl}"
                                                    target="_blank" 
                                                    class="cta-btn-orange" aria-label="${redsysService.getFieldByReference(webContentData.classPK,"rightLinkLabel",locale)}">
                                                    ${redsysService.getFieldByReference(webContentData.classPK,"rightLinkLabel",locale)}
                                                </a>
																						</#if>
                                            </div>
																						</#if>
																						<#if redsysService.getFieldByReference(webContentData.classPK,"phoneLabel",locale)?has_content &&
																						redsysService.getFieldByReference(webContentData.classPK,"phoneLabel",locale)?trim?has_content>
                                               <#assign phoneNumber = redsysService.getFieldByReference(webContentData.classPK,"phoneLabel",locale) />
																							 <#assign cleanNumber = phoneNumber?replace("+", "")?replace(" ", "") />

																							 <#assign iconWhatsapp = redsysService.getFieldByReference(webContentData.classPK,"iconLabel",locale) />
																							 <#assign cleanIcon = iconWhatsapp?replace("<p>", "")?replace("</p>", "") />

																						<div class="tab-panel-support__card-text">
																				
                                                
																								<p>
																										${cleanIcon } <a href="https://wa.me/${cleanNumber}" target="_blank">
                                                        ${phoneNumber} 
                                                    </a>  
                                                </p>
																								
                                            </div>
																						</#if>
                                        </div>
                            </div>
        </#if>
        <div class="col-12 col-xl-8 tab-panel-support__column-right">
             <div class="tab-panel-support__tabs-card card">
                  <div class="card-body">
                       <#assign groupTitleLabel="" />
                       <#if (currentSupportInfoGroup.titleSupport.getData())??>
                            <#assign groupTitleLabel=currentSupportInfoGroup.titleSupport.getData() />
                       </#if>
                       <h2 class="tab-panel-support__tabs-title">
                           ${groupTitleLabel}
                       </h2>
                       <#-- LA LISTA QUE CORRESPONDE A LA CABECERA DEL TABS SE CREA DINÁMICAMENTE CON UNA MACRO -->
                       <#if currentSupportInfoGroup.tabsColumn.getSiblings()?has_content>
                            <@createTabHeader currentSupportInfoGroup.tabsColumn />
                       </#if>
                       <div class="tab-content tab-panel-support__tab-content" id="supportTabsContent${activeTabsContent}">
                            <#assign activeTabsContent += 1 />
														<#if currentSupportInfoGroup.tabsColumn.getSiblings()?has_content>
                                 <#list currentSupportInfoGroup.tabsColumn.getSiblings() as currentItem>
                                        <#assign tabPaneClass="tab-pane fade show active" />
                                        <#if currentItem_index gt 0>
                                             <#assign tabPaneClass="tab-pane fade" />
                                        </#if>
                                        <#if (currentItem.tabsOptionContentType.getData())??>
                                             <div class="${tabPaneClass}" id="tab${numberOfTab}" role="tabpanel" aria-labelledby="tab${numberOfTab}-tab">
                                                  <#assign numberOfTab +=1 />
                                                  <#if currentItem.tabsOptionContentType.getData()=="riched-text">
                                                       <section class="tab-panel-support__rich-text">
                                                                <div class="tab-panel-support__description">
                                                                   <#if (currentItem.tabsOptionOneRichedContent.getData())??>
                                                                        ${currentItem.tabsOptionOneRichedContent.getData()}
                                                                   </#if>
                                                                </div>
                                                        </section>
                                                  <#elseif currentItem.tabsOptionContentType.getData()=="web-content">
																									<#assign
	                                                   webContentData = jsonFactoryUtil.createJSONObject(currentItem.tabDataArticle.getData())
                                                  />
																									<#assign assetEntry = AssetEntryLocalServiceUtil.getEntry("com.liferay.journal.model.JournalArticle", webContentData.classPK?number) />
                                                  <@liferay_asset["asset-display"] assetEntry=assetEntry />
																									<#else>
																									<#-- CASO DE CONTENIDO VACIO: EL CONTENIDO ESTÁ VACÍO. -->
																				             <p><@liferay.language key="support-content-empty-error" /></p>
																									</#if>
                                                </div>
                                            </#if>
                                        </#list>
                                    </#if>
                                </div>
                        </div>
                    </div>
                </div>
           </div>
        </section>
    </#list>
  </#if>
<#macro createTabHeader Tab>
<ul role="tablist" class="nav nav-tabs" id="supportTabs${numberOfComponentsInPage}" role="tablist">
<#assign numberOfComponentsInPage += 1 />
<#if Tab.getSiblings()?has_content>
	<#list Tab.getSiblings() as currentTabElement>
	<#assign currentTabElementIndex = currentTabElement_index />
	<#assign currentTabElementTitle = "" />
	<#assign liClass = "tab-panel-support__nav-item" />
	<#assign aClass = "nav-link active" />
	<#if currentTabElementIndex gt 0 >
	   <#assign liClass = "nav-item" />
		 <#assign aClass = "nav-link" />
	</#if>
	<#if currentTabElement.tabsOptionTitle.getData()?has_content && currentTabElement.tabsOptionTitle.getData()?trim?has_content>
	   <#assign currentTabElementTitle = currentTabElement.tabsOptionTitle.getData() />	 
	   <li role="presentation" class="${liClass}">
        <a role="tab" class="${aClass}" id="tab${idGlobal}-tab" data-toggle="tab" href="#tab${idGlobal}" role="tab" aria-controls="tab${idGlobal}" aria-selected="true">${currentTabElementTitle}</a>
     </li>
	   <#assign idGlobal += 1 />
  </#if>
		
	</#list>
</#if>
</ul> 

</#macro>