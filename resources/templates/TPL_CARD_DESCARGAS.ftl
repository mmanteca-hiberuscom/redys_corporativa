<#-- TPL_CARD_DESCARGAS (Canal Ético, Empleo, Información Corporativa) -->
<#-- estructura - EST_CARD_DESCARGAS -->
<#-- @author Alban Loubet -->

<#function normalize text>
	<#return text?replace(" ", "-")?lower_case?replace("?", "" )?replace("!", "" )?replace("á", "a" )?replace("é", "e"
		)?replace("í", "i" )?replace("ó", "o" )?replace("ú", "u" )>
</#function>

<#assign normalizedText="" />
<#assign originalText="" />
<#assign has_background=false />

<#if titleLabel.getData()?has_content>
    <#assign originalText=titleLabel.getData() />
	<#assign normalizedText=normalize(originalText) />
</#if>

<#if cardGroup.getSiblings()?has_content>
    <#list cardGroup.getSiblings() as currentCardGroup>
		<#if (cardGroup.cardBackgroundColor.getData())?has_content>
	     <#assign has_background=true />
    </#if>
    </#list>
</#if>

<#assign buttonCount=0 />
<#assign section_variant="" />
<#assign buttonCount=cardGroup.linkGroup.getSiblings()?size />

<#if buttonCount==0>
   <#assign section_variant="card-descargas--second" />
<#elseif buttonCount==1>
   <#assign section_variant="card-descargas--first" />
<#else>
   <#assign section_variant="card-descargas--third" />
</#if>

<#if has_background && section_variant!="card-descargas--second">
	<#assign section_variant +=" card-descargas--second" />
</#if>

<#assign sectionTitleID = "${normalizedText}-title${.vars['reserved-article-id'].data}" />

<section aria-labelledby="${sectionTitleID}" class="card-descargas ${section_variant}">
  
	<div class="container">
		<#if originalText?has_content>
			<h2 class="card-descargas__title" id="${sectionTitleID}">
				${originalText}
			</h2>
		</#if>
		<div class="row">
			<#assign col_class="col-xl-3 col-12" />
				<#if (numberOfCards.getData())??>
					<#if (numberOfCards.getData())=="three-columns">
						<#assign col_class="col-xl-4 col-12" />
					</#if>
				</#if>
				
				<#if cardGroup.getSiblings()?has_content>
					<#list cardGroup.getSiblings() as currentCardsGroup>
						<#assign cardStyle="" />
						  <#if (cardGroup.cardBackgroundColor.getData())?has_content || (cardGroup.cardBorderColor.getData())?has_content>
								<#assign cardStyle="style= ' " />
									<#if (cardGroup.cardBackgroundColor.getData())?has_content>
									  <#assign cardStyle +="background-color: ${currentCardsGroup.cardBackgroundColor.getData()};" />
								  </#if>
								  <#if (cardGroup.cardBorderColor.getData())?has_content>
									  <#assign cardStyle	+="border-color: ${currentCardsGroup.cardBorderColor.getData()};" />
								  </#if>
									<#assign cardStyle += " ' " />
							</#if>
							<div class="${col_class}">
								<article class="card-descargas__card" ${cardStyle}>
									<#if (currentCardsGroup.cardTitleLabel.getData())??>
										<div class="card-descargas__card-title">
											${currentCardsGroup.cardTitleLabel.getData()}
										</div>
									</#if>
									<#if (currentCardsGroup.cardSubtitleText.getData())?has_content>
										<div class="card-descargas__card-content">
											${currentCardsGroup.cardSubtitleText.getData()}
										</div>
									<#else>
									  <#assign buttonCount=0 />
									<#if currentCardsGroup.linkGroup.getSiblings()?has_content>
	                   <#assign buttonCount=currentCardsGroup.linkGroup.getSiblings()?size />
                  </#if>
										<#if buttonCount gt 1>
										   <div class="card-descargas__card-buttons">
											    <@generateLinks linkGroup=currentCardsGroup.linkGroup />
											 </div>
										<#else>
										  <@generateOneLink linkGroup=currentCardsGroup.linkGroup />
										</#if>	
									</#if>
								</article>
							</div>
					</#list>
				</#if>
		</div>
	</div>
</section>

<#macro generateLinks linkGroup>
    <#list linkGroup.getSiblings() as currentCardLink>
        <#assign index = currentCardLink_index />
        <#if currentCardLink.linkLabel.getData()?has_content && index lt 2>
            <a class="cta-btn-white" href="${currentCardLink.linkURL.getData()}" role="button" aria-label="${currentCardLink.linkLabel.getData()}" target="_blank" >
                ${currentCardLink.linkLabel.getData()}
            </a>
        </#if>
    </#list>
</#macro>

<#macro generateOneLink linkGroup>
    <#list linkGroup.getSiblings() as	currentCardLink>
				<#if currentCardLink.linkLabel.getData()?has_content>
						<a class="cta-btn-white" href="${currentCardLink.linkURL.getData()}" role="button" aria-label="${currentCardLink.linkLabel.getData()}" target="_blank" >
						   ${currentCardLink.linkLabel.getData()}
						</a>
				</#if>	
		</#list>
</#macro>