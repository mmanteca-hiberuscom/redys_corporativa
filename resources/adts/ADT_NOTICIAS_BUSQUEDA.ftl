<!-- Plantilla de barra de búsqueda Noticias del sector -->

<section class="search-wrapper-news">
  <div class="input-group search-bar-news">
    <div class="input-group-item search-bar-keywords-input-wrapper">
      <input id="searchInputNoticias"
        type="text"
        class="search-bar-empty-search-input form-control input-group-inset input-group-inset-after search-bar-keywords-input"
        name="faq-search"
        placeholder="<@liferay.language key='search-keyword' />..."
        aria-label="<@liferay.language key='search-keyword' />" />

      <div class="input-group-inset-item input-group-inset-item-after">
        <svg class="lexicon-icon lexicon-icon-search" role="presentation"></svg>

        <button id="clearSearchBtn"
          type="button"
          class="btn-search-close"
          aria-label="<@liferay.language key='clean-search' />">
          &times;
        </button>
      </div>
    </div>
  </div>
</section>

<script>
	$(document).ready(function () {
		const $input = $('#searchInputNoticias');
		const $clearBtn = $('#clearSearchBtn');
		const $entries = $('.entry');
		const $slider = $('.js-news-slider');
		const $noResultsContainer = $('#noResultsMessageContainer');
		const $categoryContainer = $('#categorySlider');

		const originalEntries = Array.from($entries);
		const originalCategorySlides = $categoryContainer.children('.category-slide').clone();

		$noResultsContainer.hide();

		setTimeout(() => {
			const $firstVisible = $('.category-slide:visible .category__slider-link').first();
			if ($firstVisible.length) {
				const selectedCategory = $firstVisible.data('category');
				$('.category__slider-link').removeClass('active');
				$firstVisible.addClass('active');
				reloadSlider($slider, selectedCategory, originalEntries);
			}
		}, 30);

		function normalizar(texto) {
			return texto.trim().toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
		}

		function bindCategoryEvents() {
			$('.category__slider-link').off('click').on('click', function () {
				const selectedCategory = $(this).data('category');
				if ($(this).hasClass('active')) return;

				$('.category__slider-link').removeClass('active');
				$(this).addClass('active');

				$entries.show().attr('data-visible', true);
				$noResultsContainer.hide();

				reloadSlider($slider, selectedCategory, originalEntries);
			});
		}

		function filtrar(term) {
			$categoryContainer.empty().append(originalCategorySlides.clone());
			bindCategoryEvents();

			const normalizado = normalizar(term);
			const categoriasConResultados = new Set();
			const nuevasEntries = [];

			originalEntries.forEach(function (entryNode) {
				const $entry = $(entryNode);
				const contenido = normalizar($entry.text());
				const coincide = contenido.includes(normalizado);

				$entry.attr('data-visible', coincide);

				if (coincide) {
					nuevasEntries.push(entryNode);
					const catId = $entry.data('category');
					if (catId) categoriasConResultados.add(String(catId));
				}
			});

			$('.category__slider-link').removeClass('active');

			if (nuevasEntries.length > 0) {
				$noResultsContainer.hide();

				$('.category-slide').each(function () {
					const $link = $(this).find('.category__slider-link');
					const catId = $link.data('category');
					if (!categoriasConResultados.has(String(catId))) {
						$(this).remove();
					}
				});

				const $firstVisible = $('.category-slide:visible .category__slider-link').first();
					if ($firstVisible.length) {
						const selectedCategory = $firstVisible.data('category');
						$firstVisible.addClass('active');

						const noticiasFiltradas = nuevasEntries.filter(entry =>
							entry.getAttribute('data-category') === String(selectedCategory)
						);

						if ($slider.hasClass('slick-initialized')) {
							$slider.slick('unslick');
							$slider.closest('.news-section-slider').find('.slick-arrow').remove();
						}

						$slider.empty();
						noticiasFiltradas.forEach(entry => $slider.append(entry));
						initSlickNews();
					}

			} else {
				$categoryContainer.empty();
				originalCategorySlides.each(function () {
					const catId = $(this).find('.category__slider-link').data('category');
					const tieneNoticias = originalEntries.some(entry =>
						entry.getAttribute('data-category') === String(catId)
					);
					if (tieneNoticias) {
						$categoryContainer.append($(this));
					}
				});

				bindCategoryEvents();
				$('.category__slider-link').removeClass('active');

				if ($slider.hasClass('slick-initialized')) {
					$slider.slick('unslick');
					$slider.closest('.news-section-slider').find('.slick-arrow').remove();
				}

				$slider.empty();
				$noResultsContainer.show();
			}

			if (typeof updateSlides === 'function') updateSlides();
		}

		function reloadSlider(container, categoryId, entriesArray) {
			let filtered = entriesArray;
			if (categoryId !== null) {
				filtered = entriesArray.filter(entry =>
					entry.getAttribute("data-category") === String(categoryId)
				);
			}

			if (container.hasClass("slick-initialized")) {
				container.slick("unslick");
				container.closest('.news-section-slider').find('.slick-arrow').remove();
			}

			container.empty();

			if (filtered.length === 0) {
				$noResultsContainer.show();
				return;
			}

			filtered.forEach(entry => container.append(entry));
			initSlickNews();
		}
		
		function resetBusqueda() {
			$categoryContainer.empty().append(originalCategorySlides.clone());
			bindCategoryEvents();

			$input.val('');
			$clearBtn.hide();
			$noResultsContainer.hide();

			originalEntries.forEach(function (entry) {
				const $entry = $(entry);
				$entry.attr('data-visible', true);
			});

			const $firstVisible = $('.category-slide:visible .category__slider-link').first();
			if ($firstVisible.length) {
				const selectedCategory = $firstVisible.data('category');
				$('.category__slider-link').removeClass('active');
				$firstVisible.addClass('active');
				reloadSlider($slider, selectedCategory, originalEntries);
			}

			if (typeof updateSlides === 'function') updateSlides();
		}

		function initSlickNews() {
			if (typeof $().slick !== 'function') return;
			if (isEditMode() || !isVisible('.js-news-slider')) return;

			try {
				$('.js-news-slider').each(function () {
					const $slider = $(this);
					const numSlides = $slider.children('.entry:visible').length;

					if (numSlides === 0) {
						return;
					}

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

					if (numSlides <= 1) {
						$slider.closest('.news-section-slider').find('.slick-arrow').hide();
					}
				});
			} catch (error) {
				console.warn('initSlickNews error:', error);
			}
		}

		function isEditMode() {
			return $('body').hasClass('has-edit-mode-menu');
		}

		function isVisible(selector) {
			return $(selector).is(':visible');
		}

		$input.on('keydown', function (e) {
			if (e.key === 'Enter') {
				e.preventDefault();
				filtrar($input.val());
			}
		});

		$input.on('input', function () {
			const val = $input.val().trim();
			$clearBtn.toggle(val.length > 0);
			if (val.length === 0) {
				resetBusqueda();
			}
		});

		$clearBtn.on('click', resetBusqueda);

		$(document).on('click', function (e) {
			const $componenteNoticias = $('.search-wrapper-news, .category-section, .news-section-slider');
			if ($componenteNoticias.filter(function () {
				return $(this).has(e.target).length > 0 || this === e.target;
			}).length === 0) {
				if ($input.val().trim() !== '') {
					resetBusqueda();
				}
			}
		});

		window.syncNoticiasConCategoria = function (selectedCategory) {
			reloadSlider($slider, selectedCategory, originalEntries);
		};

		bindCategoryEvents();
	});
</script>