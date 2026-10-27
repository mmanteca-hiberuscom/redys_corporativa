<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
<#assign
	AssetCategoryLocalService=serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService")>
	<#assign categories=AssetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle",
		.vars["reserved-article-resource-prim-key"].data?number) />

   <section class="news-section container">
        <div class="news__container ">
            <div class="row news__row">
                <div class="col-xl-6 col-12">
                    <div class="news__right-column">
                        <div class="news__card">
                            <#if (titulo.getData())??>
                                <h3 class="news__card-title">${titulo.getData()}</h3>
                            </#if>
                            <#if resumen.getData()?has_content>
                                <div aria-live="polite" class="news__card-description">
                                     <p>${resumen.getData()}</p>
                                </div>
                            </#if>
                        </div>
                        <div class="news__card-footer">
                            <a class="cta-btn-white"  target="_blank" aria-label="<@liferay.language key="read-full-news" />"
                            class="cta-btn-white" href="${friendlyURL}">
                            <@liferay.language key="read-full-news" />
                            </a>
                            <#if categories?? && categories?has_content>
                                <#assign categoriaNoticia=categories[0] />
                                <div class="news__content-right">
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

                <div class="col-xl-6 col-12">
                    <div class="news__left-column">
                        <#if (imagen.getData())?? && imagen.getData() !="">
                            <img  class="two-columns__image"  alt="${imagen.getAttribute("alt")}" data-fileentryid="${imagen.getAttribute("fileEntryId")}" src="${imagen.getData()}" />
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </section>