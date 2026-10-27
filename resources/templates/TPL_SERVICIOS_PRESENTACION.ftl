<#-- TPL_SERVICIOS_PRESENTACION (Landing) -->
<#-- estructura EST_COLUMN_TABS- ---- -->
<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />

<#assign iconosServiciosID = "distributor-icon-title${.vars['reserved-article-id'].data}" />
<#assign headerTitle = "" />
<#assign descriptionText = "" />

<section aria-labelledby="${iconosServiciosID}" class="distributor-icon">
    <div class="distributor-icon__container container">
        <#if title.getData()?has_content || description.getData()?has_content >
            <header class="distributor-icon__header">
            <#if title.getData()?has_content>
                <#assign headerTitle = title.getData() />
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

        <#assign totalItems = Group.getSiblings()?size />
        <#assign totalGroups = (totalItems / 3)?ceiling />
        <#assign globalIndex = 0 />
        <div class="row">
            <#if Group.getSiblings()?has_content>
                <#list Group.getSiblings() as iconGroup>

					<#assign centerStyleClass = "col-12 col-md-4 distributor-icon__column" />
                    <#assign isCenterGroup = (iconGroup?index == 1) || (iconGroup?index == 5 && totalGroups > 4) || (iconGroup?index == 7 && totalGroups > 6) />
                    <#if isCenterGroup>
						<#assign centerStyleClass = "col-12 col-md-4 distributor-icon__column distributor-icon__column-center" />
					</#if>
                    <#assign iconGroupTitle = "" />

                    <div class="${centerStyleClass}" role="group">
                        <div class="distributor-icon__category-container">
                            <#if iconGroup.iconGroupTitle.getData()?has_content>
                                <#assign iconGroupTitle = iconGroup.iconGroupTitle.getData() />
                                 <#if isCenterGroup>
                                   <i class="left-icon"></i>
                                 </#if>
                                <h3 class="distributor-icon__category">
                                    ${iconGroupTitle}

                                </h3>
                                  <#if isCenterGroup>
                                    <i class="rigth-icon"></i>
                                 </#if>
                            </#if>
                        </div>

                        <ul class="distributor-icon__list" role="list">
                            <#if iconGroup.iconGroup.getSiblings()?has_content>

                                <#list iconGroup.iconGroup.getSiblings() as icon>
									<#if icon.iconTitle.getData()?has_content>

                                         <li class="distributor-icon__item" role="listitem">

                                        <#assign iconUrl = assetLinkRelated.getFriendlyUrl()+"#"+
																				redsysService.getInstanceIdByReferenceByIndex(.vars["reserved-article-resource-prim-key"].data,"iconTitle",
				globalIndex,locale) />
				<a href="${iconUrl}" class="distributor-icon__item--btn" role="button">
                                            <#assign iconImageAtl="" />
											<#assign iconImageFileentryid="" />
											<#assign iconImageSrc="" />
                                            <#if (icon.iconImage.getData())?? && icon.iconImage.getData() != "">
												<#assign iconImageAtl=icon.iconImage.getAttribute("alt") />
											    <#assign iconImageFileentryid=icon.iconImage.getAttribute("fileEntryId") />
											    <#assign iconImageSrc=icon.iconImage.getData() />
                                                <img class="distributor-icon__image" alt="${iconImageAtl}"
                                                     data-fileentryid="${iconImageFileentryid}"
                                                     src="${iconImageSrc}" />
                                            </#if>
                                            <#assign iconTitle="" />
                                            <#if icon.iconTitle.getData()?has_content>
                                                <#assign iconTitle=icon.iconTitle.getData()?default("") />
                                                <p class="distributor-icon__text">
                                                    ${iconTitle}
                                                </p>
                                            </#if>
																						<!-- Popup -->


                                        </a>
                                        <#if icon.list_sub_service.getSiblings()?has_content>
                                        <#assign result=checkAllFieldsNonEmpty(icon.list_sub_service.subService.getSiblings()) />
                                        <#if result gt 0>
                                        <div class="popup-info" id="canalesInfo">
                                            <div class="popup-grid">
                                               
                                            <#list icon.list_sub_service.getSiblings() as list_sub_service>
                                            <div class="popup-column">
                                        
                                                            <!---->
                                                            <#if list_sub_service.subService.getSiblings()?has_content>
                                                                
                                                                    <#assign allSubservices=list_sub_service.subService.getSiblings()>
                                                                        <div class=" popup-column--left">
                                                                    <#list allSubservices as subService>
                                                                        <#assign index=subService_index />
                                                                        <#if index==5>
                                                                          </div>
                                                                          <div class="popup-column--right">
                                                                        </#if>
                                                                        <#if list_sub_service.list_subService_title.getData()?has_content && index==0>
                                                                            <p> ${ list_sub_service.list_subService_title.getData()} </p>
                                                                        </#if>
                                                                        <div class="popup-item">
                                                                        <#if subService.subService_img.getData()?has_content>
                                                                            <img src="${subService.subService_img.getData()}" class="popup-icon"
                                                                                alt="${subService.subService_img.getAttribute("alt")}"
                                                                                data-fileentryid="${subService.subService_img.getAttribute("fileEntryId")}"
                                                                                role="presentation">
                                                                        </#if>
                                                                        <#if subService.subService_title.getData()?has_content>
                                                                            ${subService.subService_title.getData()}
                                                                        </#if>
                                                                        </div>
                                                                    </#list>
                                                                     </div>
                                                       
                                                            </#if>
                                                           
                                                        </div>
                                            </#list>
                                        
                                    </div>
                                </div>
                                </#if>
                                        </#if>
                                        </li>
                                        </#if>
                                        <#assign globalIndex=globalIndex + 1 />
                                        
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
        <#if element.subService_img.getData()?has_content>
            <#assign fullAttributeCount += 1 />
        </#if>
    </#list>
    <#return fullAttributeCount />
