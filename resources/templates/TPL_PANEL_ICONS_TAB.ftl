<#-- PLANTILLA DE ICONOS DESPLEGABLES (Información corporativa) -->
<#-- @Author Yordy Tafur -->
<#-- ESTRUCTURA EST_PANEL_ICONS_TAB -->

<#assign classFirst="" />
<#if getterUtil.getBoolean(checkbox.getData())>
    <#assign classFirst="tabs-icon-v2" />
</#if>

<#assign fileEntryId = "" />
<section class="tabs-icon ${classFirst}">
    <div class="tabs-icon__container container">
		   <#if title.getData()?trim?has_content || subtitle.getData()?trim?has_content || description.getData()?trim?has_content>
         <div class="tabs-icon__header">
            <#if title.getData()?trim?has_content>
                <h2 class="tabs-icon__header-title">${title.getData()}</h2>
            </#if>
            <div class="tabs-icon__text-columns">
                <#if subtitle.getData()?trim?has_content>
                    <div class="tabs-icon__header-subtitle">${subtitle.getData()}</div>
                </#if>
                <#if description.getData()?trim?has_content>
                    <div class="tabs-icon__header-description">${description.getData()}</div>
                </#if>
            </div>
         </div>
		  	</#if>


        <div class="tabs-icon__group">
            <ul class="tabs-icon__group-list" role="tablist">
                <#if iconGroup.getSiblings()?has_content>
                    <#list iconGroup.getSiblings() as cur_iconGroup>
										  
                        <li class="tabs-icon__group-item" role="presentation">
                            <button class="tabs-icon__icon-link" data-toggle="tab"
                                data-target="#collapseTab-${cur_iconGroup_index}"
                                role="tab"
                               
                                 aria-controls="collapseTab-${cur_iconGroup_index}">
                                <#if cur_iconGroup.image.getData()?trim?has_content >
																
																 <#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_iconGroup.image.getAttribute("title") />
																<#if cur_iconGroup.image.getAttribute("alt")?trim?has_content>
														    <#assign altImg = cur_iconGroup.image.getAttribute("alt") />
														    </#if>
																
																<#if cur_iconGroup.image.getAttribute("fileEntryId")?trim?has_content>
  																  <#assign fileEntryId = 'data-fileentryid=\"${cur_iconGroup.image.getAttribute("fileEntryId")}\"' />
																</#if>
                                    <img alt="${altImg}" class="tabs-icon__icon"
                                        ${fileEntryId} src="${cur_iconGroup.image.getData()}" />
                                </#if>
                                <#if cur_iconGroup.imageTitle.getData()?trim?has_content>
                                    <div class="tabs-icon__icon-title">${cur_iconGroup.imageTitle.getData()}</div>
                                </#if>
                            </button>
                        </li>
                    </#list>
                </#if>
            </ul>
        </div>


        <div class="tabs-icon__tab-content" id="tabContent" role="list">
            <#if iconGroup.getSiblings()?has_content>
                <#list iconGroup.getSiblings() as cur_iconGroup>
                    <#assign styleCss="style=\"background-color: white\"" />
                    <#if cur_iconGroup.iconBackground.getData()?trim?has_content>
												<#assign styleCss = "style=\"background-color: ${cur_iconGroup.iconBackground.getData()}\"" />
                    </#if>
                    <div class="tabs-icon__card" role="listitem">
                        <div class="tabs-icon__card-header" id="heading-${cur_iconGroup_index}" role="presentation">
                            <button role="tab" class="tabs-icon__button" type="button" data-toggle="collapse"
                                data-target="#collapseTab-${cur_iconGroup_index}" aria-expanded="false"
                                aria-controls="collapseTab-${cur_iconGroup_index}">
                                <#if (cur_iconGroup.image.getData())?? && cur_iconGroup.image.getData() != "">
														       <#assign altImg =  languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_iconGroup.image.getAttribute("title") />
																<#if cur_iconGroup.image.getAttribute("alt")?trim?has_content>
														       <#assign altImg = cur_iconGroup.image.getAttribute("alt") />
														    </#if>
																
																<#if cur_iconGroup.image.getAttribute("fileEntryId")?trim?has_content>
  																  <#assign fileEntryId = 'data-fileentryid=\"${cur_iconGroup.image.getAttribute("fileEntryId")}\"' />
																</#if>
                                    <img class="tabs-icon__icon" alt="${altImg}" 
                                        ${fileEntryId}
                                        src="${cur_iconGroup.image.getData()}" />
                                </#if>
                                <#if cur_iconGroup.imageTitle.getData()?trim?has_content>
                                    <div class="tabs-icon__icon-title">${cur_iconGroup.imageTitle.getData()}</div>
                                </#if>
																<span class="tabs-icon__button-background" ${styleCss}></span>
                                <i class="toggle-icon"></i>
                            </button>
                        </div>
                        <div id="collapseTab-${cur_iconGroup_index}" class="collapse" aria-labelledby="heading-${cur_iconGroup_index}" data-parent="#tabContent" role="tabpanel">
                            <div class="tabs-icon__card-body">   
                                <div class="row tabs-icon__row">
                                    <div class="col-7 tabs-icon__column-left">
                                        <#if (cur_iconGroup.titleDropdown.getData())??>
                                            <div class="tabs-icon__tab-title">${cur_iconGroup.titleDropdown.getData()}</div>
                                        </#if>
                                        <#if (cur_iconGroup.descriptionDropdown.getData())??>
                                            <div class="tabs-icon__tab-description">${cur_iconGroup.descriptionDropdown.getData()}</div>
                                        </#if>
                                    </div>
                                    <div class="col-5 tabs-icon__column-right">
                                        <#if (cur_iconGroup.imageDropdown.getData())?? && cur_iconGroup.imageDropdown.getData() != "">
														           <#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_iconGroup.imageDropdown.getAttribute("title") />
                                        <#if cur_iconGroup.imageDropdown.getAttribute("alt")?trim?has_content>
														             <#assign altImg = cur_iconGroup.imageDropdown.getAttribute("alt") />
														              </#if>
															        	<#if cur_iconGroup.imageDropdown.getAttribute("fileEntryId")?trim?has_content>
  														      		  <#assign fileEntryId = 'data-fileentryid=\"${cur_iconGroup.imageDropdown.getAttribute("fileEntryId")}\"' />
															         	</#if> 
                                            <div class="tabs-icon__image-container">
                                                <img class="tabs-icon__tab-image" ${styleCss}
                                                    alt="${altImg}" 
                                                    ${fileEntryId}
                                                    src="${cur_iconGroup.imageDropdown.getData()}" />
                                            </div>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>
        </div>
    </div>
