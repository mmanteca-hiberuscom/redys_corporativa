<#assign
	redsysService = serviceLocator.findService("com.redsys.service.ResysServiceImpl")
/>
<#assign AssetEntryLocalServiceUtil = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>

<script>
	if (!window.assetEntryIdsInPublisher) {
			window.assetEntryIdsInPublisher = new Set();
	}
</script>

<#if faqs_item.getSiblings()?has_content>
	<#list faqs_item.getSiblings() as cur_faqs>

		<#assign
			webContentData = jsonFactoryUtil.createJSONObject(cur_faqs.getData())
		/>
		<#assign assetEntry = AssetEntryLocalServiceUtil.getEntry("com.liferay.journal.model.JournalArticle", webContentData.classPK?number) />
		<#if webContentData?? && webContentData.title??>
	    <script>
        window.assetEntryIdsInPublisher.add("${assetEntry.entryId}");
    	</script>
			
			<div class="faqs-card">
    		<div class="faqs-card-header" id="heading${webContentData.classPK}">
					${redsysService.getImagenJournalArticleByField(webContentData.classPK,"icono","img-mono")}
						${redsysService.getImagenJournalArticleByField(webContentData.classPK,"iconosecundario","img-color")}
						
						<h3>
							<button class="accordion-button" type="button" id="btn-${assetEntry.entryId}"
								data-toggle="liferay-collapse"
								data-target="#collapse-${assetEntry.entryId}" aria-expanded="false" aria-controls="collapseOne">
																			${redsysService.getFieldByReference(webContentData.classPK,"pregunta",locale)}
								<i class="arrow-up"/>
							</button>
      			</h3>
    		</div>

				<div id="collapse-${assetEntry.entryId}" class="collapse accordion-collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
					<div class="card-body">
											${redsysService.getFieldByReference(webContentData.classPK,"respuesta",locale)}
					</div>
				</div>
  		</div>
		</#if>
	</#list>
</#if>

<script>
	$(document).ready(function () {
		const buttons = document.querySelectorAll(".faqs-card-header button");

		function isFullyVisible(element) {
			const rect = element.getBoundingClientRect();
			const headerOffset = 200;
			const viewTop = headerOffset;
			const viewBottom = window.innerHeight;

			return (
				rect.top >= viewTop &&
				rect.bottom <= viewBottom
			);
		}

		function scrollToEnsureVisibility(headerEl, panelEl) {
			const headerOffset = 200;
			const totalHeight = headerEl.offsetHeight + panelEl.offsetHeight;
			const topPos = headerEl.getBoundingClientRect().top + window.scrollY;

			const bottomEdge = topPos + totalHeight;
			const viewportTop = window.scrollY + headerOffset;
			const viewportBottom = window.scrollY + window.innerHeight;

			if (topPos < viewportTop || bottomEdge > viewportBottom) {
				window.scrollTo({
					top: topPos - headerOffset,
					behavior: "smooth"
				});
			}
		}

		buttons.forEach((button) => {
			button.addEventListener("click", () => {
				const targetSelector = button.getAttribute("data-target");
				const targetPanel = document.querySelector(targetSelector);
				const header = button.closest(".faqs-card-header");

				setTimeout(() => {
					const isExpanded = button.getAttribute("aria-expanded") === "true";

					document.querySelectorAll(".accordion-collapse").forEach((panel) => {
						if (panel !== targetPanel) {
							panel.classList.remove("show");
						}
					});

					document.querySelectorAll(".faqs-card-header").forEach((header) => {
						header.classList.remove("active");
					});

					if (isExpanded) {
						header.classList.add("active");

						scrollToEnsureVisibility(header, targetPanel);
					}
				}, 20);
			});
		});

		const hash = window.location.hash;

		if (hash && hash.startsWith("#btn-")) {
			const targetButton = document.querySelector(hash);

			if (targetButton) {
				setTimeout(() => {
					targetButton.click();

					const header = targetButton.closest(".faqs-card-header");
					const panelId = targetButton.getAttribute("data-target");
					const panel = document.querySelector(panelId);

					scrollToEnsureVisibility(header, panel);
				}, 300);
			}
		}
	});
</script>