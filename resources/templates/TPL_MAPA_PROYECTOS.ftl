<#-- TPL_MAPA_PROYECTOS (Landing) -->
<#-- estructura - EST_MAPA_PROYECTOS -->

<#assign articleId = .vars["reserved-article-id"].data />
<section class="map " aria-labelledby="map-title${articleId}">

    <div class="map__container">
        <#assign headerTitle = "" />
        <#assign descriptionText = "" />
        <#if title.getData()?has_content || description.getData()?has_content >
            <div class="map-header">
                <#if title.getData()?has_content>
                    <#assign headerTitle = title.getData() />
                    <h2 class="map-header__title" id="map-title${articleId}">${headerTitle}</h2>
                </#if>
                <#if description.getData()?has_content>
                    <#assign descriptionText = description.getData() />
                    <div class="map-header__description">
                        ${descriptionText}
                    </div>
                </#if>
            </div>
        </#if>
        
        <@renderMap image=imgMapaDesktop mapClass="map__wrapper d-none d-lg-block">
            <@renderDots />
            <div class="map__popup" id="map-popup${articleId}" role="tooltip">
                <div class="map__popup-header">
                    <img class="map__popup-flag" id="popup-flag${articleId}" src="" alt="Bandera">
                    <p class="map__popup-title" id="map-popup__title${articleId}"></p>
                </div>
                <div class="map__popup-description" id="map-popup__description${articleId}"></div>
            </div>
        </@renderMap>

        <@renderMap image=imgMapaMobile mapClass="map__wrapper--mobile d-block d-lg-none">
            <@renderAccordion />
        </@renderMap>
    </div>
</section>

<#macro renderMap image mapClass>
    <div class="${mapClass}">
        <div class="map__image-container">
            <#if image?? && image.getData()?has_content && image.getData()?trim?has_content>
						    <#assign mapAlt = languageUtil.get(locale, "img-auxiliar-flag-alt") +" "+ image.getAttribute("title") />
						    <#if image.getAttribute("alt")?trim?has_content>
								   <#assign mapAlt = image.getAttribute("alt") />
								</#if>
                <#assign mapaDataFileEntryId = image.getAttribute("fileEntryId") />
                <#assign mapaSrc = image.getData() />
                <img alt="${mapAlt}" data-fileentryid="${mapaDataFileEntryId}" src="${mapaSrc}" class="map__image"/>
            </#if>
            <#nested>
        </div>
    </div>
</#macro>

<#macro renderDots>
    <ul class="map__dots" role="list">
        <#if continents.getSiblings()?has_content>
            <#list continents.getSiblings() as continent>
                <#if continent.countries.getSiblings()?has_content>
                    <#assign xValue = "" />
                    <#assign yValue = "" />
                    <#assign countryName = "" />
                    <#assign countryDescription = "" />
                    <#assign countryFlagSrc = "" />
                    <#list continent.countries.getSiblings() as currentCountry>
                        <#if currentCountry.coordinatesX.getData()?has_content>
                            <#assign xValue = currentCountry.coordinatesX.getData()?replace(",", ".")?number />
                        </#if>
                        <#if currentCountry.coordinatesY.getData()?has_content>
                            <#assign yValue = currentCountry.coordinatesY.getData()?replace(",", ".")?number />
                        </#if>
                        <#if currentCountry.countryName.getData()?has_content>
                            <#assign countryName = currentCountry.countryName.getData() />
                        </#if>
                        <#if currentCountry.countryLabel.getData()?has_content>
                            <#assign countryDescription = currentCountry.countryLabel.getData() />
														<#assign cleanCountryDescription = countryDescription?replace("<p>", "")
														                                                     ?replace("</p>", "")
														                                                     ?replace("<ul>", "")
																																								 ?replace("</ul>", "")
																																								 ?replace("<li>", "")
																																								 ?replace("</li>", "")
																																								 ?replace("<strong>", "")
																																								 ?replace("</strong>", "") />
                        </#if>
                        <#if currentCountry.countryFlag.getData()?has_content >
                            <#assign countryFlagSrc = currentCountry.countryFlag.getData() />
                        </#if>
                        <#if xValue?has_content || yValue?has_content >
                            <#assign mapDotStyle = "style=\"top: ${yValue}%; left: ${xValue}%;\"" />
                        </#if>
												
												<li  role="listitem"> <button class="map__dot" ${mapDotStyle}  tabindex="0" aria-label="En ${countryName}: ${cleanCountryDescription}" data-title="${countryName}" data-description="${countryDescription}" data-flag="${countryFlagSrc}">  <span>${countryName}<span></button></li>
												
                        
                    </#list>
                </#if>
            </#list>
        </#if>
    </ul>
