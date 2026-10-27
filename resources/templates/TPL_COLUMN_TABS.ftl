<#-- productos-y-servicios  -->
<#-- ESTRUCTURA EST_COLUMN_TABS -->

<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
<#assign classPk = .vars["reserved-article-id"].data />
<#assign globalIndex = 0 />
<#assign secondIndex = 0 />
<#assign padreIndex = 0 />

<#if Group.getSiblings()?has_content>
	<#list Group.getSiblings() as cur_Group>
		<#assign padreId = redsysService.getInstanceIdByReferenceByIndex(.vars["reserved-article-resource-prim-key"].data, "Group", padreIndex, locale) />
		<#assign anchorId = redsysService.getInstanceIdByReferenceByIndex(.vars["reserved-article-resource-prim-key"].data, "iconGroupTitle", padreIndex, locale) />
		<section class="column-tabs" id="column${padreId}">
			<div class="column-tabs__container container">
				<div class="column-tabs__container-columns">
					<div class="row">
						<div class="col-xl-5">
							<div class="column-tabs__left-column">
								<#if (title.getData()?trim?has_content) || (description.getData()?trim?has_content)>
									<div class="column-tabs__content">
										<#if title.getData()?trim?has_content>
											<h2 class="column-tabs__title" id="${anchorId}">
												<#if (cur_Group.iconGroupTitle.getData())??>
													${cur_Group.iconGroupTitle.getData()}
												</#if>
											</h2>
										</#if>
										<#if (description.getData()?trim?has_content)>
											<div class="column-tabs__description">
												<#if (cur_Group.descriptionGroup.getData())??>
													${cur_Group.descriptionGroup.getData()}
												</#if>
											</div>
										</#if>
									</div>
								</#if>
							</div>
						</div>

						<div class="col-xl-7">
							<div class="column-tabs__right-column">
								<div class="column-tabs__group">
									<#if cur_Group.iconGroup.getSiblings()?has_content>
										<#list cur_Group.iconGroup.getSiblings() as cur_iconGroup>
											<#if cur_iconGroup.iconTitle.getData()?has_content>
												<#if cur_iconGroup_index % 5 == 0>
													<div class="row column-tabs__list-icon" id="tabsList" role="tablist">
												</#if>
												<div class="col-auto column-tabs__item d-xl-block d-none" role="presentation">
													<#assign id = redsysService.getInstanceIdByReferenceByIndex(.vars["reserved-article-resource-prim-key"].data, "iconTitle", globalIndex, locale) />
													<button title="ESCRITORIO" id="${id}" aria-controls="navigationCollapse" aria-expanded="false" data-target="#navigationCollapse${id}" data-toggle="collapse" type="button" role="tab" class="column-tabs__icon-button column-tabs__icon-button-class${classPk}">
														<#if (cur_iconGroup.iconImage.getData())?? && cur_iconGroup.iconImage.getData() != "">
															<#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_iconGroup.iconImage.getAttribute("title") />
															<#if cur_iconGroup.iconImage.getAttribute("alt")?trim?has_content>
																<#assign altImg = cur_iconGroup.iconImage.getAttribute("alt") />
															</#if>
															<img class="column-tabs__icon column-tabs__icon-class${classPk}" alt="${altImg}" data-fileentryid='${cur_iconGroup.iconImage.getAttribute("fileEntryId")}' src="${cur_iconGroup.iconImage.getData()}" />
														</#if>
														<#if (cur_iconGroup.iconTitle.getData()?trim?has_content)>
																<h3 class="column-tabs__icon-title">${cur_iconGroup.iconTitle.getData()}</h3>
															</#if>
													</button>
												</div>
												<#if (cur_iconGroup_index + 1) % 5 == 0 || cur_iconGroup_index == cur_Group.iconGroup.getSiblings()?size - 1>
													</div>
												</#if>
												<#assign globalIndex = globalIndex + 1 />
											</#if>
										</#list>
									</#if>
								</div>
								<div class="column-tabs__tab-content" id="columnContent${classPk}" role="list">
									<#if cur_Group.iconGroup.getSiblings()?has_content>
										<#list cur_Group.iconGroup.getSiblings() as cur_iconGroup>
											<#if cur_iconGroup.iconTitle.getData()?has_content>
												<#assign id = redsysService.getInstanceIdByReferenceByIndex(.vars["reserved-article-resource-prim-key"].data, "iconTitle", secondIndex, locale) />
												<div class="column-tabs__card" role="listitem">
													<#if (cur_iconGroup.iconImage.getData()?trim?has_content) || (cur_iconGroup.iconTitle.getData()?trim?has_content)>
														<div class="column-tabs__card-header d-xl-none" id="heading${cur_iconGroup?index}">
															<button title="movileee" aria-controls="collapseTab${id}" id="${id}" aria-expanded="false" class="column-tabs__button" data-target="#navigationCollapse${id}" data-toggle="collapse" type="button" role="tab">
																<#if (cur_iconGroup.iconImage.getData())?? && cur_iconGroup.iconImage.getData() != "">
																	<#assign altImg = languageUtil.get(locale, "img-auxiliar-alt") + " " + cur_iconGroup.iconImage.getAttribute("title") />
																	<#if cur_iconGroup.iconImage.getAttribute("alt")?trim?has_content>
																		<#assign altImg = cur_iconGroup.iconImage.getAttribute("alt") />
																	</#if>
																	<img class="column-tabs__icon column-tabs__icon-class${classPk}" alt="${altImg}" data-fileentryid='${cur_iconGroup.iconImage.getAttribute("fileEntryId")}' src="${cur_iconGroup.iconImage.getData()}" />
																</#if>
																<#if cur_iconGroup.iconTitle.getData()?trim?has_content>
																		<div class="column-tabs__icon-title">${cur_iconGroup.iconTitle.getData()}</div>
																	</#if>
																	<i class="toggle-icon"></i>
															</button>
														</div>
													</#if>
													<div class="collapse navbar-collapse" id="navigationCollapse${id}" data-parent="#column${padreId}">
														<div class="column-tabs__card-body">
															<#if (cur_iconGroup.titleDropdown.getData()?trim?has_content)>
																	<div class="column-tabs__tab-title">
																		${cur_iconGroup.titleDropdown.getData()}
																	</div>
																</#if>
																<#if cur_iconGroup.descriptionDropdown.getData()?trim?has_content>
																	<div class="column-tabs__tab-description">
																		${cur_iconGroup.descriptionDropdown.getData()}
																	</div>
																</#if>
														</div>
													</div>
												</div>
												<#assign secondIndex = secondIndex + 1 />
											</#if>
										</#list>
									</#if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<#assign padreIndex = padreIndex + 1 />
	</#list>