</section>

<script>
(function () {
    const $document = $(document);
    const $tabComponent = $('.tabs-icon');

    function resetTabsIcon() {
        $tabComponent.find('.collapse.show').collapse('hide');
        $tabComponent.find('.tabs-icon__icon-link, .tabs-icon__group-item').removeClass('active');
        $tabComponent.find('.tabs-icon__icon').removeClass('active-icon filtered-icon');
    }

    $('.tabs-icon__icon-link').off('click').on('click', function (e) {
        e.preventDefault();

        const $this = $(this);
        const targetPane = $this.attr('data-target');
        const activePane = $('.collapse.show');
        const isAlreadyActive = $this.hasClass('active');
        const $futureActiveIcon = $this.find('.tabs-icon__icon');

        $('.tabs-icon__icon-link, .tabs-icon__group-item').removeClass('active');
        $('.tabs-icon__icon').removeClass('active-icon');

        $('.tabs-icon-v2 .tabs-icon__icon').each(function () {
            if (!$(this).is($futureActiveIcon)) {
                $(this).addClass('filtered-icon');
            } else {
                $(this).removeClass('filtered-icon');
            }
        });

        if (activePane.length > 0) {
            activePane.collapse('hide').one('hidden.bs.collapse', function () {
                if (!isAlreadyActive) {
                    $(targetPane).collapse('show');
                    $this.addClass('active');
                    $this.closest('.tabs-icon__group-item').addClass('active');
                    $futureActiveIcon.addClass('active-icon');
                } else {
                    resetTabsIcon();
                }
            });
        } else {
            $(targetPane).collapse('show');
            $this.addClass('active');
            $this.closest('.tabs-icon__group-item').addClass('active');
            $futureActiveIcon.addClass('active-icon');
        }
    });

    $document.on('click', function (e) {
        const $target = $(e.target);
        const isInsideComponent = $target.closest('.tabs-icon').length > 0;
        const isIconButton = $target.closest('.tabs-icon__icon-link').length > 0;
        const isTabContent = $target.closest('.tabs-icon__card').length > 0;

        if (!isInsideComponent || (!isIconButton && !isTabContent)) {
            resetTabsIcon();
        }
    });

    function scrollToTabDesktop($button, $tab) {
        const fixedHeaderHeight = 180;
        const extraMargin = 24;
        const $groupItems = $('.tabs-icon__group-item');
        const groupTop = $('.tabs-icon__group-list').offset().top;
        const buttonTop = $button.offset().top;
        const tabTop = $tab.offset().top;

        const hasTwoRows = (() => {
            const rowTops = new Set();
            $groupItems.each(function () {
                rowTops.add(Math.round($(this).offset().top));
            });
            return rowTops.size > 1;
        })();

        let targetScrollTop;

        if (hasTwoRows) {
            targetScrollTop = groupTop - fixedHeaderHeight - extraMargin;
        } else {
            targetScrollTop = buttonTop - fixedHeaderHeight - extraMargin;
        }

        const maxScrollTop = tabTop - fixedHeaderHeight - 16;
        targetScrollTop = Math.min(targetScrollTop, maxScrollTop);

        $('html, body').animate({
            scrollTop: targetScrollTop
        }, 400);

        $tab.addClass('fade-highlight');
        setTimeout(() => $tab.removeClass('fade-highlight'), 300);
    }
		
function hasMultipleRows($listItems) {
    const rowTops = new Set();
    $listItems.each(function () {
        rowTops.add(Math.round($(this).offset().top));
    });
    return rowTops.size > 1;
}

function isInFirstRow($item, $listItems) {
    const itemTop = Math.round($item.offset().top);
    const rowTops = $listItems.map(function () {
        return Math.round($(this).offset().top);
    }).get();
    const minTop = Math.min(...rowTops);

    return itemTop === minTop;
}

    function scrollToTabMobile($tab) {
        const headerHeight = 92;
        const extraPadding = 48;

        requestAnimationFrame(() => {
            setTimeout(() => {
                const tabTop = $tab.offset().top;
                const tabBottom = tabTop + $tab.outerHeight();

                const viewportTop = $(window).scrollTop();
                const viewportBottom = viewportTop + $(window).height();

                const isAbove = tabTop < viewportTop + headerHeight;
                const isBelow = tabBottom > viewportBottom;

                if (isAbove || isBelow) {
                    const targetScrollTop = tabTop - headerHeight - extraPadding;

                    $('html, body').animate({
                        scrollTop: targetScrollTop
                    }, 400);
                }

                $tab.addClass('fade-highlight');
                setTimeout(() => $tab.removeClass('fade-highlight'), 300);
            }, 250);
        });
    }

    // Llama a la función de scroll adecuada al abrir una tab
    $('#tabContent .collapse').on('shown.bs.collapse', function () {
        const $tab = $(this);
        const $button = $('[data-target="#' + this.id + '"]');
        const isMobile = window.innerWidth < 1025;

        if (isMobile) {
            scrollToTabMobile($tab);
        } else {
            scrollToTabDesktop($button, $tab);
        }
    });

})();
</script>