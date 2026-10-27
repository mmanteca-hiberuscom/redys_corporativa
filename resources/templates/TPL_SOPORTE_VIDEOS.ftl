<#-- TPL_SOPORTE_VIDEOS (Soporte a comercios) -->
<#-- Estructura - STR_SOPORTE_VIDEOS -->
<#-- @author Alban Loubet Vergara -->

<#assign numberOfVideos = videoGroup.getSiblings()?size />
<section class="tab-panel-support__slide-video">
	<#assign idVideoCarousel = 'videoCarousel${.vars["reserved-article-id"].data}' />
	
	<div id="${idVideoCarousel}" class="carousel slide" data-touch="false" data-interval="false" data-wrap="false">
		<div class="carousel-inner">
			<#-- AQUÍ EMPIEZA A RECORRER EL BUCLE -->
			<#if videoGroup.getSiblings()?has_content>
				<#assign siblings = videoGroup.getSiblings()>
				<#assign total = siblings?size>
				<#assign totalGroups = (total / 8)?ceiling>
				<#list 0 .. (totalGroups - 1) as groupIndex>
					<#assign startIndex = groupIndex * 8>
					<#assign computed = startIndex + 7>
					<#assign maxIndex = total - 1>
					<#assign endIndex = computed>
					
					<#if computed gt maxIndex>
						<#assign endIndex = maxIndex>
					</#if>
					
					<#assign carouselItemClass="carousel-item active" />
					
					<#if groupIndex gt 0>
						<#assign carouselItemClass="carousel-item" />
					</#if>
					
					<div class="${carouselItemClass}">
						<#assign group = siblings[startIndex .. endIndex]>
						<#list 0 .. ((group?size - 1) / 2)?floor as pairIndex>
							<#assign startIndexPair=pairIndex * 2 />
							<#assign endIndexPair=startIndexPair + 1 />
							
							<#if endIndexPair gte group?size>
								<#assign endIndexPair=group?size - 1 />
							</#if>
							
							<div class="row tab-panel-support__slide-row">
								<#assign miniGroup=group[startIndexPair .. endIndexPair] />
									<#list miniGroup as subItem>
										<#assign videoName = "" />
										<#assign videoURL = "" />
										
										<#if (subItem.videoGroupTitle.getData())??>
											<#assign videoName =  subItem.videoGroupTitle.getData()/>
										</#if>
										
										<#if (subItem.videoGroupLink.getData())??>
											<#assign videoURL =  subItem.videoGroupLink.getData()/>
										</#if>
										
										<#if videoName?trim?has_content && videoURL?trim?has_content>
											<div class="col-12 col-lg-6">
												<div class="tab-panel-support__video-item">
													<i class="tab-panel-support__video-icon"></i>
													<a target="_blank" href="${videoURL}" class="tab-panel-support__video-link">
														${videoName}
													</a>
												</div>
											</div>
										</#if>
									</#list>
							</div>
						</#list>
					</div>
				</#list>
			</#if>
		</div>
		
		<#if numberOfVideos gt 8>
			<div class="tab-panel-support__arrows">
				<div class="carousel-control-prev" href="#${idVideoCarousel}" role="button" data-slide="prev">
					<i class="carousel-control-prev-icon" aria-hidden="true"></i>
					<span class="sr-only">Anterior</span>
				</div>
				<div class="carousel-control-next" href="#${idVideoCarousel}" role="button" data-slide="next">
					<i class="carousel-control-next-icon" aria-hidden="true"></i>
					<span class="sr-only">Siguiente</span>
				</div>
			</div>
		</#if>
	</div>
</section>

<script>
	$(document).ready(function () {
		$('.carousel').each(function () {
			var $carousel = $(this);
			var $prevBtn = $carousel.find('.carousel-control-prev');
			var $nextBtn = $carousel.find('.carousel-control-next');
			var $items = $carousel.find('.carousel-item');

			function updateArrows() {
				var $activeItem = $carousel.find('.carousel-item.active');
				var activeIndex = $items.index($activeItem);

				$prevBtn.removeClass('disabled');
				$nextBtn.removeClass('disabled');

				if (activeIndex === 0) {
					$prevBtn.addClass('disabled');
				}
				if (activeIndex === $items.length - 1) {
					$nextBtn.addClass('disabled');
				}
			}

			// Al iniciar
			updateArrows();

			// Al deslizar con Bootstrap
			$carousel.on('slid.bs.carousel', function () {
				updateArrows();
			});

			// Forzar actualización si no cambia de slide (clic en extremos)
			$prevBtn.on('click', function () {
				setTimeout(updateArrows, 100);
			});
			$nextBtn.on('click', function () {
				setTimeout(updateArrows, 100);
			});
		});
	});
</script>