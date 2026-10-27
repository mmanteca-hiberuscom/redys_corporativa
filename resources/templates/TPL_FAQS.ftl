<#assign
	redsysService = serviceLocator.findService("com.redsys.service.ResysServiceImpl")
/>
<#assign AssetEntryLocalServiceUtil = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>

<script>
if (!window.assetEntryIdsInPublisher) {
            window.assetEntryIdsInPublisher = new Set();
        }</script>

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
      <h6 >

        <button class="accordion-button" type="button" id="btn-${assetEntry.entryId}"
				data-toggle="liferay-collapse"
				data-target="#collapse-${assetEntry.entryId}" aria-expanded="true" aria-controls="collapseOne">
					        			      ${redsysService.getFieldByReference(webContentData.classPK,"pregunta",locale)}
					 <i class="arrow-up"/>

        </button>
      </h6>
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
    //script para hacer el cambio de color de los iconos 
    $(document).ready(function () {
        $(".faqs-card-header button").on("click", function () {
           var header = $(this).closest(".faqs-card-header"); // Encuentra el header más cercano
					 $('.accordion-button').attr('aria-expanded', 'false');
			     var isExpanded = $(this).attr("aria-expanded") === "true"; // Verificar si está abierto
    $(".faqs-card-header").removeClass("active");
			     if (!isExpanded) {
		        $('.accordion-collapse').removeClass('show');
				      header.addClass("active");
			     }
        });
    });
</script>