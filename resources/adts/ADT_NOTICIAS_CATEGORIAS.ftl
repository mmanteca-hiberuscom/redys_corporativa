<#assign groupId      = themeDisplay.getScopeGroupId() />
<#assign structureKey = "EST-NOTICIAS" />

<#if serviceLocator??>

    <#-- ▸ Servicios ------------------------------------------------>
    <#assign journalArticleLocalService =
            serviceLocator.findService(
            "com.liferay.journal.service.JournalArticleLocalService") />
    <#assign assetEntryLocalService =
            serviceLocator.findService(
            "com.liferay.asset.kernel.service.AssetEntryLocalService") />
    <#assign ddmStructureLocalService =
            serviceLocator.findService(
            "com.liferay.dynamic.data.mapping.service.DDMStructureLocalService") />
    <#assign classNameLocalService =
            serviceLocator.findService(
            "com.liferay.portal.kernel.service.ClassNameLocalService") />

    <#-- ▸ Constante estado aprobado -------------------------------->
    <#assign STATUS_APPROVED = 0 />

    <#-- 1 ▸ obtener structureId de "EST_Noticas" ------------------>
    <#assign classNameId =
            classNameLocalService.getClassNameId(
                "com.liferay.journal.model.JournalArticle") />
    <#assign ddmStructure =
            ddmStructureLocalService.fetchStructure(
                groupId, classNameId, structureKey) />

    <#if ddmStructure??>
        <#assign structureId = ddmStructure.getStructureId() />

        <#-- 2 ▸ artículos de esa estructura (sin paginación) -------->
        <#assign allArticles =
                journalArticleLocalService.getStructureArticles(
                    groupId, structureId) />

        <#-- 3 ▸ mapa categoryId → usos ----------------------------->
        <#assign catUsage = {} />

        <#list allArticles as ja>
            <#if ja.getStatus() == STATUS_APPROVED>
                <#assign ae = assetEntryLocalService.getEntry(
                        "com.liferay.journal.model.JournalArticle",
                        ja.getResourcePrimKey()) />
                <#list ae.getCategories() as cat>
                    <#assign idStr  = cat.getCategoryId()?string />
                    <#assign newCnt = (catUsage[idStr]!0) + 1 />
                    <#assign catUsage = catUsage + { (idStr): newCnt } />
                </#list>
            </#if>
        </#list>
    <#else>
        <#-- la estructura no existe → mapa vacío ------------------->
        <#assign catUsage = {} />
    </#if>

<#else>
    <#-- serviceLocator restringido → mapa vacío ------------------->
    <#assign catUsage = {} />
</#if>

<#assign hasCategories = false />
<#assign currentCategoryId = (renderRequest.getParameter("categoryId")!"" )?string >

<section class="category-section" aria-labelledby="noticias-sector">

	<div id="noResultsMessageContainer" style="display: none;" aria-live="polite" class="alert alert-info w-100 text-center mb-5">
		<@liferay.language key='no-results-search' />
	</div>
	
    <#if entries?has_content>
		<#list entries as entry>
			<#assign categories = entry.getCategories() />
                <#if categories?has_content>
                    <#assign hasCategories = true />
                        <@displayCategories categories=categories />
                </#if>
		</#list>

		<#if !hasCategories>
			${renderRequest.setAttribute("PORTLET_CONFIGURATOR_VISIBILITY", true)}
			<div class="alert alert-info w-100">
				<@liferay_ui.message key="there-are-no-categories" />
			</div>
		</#if>
    </#if>
</section>
	
<#macro displayCategories categories>
	<#if categories?has_content>
		<div class="category-container">
			<button class="slider-arrow slider-prev" aria-label="<@liferay.language key='slide-to-left' />" onclick="prevSlide()"></button>

			<ul class="category__slider js-category-slider" id="categorySlider" role="list">
				<#list categories as category>
					<#assign usos = catUsage[category.getCategoryId()?string]!0 />
            	<#if usos gt 0>
								<#assign categoryURL = renderResponse.createRenderURL() />
									${categoryURL.setParameter("resetCur", "true")}
									${categoryURL.setParameter("categoryId", category.getCategoryId()?string)}
								<#assign activeClass = "" />
								
								<#if (currentCategoryId?has_content && currentCategoryId == category.getCategoryId()?string)>
									<#assign activeClass = "active" />
								</#if>

								<li class="category-slide">
									<div id="${category.getCategoryId()}" 
											 data-category="${category.getCategoryId()}" 
											 class="category__slider-link" 
											  
											 aria-controls="${category.getCategoryId()}" 
											 aria-selected="false">
										${category.getTitle(locale)}
									</div>
								</li>
								<#if serviceLocator??>
									<#assign
													 assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService")
													 childCategories = assetCategoryService.getChildCategories(category.getCategoryId())
													 />

										<@displayCategories categories=childCategories />
								</#if>
						</#if>
				</#list>
			</ul>
			<button class="slider-arrow slider-next"  aria-label="<@liferay.language key='slide-to-right' />" onclick="nextSlide()"></button>
			<input type="hidden" id="pageNum" value="1" />
		</div>
	</#if>
</#macro>

<script>
	let currentIndex = 0;
	let slideDirection = 'next';

	function getVisibleCount() {
		const w = window.innerWidth;
		if (w < 576) return 1;
		if (w < 899) return 2;
		if (w < 1200) return 3;
		return 4;
	}

	window.updateSlides = function () {
		const visibleCount = getVisibleCount();
		const slides = document.querySelectorAll("#categorySlider .category-slide");

		if (slides.length === 0) return;

		if (currentIndex + visibleCount > slides.length) {
			currentIndex = Math.max(0, slides.length - visibleCount);
		}

		slides.forEach((slide, index) => {
			slide.style.display = (index >= currentIndex && index < currentIndex + visibleCount)
				? "inline-block"
				: "none";
		});

		const activeBtn = document.querySelector('.category__slider-link.active');
		if (activeBtn) {
			const parentSlide = activeBtn.closest('.category-slide');
			const index = Array.from(slides).indexOf(parentSlide);

			if (index < currentIndex || index >= currentIndex + visibleCount) {
				document.querySelectorAll('.category__slider-link').forEach(btn => btn.classList.remove('active'));

				const visibleSlides = Array.from(slides).filter((_, i) => i >= currentIndex && i < currentIndex + visibleCount);
				let newActiveSlide = (slideDirection === "next")
					? visibleSlides[0]
					: visibleSlides[visibleSlides.length - 1];

				if (newActiveSlide) {
					const nextBtn = newActiveSlide.querySelector('.category__slider-link');
					nextBtn.classList.add('active');

					const selectedCategory = nextBtn.getAttribute("data-category");
					if (typeof window.syncNoticiasConCategoria === 'function') {
						window.syncNoticiasConCategoria(selectedCategory);
					}
				}
			}
		}
	}

	function prevSlide() {
		if (currentIndex > 0) {
			currentIndex--;
			slideDirection = 'prev';
			updateSlides();
		}
	}

	function nextSlide() {
		const visibleCount = getVisibleCount();
		const slides = document.querySelectorAll("#categorySlider .category-slide");

		if (currentIndex + visibleCount < slides.length) {
			currentIndex++;
			slideDirection = 'next';
			updateSlides();
		}
	}

	document.addEventListener("DOMContentLoaded", function () {
		const slider = document.getElementById("categorySlider");
		if (!slider) return;

		setTimeout(updateSlides, 10);
		window.addEventListener("resize", updateSlides);
	});
</script>