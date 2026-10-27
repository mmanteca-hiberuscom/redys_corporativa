<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
<#assign
	AssetCategoryLocalService=serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService")>
	<#assign categories=AssetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle",
		.vars["reserved-article-resource-prim-key"].data?number) />

<section class="two-columns news-last">
    <div class="two-columns__container container">
		      <#assign tituloAria = languageUtil.get(locale, "news-category") />
		      <#if (titulo.getData())??>
             <#assign tituloAria = titulo.getData() />
          </#if>
		      <div class="row two-columns__left-row" role="region" aria-label="${tituloAria}" >
					     <div class="col-xl-5 col-12">
							      <div class="two-columns__left-column two-columns__left-column-desktop">
							 
						            	 <#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + imagenDesktop.getAttribute("title")  />
										       <#if imagenDesktop.getAttribute("alt")?trim?has_content>
										         <#assign altImg = imagenDesktop.getAttribute("alt") />
										       </#if>

										       <#if (imagen.getData())?? && imagen.getData() != "">
										         <img class="two-columns__image" alt="${altImg}" data-fileentryid="${imagenDesktop.getAttribute("fileEntryId")}" src="${imagenDesktop.getData()}" />
										       </#if>
							 
										 </div>
										 
                     <div class="two-columns__left-column two-columns__left-column-tablet">
										 
										 <#assign altImgTablet = languageUtil.get(locale, "img-auxiliar-alt") + " " + imagenDesktop.getAttribute("title") />
										       <#if imagen.getAttribute("alt")?trim?has_content>
 										        <#assign altImgTablet = imagen.getAttribute("alt") />
										       </#if>

										       <#if (imagen.getData())?? && imagen.getData() != "">
 										        <img class="two-columns__image" alt="${altImgTablet}" data-fileentryid="${imagen.getAttribute("fileEntryId")}" src="${imagen.getData()}" />
										       </#if>
										 </div>
                     
		           </div>
							 <div class="col-xl-7 col-12">
                    <div class="two-columns__left-column">
                         <div class="two-columns__card">
                              <div class="two-columns__content">
															<#if (titulo.getData())??>
                                  <h3 class="two-columns__content-title">${titulo.getData()}</h3>
                              </#if>
                              <#if resumen.getData()?has_content>
                                <div aria-live="polite" class="two-columns__content-description">
                                     <p>${resumen.getData()}</p>
                                </div>
                              </#if>
												  </div>
													<div class="two-columns__content-footer">
                                    <a class="cta-btn-white"  target="_blank" aria-label="<@liferay.language key="read-full-news" />" class="cta-btn-white" href="${friendlyURL}">
                                        <@liferay.language key="read-full-news" />
                                    </a>
                                   <#if categories?? && categories?has_content>
                                       <#assign categoriaNoticia=categories[0] />
                                    <div class=" two-columns__content-rigth" >
                                       <p class="news-category">${categoriaNoticia.getTitle(locale)}</p>
		<#assign showDateRedsys_Data = getterUtil.getString(showDateRedsys.getData())>

<#if validator.isNotNull(showDateRedsys_Data)>
	<#assign showDateRedsys_DateObj = dateUtil.parseDate("yyyy-MM-dd", showDateRedsys_Data, locale)>
<p class="news-date" >
	${dateUtil.getDate(showDateRedsys_DateObj, "dd/MM/yyyy", locale)} </p>
</#if>							


                                    </div>
                                 </#if>
															</div>
										</div>
							</div>
					</div>
		</div>
</section>
