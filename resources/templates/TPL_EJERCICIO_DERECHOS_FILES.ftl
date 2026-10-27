<#-- TPL_EJERCICIO_DERECHOS_FILES (Secciones Footer - Ejercicio de derechos) -->
<#-- estructura - EST_EJERCICIO_DERECHOS_FILES -->
<#-- @author Alban Loubet -->

<section aria-labelledby="descargas-title" class="rights-files">
        <div class="rights-files__container">

            <div class="rights-files-header">
						    <#if (title.getData())??>
								   <h1 class="rights-files-header__title" id="descargas-title">
									    ${title.getData()}
									 </h1>
	                 
                </#if>
								
								<#if (description.getData())??>
	                <div class="rights-files-header__description">
                    ${description.getData()}
                  </div>
                </#if>
            </div>

            <#if links.getSiblings()?has_content>
						   <div class="rights-files__wrapper">
							    <div class="rights-files-link__container">
									   <ul class="right-files-link-list">
	                   <#list links.getSiblings() as current_link>
										    <#if (current_link.link_content_name.getData())??>
												   <#assign link_content_name = current_link.link_content_name.getData()>
                        </#if>
												<#if (current_link.link_content_file.getData())??>
												   <#assign link_content_file_URL = current_link.link_content_file.getData()>
												</#if>
												<#if (current_link.link_content_icon.getData())?? && current_link.link_content_icon.getData() != "">
												   <#assign link_content_icon_alt = languageUtil.get(locale, "img-auxiliar-alt") +" "+ current_link.link_content_icon.getAttribute("title") />
												   <#if current_link.link_content_icon.getAttribute("alt")?trim?has_content>
							                <#assign link_content_icon_alt = current_link.link_content_icon.getAttribute("alt") />
							             </#if>
													 <#assign link_content_icon_alt = current_link.link_content_icon.getAttribute("alt")>
													 <#assign link_content_icon_fileentryid = current_link.link_content_icon.getAttribute("fileEntryId") >
													 <#assign link_content_icon_src = current_link.link_content_icon.getData() >
                        </#if>
												<#if (links.link_content_download_text.getData())??>
												   <#assign link_content_download_text = current_link.link_content_download_text.getData()>
                        </#if>
		                    <li class="right-files-link-list__element" role="list">
                            <span class="element_title">${link_content_name}</span>
                            <a role="button" href="${link_content_file_URL}" class="element_link" download aria-label="Descargar el documento ${link_content_name}">
                                <img alt="${link_content_icon_alt}" class="element_link-image" src="${link_content_icon_src}" />
                                <span class="element_link-text">${link_content_download_text}</span>
                            </a>
                        </li>
	                   </#list>
										 </ul>
									</div>
							 </div>
            </#if>
        </div>
    </section>