<!-- TPL_NOTICIAS -->
<!-- estructura - EST_NOTICIAS -->

<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
<#assign AssetCategoryLocalService=serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService")>
<#assign categories=AssetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle", .vars["reserved-article-resource-prim-key"].data?number) />
<#assign categoriaNoticia=categories[0] />
        <#assign categoriaId = categoriaNoticia.name?replace(" ", "-")?lower_case />

<article class="news-card">
							
							<#assign altImg =imagen.getAttribute("title") />
                             <#if imagen.getAttribute("alt")?has_content>
                                <#assign altImg = imagen.getAttribute("alt") />
							</#if>
                            <img role="img" class="news-card-img" alt="altImg" 
                            data-fileentryid="${imagen.getAttribute("fileEntryId")}" src="${imagen.getData()}" />

                            <div class="news-card__body">
                                <h3 class="news-card__body-title">${titulo.getData()}</h3>
                                <p class="news-card__body-text">${resumen.getData()}</p>
                                <a href="${friendlyURL}" class="read-full" target="_blank" ><@liferay.language key='read-more' /> <i class="plus-icon"></i> </a>


                            </div>
                            <footer class="news-card__footer" role="contentinfo">
                                <p class="news-category">${categoriaNoticia.getTitle(locale)}</p>
                                <p class="news-date" >${redsysService.getDate(.vars["reserved-article-modified-date"].data)}</p>
                            </footer>
 </article>
