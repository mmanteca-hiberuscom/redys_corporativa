<#-- TPL_ICONOS_SERVICIOS (Landing) -->
<#-- estructura - EST_ICONOS_SERVICIOS -->
<#-- @author Alban Loubet -->

<#assign iconosServiciosID = "distributor-icon-title${.vars['reserved-article-id'].data}" />
<#assign headerTitle = "" />
<#assign descriptionText = "" />
<section aria-labelledby="${iconosServiciosID}" class="distributor-icon">
    <div class="distributor-icon__container container">
        <#if mainTitle.getData()?has_content || description.getData()?has_content >
            <header class="distributor-icon__header">
            <#if mainTitle.getData()?has_content>
                <#assign headerTitle = mainTitle.getData() />
                <h2 class="distributor-icon__title" id="${iconosServiciosID}">
                    ${headerTitle}
                </h2>
            </#if>
            <#if description.getData()?has_content>
                <#assign descriptionText = description.getData() />
                <div aria-live="polite" class="distributor-icon__subtitle">
                    ${descriptionText}
                </div>
            </#if>
            </header>
        </#if>
        
        <#assign totalItems = iconGroup.getSiblings()?size />
        <#assign totalGroups = (totalItems / 3)?ceiling />  

        <div class="row">
				    <#assign siblings = iconGroup.getSiblings() />
            <#assign siblingsCount = siblings?size />
            <#assign firstSibling = siblings?first />
            <#if siblings?has_content && siblingsCount gte 1 && firstSibling.iconGroupTitle.getData()?has_content>
                <#list iconGroup.getSiblings() as iconGroup>
					<#assign centerStyleClass = "col-12 col-lg-4 distributor-icon__column" />
                    <#assign isCenterGroup = (iconGroup?index == 1) || (iconGroup?index == 5 && totalGroups > 4) || (iconGroup?index == 7 && totalGroups > 6) />
                    <#if isCenterGroup>
						<#assign centerStyleClass = "col-12 col-lg-4 distributor-icon__column distributor-icon__column--center" />
					</#if>
                    <#assign iconGroupTitle = "" />
										<#if iconGroup.icon.getSiblings()?has_content>
												<#assign result = checkAllFieldsNonEmpty(iconGroup.icon.getSiblings()) />
										</#if>
										<#if result gt 0>
										   <#if iconGroup.iconGroupTitle.getData()?has_content>
										   <div class="${centerStyleClass}" role="group">
                        <div class="distributor-icon__category-container">
                            
                                <#assign iconGroupTitle = iconGroup.iconGroupTitle.getData() />
                                <h3 class="distributor-icon__category">
                                    ${iconGroupTitle}
                                </h3>
                            
                        </div> 
												</#if>
										</#if>
                    
                        <#if iconGroup.icon.getSiblings()?has_content>
												   <#assign result = checkAllFieldsNonEmpty(iconGroup.icon.getSiblings()) />
												</#if>
												<#if result gt 0 && iconGroup.iconGroupTitle.getData()?has_content>
                           <ul class="distributor-icon__list">
                            
                                <#list iconGroup.icon.getSiblings() as icon>
																<#if icon.iconTitle.getData()?has_content && icon.iconImage.getData()?has_content >
																   <li class="distributor-icon__item" role="list">
                                        <#assign iconUrl = "" />
                                        <#if icon.iconUrl.getData()?trim?has_content>
                                            <#assign iconUrl = icon.iconUrl.getData() />	
																						<a class="distributor-icon__item--btn" href="${iconUrl}">
																						<#else>
																						<div class="distributor-icon__item--btn">
                                        </#if>

                                        
                                            <#assign iconImageAtl="" />
											<#assign iconImageFileentryid="" />
											<#assign iconImageSrc="" />
                                            <#if (icon.iconImage.getData())?? && icon.iconImage.getData() != "">
																						<#if (icon.iconImage.getAttribute("alt"))?has_content>
																						   <#assign iconImageAtl=icon.iconImage.getAttribute("alt") />
																						<#else>
																						   <#assign iconImageAtl = languageUtil.get(locale, "img-auxiliar-alt") +" "+ icon.iconImage.getAttribute("title") />
																						
																						</#if>
											                      <#assign iconImageFileentryid=icon.iconImage.getAttribute("fileEntryId") />
											                      <#assign iconImageSrc=icon.iconImage.getData() />
                                                <img class="distributor-icon__image" alt="${iconImageAtl}" 
                                                     data-fileentryid="${iconImageFileentryid}" 
                                                     src="${iconImageSrc}" />
                                            </#if>
                                            <#assign iconTitle="" />
                                            <#if icon.iconTitle.getData()?has_content>
                                                <#assign iconTitle=icon.iconTitle.getData() />
                                                <p class="distributor-icon__text">
                                                    ${iconTitle}
                                                </p>
                                            </#if>
																				<#if (icon.iconUrl.getData())??>		
                                           </a>
																				<#else>
																				   </div>
																			  </#if>
                                    </li>
																</#if>
                                    
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </#list>
            </#if>
        </div>
    </div>
</section>

<#function checkAllFieldsNonEmpty elements>
    <#assign fullAttributeCount = 0 />
		<#list elements as element>
        <#if element.iconTitle.getData()?has_content && element.iconImage.getData()?has_content>
            <#assign fullAttributeCount += 1 />
        </#if>
    </#list>
    <#return fullAttributeCount />
</#function>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const items = document.querySelectorAll(".distributor-icon__item");
        items.forEach(item => {
            item.addEventListener("click", function (event) {
                event.stopPropagation();
                items.forEach(i => i.classList.remove("active"));
                this.classList.add("active");
            });
            item.addEventListener("keydown", function (event) {
                if (event.key === "Enter" || event.key === " ") {
                    item.click();
                }
            });
        });
    });
</script>