<#--PLANTILLA DE CARDS DE CASOS DE ÉXITO (Landing)-->
    <#-- @Author Yordy Tafur -->
        <#-- ESTRUCTURA EST_CARRUSEL_CARDS -->
            <section class="success-cases container" aria-labelledby="success-title">
                <#if (mainTitle.getData())?? && mainTitle.getData()?trim !="">
                    <h2 id="success-title" class="success-cases__title">
                        ${mainTitle.getData()}
                    </h2>
                </#if>
                <#if (mainDescription.getData())?? && mainDescription.getData()?trim !="">
                    <div class="success-cases__description" aria-live="polite">
                        ${mainDescription.getData()}
                    </div>
                </#if>
                <#if sectionGroup.getSiblings()?has_content>
                    <div class="success-cases__container">
                        <div class="success-cases__slider js-slider-cards">
                            <#list sectionGroup.getSiblings() as cur_sectionGroup>
                                <div class="success-card-wrapper">
                                   
                                    <#assign ariaLabel="" />
                                    <#if cur_sectionGroup.title.getData()?trim?has_content>
                                        <#assign ariaLabel="aria-label=\" ${cur_sectionGroup.title.getData()}\"" />
                                    </#if>
                                    <#assign classFirst="" />
																		<#if cur_sectionGroup.link.getData()?trim?has_content>
																		    <a class="success-card-link" href="${cur_sectionGroup.link.getData()}" >
																		<#else>
																		    <div class="success-card-link" >
																		</#if>
                                        <article class="success-card" >
                                            <#if (cur_sectionGroup.description.getData())?? && cur_sectionGroup.description.getData()?trim !="">
                                                <blockquote class="success-card__text" >
                                                    <i class="union-icon" aria-hidden="true"></i>
                                                    <div class="success-card__descript">
                                                        ${cur_sectionGroup.description.getData()}
                                                    </div>
                                                </blockquote>
                                            </#if>
                                            <footer class="success-card__footer">
                                                <#if (cur_sectionGroup.title.getData())?? && cur_sectionGroup.title.getData()?trim !="">
                                                    <span>
                                                        ${cur_sectionGroup.title.getData()}
                                                    </span>
                                                </#if>
                                            </footer>
                                        </article>
                                       <#if cur_sectionGroup.link.getData()?trim?has_content>
                                           </a>
                                       <#else>
                                           </div>
                                       </#if>
                                </div>
                            </#list>
                        </div>
                        <div class="success-cases__arrows">
                            <button aria-label='<@liferay.language key="slide-to-left" />'
                                class="slick-prev"
                                tabindex="0">
																<span class="visually-hidden"></span>
														</button>
                            <button aria-label='<@liferay.language key="slide-to-right" />'
                                class="slick-next"
                                tabindex="0"
                                type="button">
																<span class="visually-hidden"></span>
														</button>
                        </div>
                    </div>
                </#if>
            </section>
<script>
$(document).ready(function () {
  initSlickCard();

  function initSlickCard() {
    if (typeof $().slick === 'function' && !isEditMode() && isVisible('.js-slider-cards')) {
      try {
        if ($('.js-slider-cards').length > 0) {
          $('.js-slider-cards').slick({
            dots: false,
            arrows: true,
            slidesToShow: 4,
            slidesToScroll: 1,
            infinite: false,
            prevArrow: $('.slick-prev'),
            nextArrow: $('.slick-next'),
            variableWidth: false,
            responsive: [
              {
                breakpoint: 1200,
                settings: {
                  arrows: true,
                  dots: false,
                  slidesToShow: 3,
                  slidesToScroll: 1,
                }
              },
              {
                breakpoint: 1025,
                settings: {
                  arrows: true,
                  dots: false,
                  slidesToShow: 2,
                  slidesToScroll: 1,
                }
              },
              {
                breakpoint: 576,
                settings: {
                  arrows: false,
                  dots: true,
                  centerMode: true,
                  centerPadding: '0px',
                  slidesToShow: 1,
                  slidesToScroll: 1
                }
              }
            ]
          });
        }
      } catch (error) {
        console.log('Error al inicializar el slider: ' + error);
      }
    } else {
      setTimeout(initSlickCard, 10);
    }
  }

  // Función para igualar la altura de todos los textos de las cards
  function equalizeTextHeights() {
    var maxHeight = 0;

    $('.success-card__text').each(function () {
      $(this).css('height', 'auto'); // reset
      var height = $(this).outerHeight();
      if (height > maxHeight) {
        maxHeight = height;
      }
    });

    $('.success-card__text').each(function () {
      $(this).css('height', maxHeight + 'px');
    });
  }

  // Llamadas necesarias para aplicar y mantener la altura igualada
  $('.js-slider-cards').on('setPosition', equalizeTextHeights);
  $(window).on('resize', function () {
    setTimeout(equalizeTextHeights, 200); // debounce para rendimiento
  });
  setTimeout(equalizeTextHeights, 300); // llamada inicial tras renderizado
});

// Marcar activa una card en desktop
$('.js-slider-cards').on('click', '.success-card-wrapper', function () {
  if (window.innerWidth >= 576) {
    $('.success-card-wrapper').removeClass('active');
    $(this).addClass('active');
  }
});

// Resetear card activa al deslizar en desktop
$('.js-slider-cards').on('beforeChange', function (event, slick, currentSlide, nextSlide) {
  if (window.innerWidth >= 576) {
    $('.success-card-wrapper').removeClass('active');
  }
});

// Reset al hacer clic fuera de cualquier card (solo en desktop)
$(document).on('click', function (e) {
  if (window.innerWidth >= 576) {
    if (!$(e.target).closest('.success-card-wrapper').length) {
      $('.success-card-wrapper').removeClass('active');
    }
  }
});
</script>