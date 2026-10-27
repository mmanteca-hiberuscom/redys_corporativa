<#--PLANTILLA DE BANNER SECUNDARIO -->
<#-- ESTRUCTURA EST_BANNER_SECUNDARIO -->
<#macro renderHTML text>
    <#assign parsedText = text
		    ?replace(r"[\u00A0]", " ") 
        ?replace("&lt;", "<")
        ?replace("&gt;", ">")
        ?replace("&quot;", "\"")
        ?replace("&apos;", "'")
        ?replace("&amp;", "&")
        ?replace("&nbsp;", " ")> 
    ${parsedText}
</#macro>
<section class="hero-banner"  aria-labelledby="hero-banner-title">

        <#assign fileEntryId = "" />
        <#assign classImageSize="col-xl-12" />
            <#if body.descriptionComplete.getData()?has_content>
                <#assign classImageSize="col-xl-6" />
            </#if>

            <div class="hero-banner-content hero-banner-content-v2 container">
                <#if header.title.getData()?has_content>
                   <h1 class="hero-banner-title">${header.title.getData()}</h1>
                </#if>
								<#assign leftClass = "" />
								<#assign destacadaClass = "" />
                <#if header.titleDestHeader.getData()?has_content>
								      <#assign destacadaClass = "header-destacado" />
								</#if>
                <#if (header.subtitle.getData()?has_content || header.titleDestHeader.getData()?has_content) && header.description.getData()?has_content>
                    <div class="hero-banner-content-header ${destacadaClass}">
										    <#if header.subtitle.getData()?has_content>
	                         <h2 class="hero-banner-subtitle">${header.subtitle.getData()}</h2>
                        </#if>
												
                        <#if header.titleDestHeader.getData()?has_content>
												<#assign leftClass = "col-xl-7" />
								           <h1 class="hero-banner-title-destacado-header col-xl-5">
	                             <@renderHTML text=header.titleDestHeader.getData() />
										      </h1>
                        </#if>
                        <div class="hero-banner-header-description ${leftClass}">
								            <button class="show-more" aria-controls="full-description">
                                <@liferay.language key="show-more" />  <i class="plus-icon"></i>
                            </button>
                            <div class="full-text" id="full-description">${header.description.getData()}</div>
                        </div>
                    </div>
                </#if>
                  <#assign rowClass = "" />
                 <#if body.titleDestBody.getData()?has_content>
								      <#assign rowClass = "hero-banner-row" />
								</#if>
                <div class="row ${rowClass}">
                    
                    <div class="col-12 col-xl-6 hero-banner-content-text">
                           <#if body.titleDestBody.getData()?has_content>
													   <h1 class="hero-banner-title-destacado">
																  <@renderHTML text=body.titleDestBody.getData() />
													   </h1>
                           </#if>
                        <#if body.descriptionComplete.getData()?has_content>
                        <div class="hero-banner-description">
                             <div>
                                ${body.descriptionComplete.getData()}
                             </div>
                        </div>
                        </#if>
                    </div>
                    <div class="col-12 ${classImageSize}">
			
                            <div class="hero-banner-content-img">
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
																	class="hero-banner-image"
																	src="${bannerImage.imageDesktop.getData()}" 
																	alt="${bannerImage.imageDesktop.getAttribute("alt")!bannerImage.imageDesktop.getAttribute("title")!bannerImage.imageDesktop.getAttribute("fileName")!"Imagen desktop"}" 
																	data-fileentryid="${bannerImage.imageDesktop.getAttribute("fileEntryId")!}" />
													</picture>

                    </div>

            </div>
            </div>
</section>

<script type="text/javascript">
    $(document).ready(function () {
        const $button = $(".show-more");
        const $text = $(".full-text");

        $button.click(function () {
            const isHidden = $text.is(":hidden") || $text.css("display") === "";

            if (isHidden) {
                $button.html("<@liferay.language key='show-less' /> <i class='plus-icon desactive'></i>");
                $text.show();
            } else {
                $button.html("<@liferay.language key='show-more' /> <i class='plus-icon'></i>");
                $text.hide();
            }
        });
    });
</script>