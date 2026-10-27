<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
<#assign
	AssetCategoryLocalService=serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService")>
	<#assign categories=AssetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle",
		.vars["reserved-article-resource-prim-key"].data?number) />
		
<!--<#if (imagen.getData())?? && imagen.getData() != "">
<figure class="news-image">
	<img alt="${imagen.getAttribute("alt")}" data-fileentryid="${imagen.getAttribute("fileEntryId")}" src="${imagen.getData()}" />
</figure>
</#if>

		<#if (imagen.getData())?? && imagen.getData() != "">
	<img class="imgtop1" alt="${imagen.getAttribute("alt")}" data-fileentryid="${imagen.getAttribute("fileEntryId")}" src="${imagen.getData()}" />
</#if>-->
		
  <article class="news-detail">
        <!-- Encabezado de la noticia -->
        <header class="news-header">
				    <#if imagen.getData()?has_content>
            <figure class="news-image">
                
            </figure>
						</#if>
						<#if categories?? && categories?has_content>
                                <#assign categoriaNoticia=categories[0] />
            <div class="news-meta" >
                <p class="news-category">${categoriaNoticia.getTitle(locale)}</p>
								
								<#assign showDateRedsys_Data = getterUtil.getString(showDateRedsys.getData())>

<#if validator.isNotNull(showDateRedsys_Data)>
	<#assign showDateRedsys_DateObj = dateUtil.parseDate("yyyy-MM-dd", showDateRedsys_Data, locale)>
	<p class="news-date">
	 ${dateUtil.getDate(showDateRedsys_DateObj, "dd/MM/yyyy", locale)} </p>
</#if>
            </div>
						</#if>
        </header>

        <!-- Contenido principal de la noticia -->
        <section class="news-content">
				    <#if titulo.getData()?has_content>
	          <h1 class="new-tile">${titulo.getData()}</h1>
            </#if>
						<#if resumen.getData()?has_content>
	           <h2 class="new-subtitle"> ${resumen.getData()} </h2>
            </#if>
						<#if comment1.getData()?has_content>
	               ${comment1.getData()}
            </#if>
        </section>

        <!-- Cita destacada -->
        <#if grupoCard.getSiblings()?has_content>
	         <#list grupoCard.getSiblings() as cur_card>
					 <#assign sideCard = (cur_card.sideCard.getData()?trim == "right")?then("news-row__right", "")>
		       <#assign activeImage = (cur_card.activeImageCard.getData()?trim! "")>
					 <#-- ESTE BLOQUE APARECE SI: -->
					 <#-- se contribuyen, juntos, los siguientes elementos:
					      Grupo 1 - Card con imagen en lateral y texto:
								- sideText
								- sideCard
								- activeImageCard == TRUE
								- shadeImage
								Grupo 2 - Caja con texto en lateral y texto:
								- cont_card.tituloText
								- cont_card.descriptCard
								- sideText -->
					 <#if (cur_card.sideText.getData()?has_content 
					      && sideCard?trim?has_content 
								&& getterUtil.getBoolean(cur_card.activeImageCard.getData()) 
								&& cur_card.shadeImage.getData()??) 
					      || (cur_card.cont_card.tituloText.getData()?has_content 
								    && cur_card.cont_card.descriptCard.getData()?has_content 
										&& cur_card.sideText.getData()?has_content) >
        <section class="news-content  ">
            <div class="row ${sideCard} ${activeImage}">
                <div class="col-12 col-xl-5">
                    <#if getterUtil.getBoolean(cur_card.activeImageCard.getData())>
									 <#if (cur_card.shadeImage.getData())?? && cur_card.shadeImage.getData() != "">
                      <figure class="news-secondary-image">
                         <img alt="${cur_card.shadeImage.getAttribute("alt")}" data-fileentryid="${cur_card.shadeImage.getAttribute("fileEntryId")}" src="${cur_card.shadeImage.getData()}" />
                     </figure>
								    </#if>
									<#else>
                    <aside class="news-card">
                        <blockquote class="news-card__text" role="blockquote">
                            <i class="union-icon" aria-hidden="true"></i>
														<#if cur_card.cont_card.descriptCard.getData()?has_content>
                            <div class="news-card__descript">
                                	${cur_card.cont_card.descriptCard.getData()}
                            </div>
														</#if>
                        </blockquote>
												<#if cur_card.cont_card.tituloText.getData()?has_content>
                        <footer class="news-card__footer" role="contentinfo">
                            <span>${cur_card.cont_card.tituloText.getData()}</span>
                        </footer>
												</#if>
                    </aside>
										</#if>
                </div>
                <div class="col-12 col-xl-7">
								    <#if cur_card.sideText.getData()?has_content>
                    <section class="news-content news-card-content">
                        ${cur_card.sideText.getData()}
                    </section>
										</#if>
                </div>
            </div>
        </section>
				</#if>
        <#if cur_card.comment2.getData()?has_content>
	      <section class="news-content">
             ${cur_card.comment2.getData()}
        </section>
        </#if>
			  </#list>
      </#if>

    </article>
		
		
<script>
    $(document).ready(function(){
		    const NewsImages = $('.news-image');
				//console.log(recentNewsImages.html());
				//Comprobar el tamaño de pantalla
				if(window.innerWidth<576){
				//  console.log("pantalla mobile");
				   $(NewsImages).html('<img alt="${imagenDesktop.getAttribute("alt")}" data-fileentryid="${imagenDesktop.getAttribute("fileEntryId")}" src="${imagenDesktop.getData()}" />');
					 return;
				}
				//console.log("pantalla de desktop y tablet");
				$(NewsImages).html('<img alt="${imagen.getAttribute("alt")}" data-fileentryid="${imagen.getAttribute("fileEntryId")}" src="${imagen.getData()}" />');
		});
</script>