</#macro>

<#macro renderAccordion>
    <#assign countryIndex=0 />
    <div class="map-accordion">
        <div class="accordion" id="accordionMap${articleId}">
            <#if continents.getSiblings()?has_content>
                <#list continents.getSiblings() as continent>
                    <div class="map-accordion__card">
                        <#assign continentName = "" />
                        <#if continent.continentName.getData()?has_content>
                            <div class="map-accordion__card-header" id="headingContinent${continent_index}">
                                <#assign continentName = continent.continentName.getData() />
                                <button class="map-accordion_button" type="button" data-toggle="collapse" data-target="#collapseContinent${continent_index}" aria-expanded="false" aria-controls="collapseContinent${continent_index}">
                                    ${continentName}
                                    <span class="toggle-icon"></span>
                                </button>
                            </div>
                        </#if>
                        <div id="collapseContinent${continent_index}" class="collapse" aria-labelledby="headingContinent${continent_index}" data-parent="#accordionMap${articleId}">
                            <div class="map-accordion__card-body" id="accordionContinent${continent_index}">
                                <#if continent.countries.getSiblings()?has_content>
                                    <#list continent.countries.getSiblings() as country>
                                        <div class="map-accordion__country-card">
                                            <div class="map-accordion__card-header" id="headingCountry${countryIndex}">
                                                <button class="map-accordion__country-button" type="button" data-toggle="collapse" data-target="#collapseCountry${countryIndex}" aria-expanded="false" aria-controls="collapseCountry${countryIndex}">
                                                    <#assign countryFlagAlt = languageUtil.get(locale, "img-auxiliar-flag-alt")+" "+country.countryFlag.getAttribute("title") />
																										<#if country.countryFlag.getAttribute("alt")?trim?has_content>
																										   <#assign countryFlagAlt = country.countryFlag.getAttribute("alt") />
																										</#if>
																										
																										<img src="${country.countryFlag.getData()}" alt="${countryFlagAlt}" class="flag">
                                                    ${country.countryName.getData()}
                                                </button>
                                            </div>
                                            <div id="collapseCountry${countryIndex}" class="collapse" aria-labelledby="headingCountry${countryIndex}" data-parent="#accordionContinent${continent_index}">
                                                <div class="map-accordion__country-description">${country.countryLabel.getData()}</div>
                                            </div>
																						<#assign countryIndex +=1 />
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>
        </div>
    </div>
</#macro>
 