</#if>

<script>
function isMobile() {
    return window.innerWidth < 1199.98;
}

function scrollToFixedPosition($button) {
    const headerOffset = isMobile() ? 92 : 200;
    const scrollTarget = $button.offset().top - headerOffset;
    window.scrollTo({
        top: Math.max(0, scrollTarget),
        behavior: 'smooth'
    });
}

function scrollIfNeeded($button, $panel) {
    const headerOffset = isMobile() ? 92 : 200;
    if (!isMobile()) {
        const $section = $button.closest('section.column-tabs');
        const sectionTop = $section.offset().top;
        window.scrollTo({
            top: Math.max(0, sectionTop - headerOffset),
            behavior: 'smooth'
        });
    } else {
        const $section = $button.closest('section.column-tabs');
        const $h2 = $section.find('.column-tabs__title').first();
        const h2Top = $h2.offset().top;
        const buttonTop = $button.offset().top;
        const buttonHeight = $button.outerHeight(true);
        const panelHeight = $panel.outerHeight(true);
        const h2Height = $h2.outerHeight(true);
        const viewportHeight = window.innerHeight;
        const spacing = 32;
        const totalContentHeight = h2Height + (buttonTop - h2Top) + buttonHeight + panelHeight;
        const canFitAll = totalContentHeight + headerOffset + spacing <= viewportHeight;
        const scrollTarget = canFitAll ? h2Top - headerOffset : buttonTop - headerOffset;
        window.scrollTo({
            top: Math.max(0, scrollTarget),
            behavior: 'smooth'
        });
    }
}

