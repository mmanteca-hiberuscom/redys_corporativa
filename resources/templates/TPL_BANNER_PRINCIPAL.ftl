<#--PLANTILLA DE BANNER PRINCIPAL (Landing)  -->
<#-- @Author Yordy Tafur -->
<#-- ESTRUCTURA EST_BANNER_PRINCIPAL -->

<section class="hero-banner-principal" aria-labelledby="hero-banner-title">
         <#assign fileEntryId = "" />
				 <div class="container">
            <div class="hero-banner-principal-content">
                <div class="row">

                    <div class="col-12 col-xl-6 hero-banner-principal-content-text">
										   <div class="hero-banner-principal-wrapper">
                            <div class="hero-banner-principal-title-animation">
                                <#if groupTitle.titlePart1.getData()?trim?has_content>
                                    <h1> <span>${groupTitle.titlePart1.getData()} </span>
                                    
                                    <#if groupTitle.titleAnimate.getSiblings()?has_content>
                                        <#assign animatedWords = groupTitle.titleAnimate.getSiblings() />
                                        
                                        <#if animatedWords?size == 1>
                                            <span class="hero-banner-principal-animation word active">${animatedWords[0].getData()}</span>
                                        <#else>
                                            <span class="hero-banner-principal-animation">
                                                <#list animatedWords as cur_groupTitle_titleAnimate>
                                                    <#if cur_groupTitle_titleAnimate.getData()?trim?has_content>
                                                        <#assign activeClass = "" />
                                                        <#if cur_groupTitle_titleAnimate?is_first>
                                                            <#assign activeClass = "active" />
                                                        </#if>
                                                        <span class="word ${activeClass}">${cur_groupTitle_titleAnimate.getData()}</span>
                                                    </#if>
                                                </#list>
                                            </span>
                                        </#if>
                                    </#if>

                                    
                               
                                </#if>

                                <#if groupTitle.titlePart2.getData()?trim?has_content>
                                       <span>  ${groupTitle.titlePart2.getData()} </span>
                                </#if>
                                </h1>
                            </div>


                        <#if descriptionComplete.getData()?trim?has_content>
                        <div class="hero-banner-principal-description">
                                <div>
                                    ${descriptionComplete.getData()}
                                </div>
                        </div>
                        </#if>
                        <#if textButton.getData()?trim?has_content>
												     <#assign linkUrl = "" />
												     <#if linkButton.getData()?trim?has_content>
												       	<#assign linkUrl = "${linkButton.getFriendlyUrl()}" />
												     </#if>
												     <a data-senna-off="true" class="cta-btn-orange" href="${linkUrl}">
                              	 ${textButton.getData()}
                             </a>
                        </#if>
												
												
                      </div>
                    </div>
                    <div class="col-12 col-xl-6">
                            <div class="hero-banner-principal-content-img">		 
															<picture>
																			<source 
																							srcset="${bannerImage.imageMobile.getData()}" 
																							media="(max-width: 767.98px)" 
																							data-fileentryid="${bannerImage.imageMobile.getAttribute("fileEntryId")!}" />

																			<source 
																							srcset="${bannerImage.imageTablet.getData()}" 
																							media="(max-width: 1199.98px)" 
																							data-fileentryid="${bannerImage.imageTablet.getAttribute("fileEntryId")!}" />

																	<img 
																			class="hero-banner-principal-image"
																			src="${bannerImage.imageDesktop.getData()}" 
																			alt="${bannerImage.imageDesktop.getAttribute("alt")!bannerImage.imageDesktop.getAttribute("title")!bannerImage.imageDesktop.getAttribute("fileName")!"Imagen desktop"}" 
																			data-fileentryid="${bannerImage.imageDesktop.getAttribute("fileEntryId")!}" />
															</picture>
														</div>
                    </div>

                </div>

            </div>
            </div>
					</div>
</section>