<script>
$(document).ready(function () {
    if ($(window).width() < 992) return;

    const $dots = $(".map__dot");
    const $popup = $("#map-popup${articleId}");
    const $popupFlag = $("#popup-flag${articleId}");
    const $popupTitle = $("#map-popup__title${articleId}");
    const $popupDescription = $("#map-popup__description${articleId}");

    let popupTimer = null;
    let hideTimer = null;
    let isHovering = false;

    function showPopup($dot) {
        const flagSrc = $dot.attr("data-flag");
        const countryTitle = $dot.attr("data-title");
        const countryDescription = $dot.attr("data-description");

        if (!countryTitle.trim()) return;

        $popupFlag.attr("src", flagSrc);
        $popupFlag.attr("alt", '${languageUtil.get(locale, "img-auxiliar-flag-alt")} ' + countryTitle);
        $popupTitle.text(countryTitle);
        $popupDescription.html(countryDescription);

        const dotX = $dot.position().left + $dot.outerWidth() / 2;
        const dotY = $dot.position().top;
        const windowHeight = $(window).height();
        const popupMargin = 20;

        // Mostrar temporalmente para medir altura
        $popup.css({
            display: "block",
            visibility: "hidden"
        });

        const popupHeight = $popup.outerHeight();

        // Posicionar SIEMPRE por encima del punto
        const topValue = dotY - popupHeight - popupMargin;

        // Limitar altura si el popup es muy alto
        if (popupHeight > windowHeight - 2 * popupMargin) {
            $popup.css({
                "max-height": (windowHeight - 2 * popupMargin) + "px",
                "overflow-y": "auto"
            });
        } else {
            $popup.css({
                "max-height": "",
                "overflow-y": ""
            });
        }

        // Aplicar posición y mostrar
        $popup.css({
            top: (dotY - popupHeight - popupMargin) + "px",
    				left: dotX + "px",
            visibility: "visible"
        }).fadeIn(200);

        // Scroll si el popup queda oculto por el header
        const popupTop = $popup.offset().top;
        const popupHeightVisible = $popup.outerHeight();
        const windowTop = $(window).scrollTop();
        const headerHeight = 180;
        const desiredTop = popupTop - popupMargin - headerHeight;

        if (popupTop < windowTop + headerHeight + popupMargin) {
            $('html, body').stop(true).animate({
                scrollTop: Math.max(0, desiredTop)
            }, 400);
        }
    }

    function hidePopup() {
        if (isHovering) return;
        $popup.fadeOut();
    }

    // Hover
    $dots.on("mouseenter", function () {
        const $dot = $(this);
        $dots.removeClass("is-hovering");
        $dot.addClass("is-hovering");

        isHovering = true;
        clearTimeout(hideTimer);

        popupTimer = setTimeout(() => showPopup($dot), 400);
    });

    $dots.on("mouseleave", function () {
        $(this).removeClass("is-hovering");

        hideTimer = setTimeout(() => {
            if (!$(".map__dot.is-hovering").length && !$popup.is(":hover")) {
                isHovering = false;
                hidePopup();
            }
        }, 400);
    });

    $popup.on("mouseenter", function () {
        clearTimeout(hideTimer);
        isHovering = true;
    });

    $popup.on("mouseleave", function () {
        hideTimer = setTimeout(() => {
            if (!$(".map__dot.is-hovering").length) {
                isHovering = false;
                hidePopup();
            }
        }, 300);
    });

    // Teclado (Accesibilidad)
    $dots.on("focus", function () {
        const $dot = $(this);
        $dots.removeClass("is-hovering");
        $dot.addClass("is-hovering");
        isHovering = true;
        showPopup($dot);
    });

    $dots.on("blur", function () {
        const $dot = $(this);
        $dot.removeClass("is-hovering");

        hideTimer = setTimeout(() => {
            if (!$(".map__dot.is-hovering").length && !$popup.is(":hover")) {
                isHovering = false;
                hidePopup();
            }
        }, 300);
    });

    $dots.on("keydown", function (e) {
        if (e.key === "Enter" || e.key === " ") {
            e.preventDefault();
            const $dot = $(this);
            $dots.removeClass("is-hovering");
            $dot.addClass("is-hovering");
            isHovering = true;
            showPopup($dot);
        }
    });
});

// Mobile – Acordeón
$(document).ready(function () {
    if ($(window).width() < 1024.99) {
        $('.map-accordion__country-button').on('click', function () {
            const $button = $(this);
            const $card = $button.closest('.map-accordion__country-card');
            const $collapse = $card.find('.collapse');

            if ($collapse.hasClass('show')) {
                $card.removeClass('active');
            } else {
                $('.map-accordion__country-card.active').removeClass('active');
                $card.addClass('active');
            }
        });
    }
});
</script>