function closeAllTabs(callback) {
    const $open = $('.column-tabs .collapse.show');
    if ($open.length === 0) {
        callback();
    } else {
        let closedCount = 0;
        $open.each(function () {
            $(this).one('hidden.bs.collapse', function () {
                closedCount++;
                if (closedCount === $open.length) {
                    callback();
                }
            }).collapse('hide');
        });
    }
}

function openTabByButton($button, scrollAfterOpen = true) {
    const panelId = $button.attr('data-target');
    const $panel = $(panelId);
    if ($panel.length === 0) return;
    $button.addClass('active').attr('aria-expanded', 'true');
    $button.find('.column-tabs__icon').addClass('active-icon');
    $panel.one('shown.bs.collapse', function () {
        if (scrollAfterOpen) {
            scrollIfNeeded($button, $panel);
        }
    });
    $panel.collapse('show');
    setTimeout(() => {
        if (!$panel.hasClass('show')) {
            $panel.collapse('show');
        }
    }, 500);
}

function tryOpenTabFromHash() {
    const hash = window.location.hash;
    if (!hash) return;
    const id = hash.substring(1);
    let attempts = 0;
    const maxAttempts = 20;
    const tryFindAndOpen = () => {
        const $button = isMobile()
            ? $('.column-tabs__button#' + CSS.escape(id))
            : $('.column-tabs__icon-button#' + CSS.escape(id));
        if ($button.length > 0) {
            suppressScrollOnce = true;
            closeAllTabs(() => {
                scrollToFixedPosition($button);
                openTabByButton($button, false);
            });
        } else if (attempts < maxAttempts) {
            attempts++;
            setTimeout(tryFindAndOpen, 100);
        }
    };
    setTimeout(tryFindAndOpen, 200);
}

$(document).ready(function () {
    window.suppressScrollOnce = !!window.location.hash;
    tryOpenTabFromHash();
    const $section = $('section.column-tabs');
    $section.on('shown.bs.collapse', function (e) {
        const panelId = e.target.id;
        const $button = $('[data-target="#' + panelId + '"]').filter(':visible');
        const $panel = $('#' + panelId);
        $button.addClass('active').attr('aria-expanded', 'true');
        $button.find('.column-tabs__icon').addClass('active-icon');
        if (!window.suppressScrollOnce) {
            scrollIfNeeded($button, $panel);
        }
        window.suppressScrollOnce = false;
    });
    $section.on('hidden.bs.collapse', function (e) {
        const panelId = e.target.id;
        const $button = $('[data-target="#' + panelId + '"]');
        $button.removeClass('active').attr('aria-expanded', 'false');
        $button.find('.column-tabs__icon').removeClass('active-icon');
    });
    $section.on('click', '.column-tabs__button, .column-tabs__icon-button', function (e) {
        const $button = $(this);
        const $targetPanel = $($button.attr('data-target'));
        if (!$targetPanel.hasClass('show')) {
            e.preventDefault();
            closeAllTabs(() => {
                const shouldScroll = !window.suppressScrollOnce;
                openTabByButton($button, shouldScroll);
                window.suppressScrollOnce = false;
            });
        }
    });
    $('a[href^="#"]').on('click', function (e) {
        const targetHash = this.getAttribute('href');
        if (!targetHash || targetHash === '#') return;
        const id = targetHash.substring(1);
        const $button = $('#' + CSS.escape(id)).filter('.column-tabs__button, .column-tabs__icon-button');
        if ($button.length > 0) {
            e.preventDefault();
            if (history.pushState) {
                history.pushState(null, null, targetHash);
            } else {
                location.hash = targetHash;
            }
            window.suppressScrollOnce = true;
            setTimeout(() => {
                closeAllTabs(() => {
                    scrollToFixedPosition($button);
                    openTabByButton($button, false);
                });
            }, 100);
        }
    });
    window.addEventListener('hashchange', tryOpenTabFromHash);
});
</script>