<!-- Plantilla de Publicador de contenidos Noticias del Sector -->

<#assign AssetCategoryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryLocalService")>
<#assign categories = AssetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle", entry.classPK?number) />

<section class="news-section-slider" aria-labelledby="noticias-sector">
    <div class="js-news-slider news-cards" >				
        <#list entries as entry>
            <#assign
        assetRenderer = entry.getAssetRenderer()
        journalArticle = assetRenderer.getArticle()
        categories = AssetCategoryLocalService.getCategories("com.liferay.journal.model.JournalArticle", entry.classPK?number)
        tpl_noticias = "TPL_NOTICIAS"
        entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale))
    />

    <#if categories?has_content>
        <div class="entry" data-category="${categories[0].categoryId}">
            <@liferay_journal["journal-article"]
                articleId=journalArticle.getArticleId()
                ddmTemplateKey=tpl_noticias
                groupId=journalArticle.getGroupId()
            />
        </div>
    </#if>
        </#list>
    </div>
</section>
	
<script>
	function initSlickNews() {
		if (typeof $().slick !== 'function') return;
		if (isEditMode()) return;

		try {
			if ($.fn.slick && $.fn.slick.defaults && $.fn.slick.defaults.initADA) {
				$.fn.slick.defaults.initADA = function () {};
			}

			$('.js-news-slider').each(function () {
				const $slider = $(this);
				const $slides = $slider.children('.entry');

				if ($slides.length === 0 || !$slides.first().is(':visible')) return;

				$slider.slick({
					dots: false,
					arrows: true,
					slidesToShow: 4,
					slidesToScroll: 1,
					infinite: false,
					responsive: [
						{ breakpoint: 1199.98, settings: { slidesToShow: 3 } },
						{ breakpoint: 820.98, settings: { slidesToShow: 2 } },
						{ breakpoint: 559.98, settings: { slidesToShow: 1, arrows: false } }
					]
				});
			});
		} catch (error) {
			console.warn('initSlickNews error:', error);
			setTimeout(() => {
				try {
					$('.js-news-slider').slick('unslick');
				} catch (e) {}
				initSlickNews();
			}, 100);
		}
	}

	function isEditMode() {
		return document.body.classList.contains('has-edit-mode-menu');
	}

	function isVisible(selector) {
		return $(selector).is(':visible');
	}

	Liferay.on('allPortletsReady', () => {
		setTimeout(() => {
			const $slider = $('.js-news-slider');
			const $entries = $slider.children('.entry');

			if ($entries.length > 0) {
				initSlickNews();
			}
		}, 100);
	});
</script>