</#function>
<script data-senna-track="permanent">
$(document).ready(function() {
    const isTouchDevice = matchMedia('(hover: none) and (pointer: coarse)').matches;
    if (isTouchDevice) {
        let tappedElement = null;
        let tapTimeout;
     //   console.log("Entro0")
        $(".distributor-icon__item--btn").on("touchstart", function(e) {
       //     console.log("Entro1")
            const $link = $(this);
            const $popup = $link.next(".popup-info");
            const $item = $link.closest(".distributor-icon__item");
            if (!$popup.length) {
            //    console.log("Entro sin lista")
                $(".popup-info").hide();
                $(".distributor-icon__item").removeClass("active");
                $(".distributor-icon__item").css("height", "auto");
                return; // Dejar que el click/tap siga su flujo natural
            }
          //  console.log("Entro2")
            if (tappedElement !== this) {
                e.preventDefault();
                tappedElement = this;
                // Ocultar otros popups
                $(".popup-info").not($popup).hide();
                $(".distributor-icon__item").not($item).removeClass("active");
                if ($popup.length) {
                    $popup.css({
                        left: ""
                    }).show(); // reset
                    $item.addClass("active");
                    ajustarLeft($link, $popup)
                }
                clearTimeout(tapTimeout);
                tapTimeout = setTimeout(() => {
                    tappedElement = null;
                }, 1500);
            } else {
                tappedElement = null;
                clearTimeout(tapTimeout);
                if ($popup.length) {
                    $popup.hide();
                    $item.removeClass("active");
                }
                window.location = $link.attr("href");
            }
        });
        // Ocultar al tocar fuera
        $(document).on("touchstart", function(e) {
            const $target = $(e.target);
            if (
                !$target.closest(".distributor-icon__item").length &&
                !$target.closest(".popup-info").length
            ) {
                $(".popup-info").hide();
                $(".distributor-icon__item").removeClass("active");
                tappedElement = null;
                clearTimeout(tapTimeout);
            }
        });
    } else {
        $(".distributor-icon__item--btn").on("mouseenter", function() {
                const $link = $(this);
                const $popup = $link.next(".popup-info");
                const $item = $link.closest(".distributor-icon__item");
                $(".distributor-icon__item").not($item).removeClass("active");
                if ($popup.length) {
                    $item.addClass("active");
                    ajustarLeft($link, $popup);
                }
            })
            .on("mouseleave", function() {
                $(".distributor-icon__item").removeClass("active");
            });
    }
    // Cálculo solo de left (basado en posición del botón)
    // Función para ajustar solo el LEFT
    function ajustarLeft($link, $popup) {
        const buttonOffset = $link.offset();
        var width = $link.outerWidth();
        var rightX = buttonOffset.left + width;
        const popupWidth = $popup.outerWidth();
        var viewportWidth = $(window).width();
        var containerWidth = $('.distributor-icon__container').width();
        let padding = 48;
        let sizeBtn = 96;
        if (viewportWidth < 1024) {
            padding = 16;
            sizeBtn = 0;
            containerWidth = viewportWidth;
        }
        let left = buttonOffset.left;
     //  console.log(containerWidth + "-" + popupWidth + "-" + padding + "-" + left + "-" + rightX)
      //  console.log("containerWidth - popupWidth - padding - left - right ")
        if ((left + popupWidth) > (containerWidth)) {
            // Si se sale por la derecha
        //    console.log(viewportWidth + "  " + (left + popupWidth) + ">" + (containerWidth - padding))
            left = rightX - left - popupWidth;
            $popup.css("left", left + "px");
        } else if (left < padding) {
            left = padding;
            $popup.css("left", left + "px");
        }
    }
});
</script>