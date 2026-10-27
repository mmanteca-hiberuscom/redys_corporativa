<#-- RECORREMOS EL CONJUNTO DE GUIAS. CADA GUIA ES UN NUEVO ELEMENTO DENTRO DE support__list (es decir, un
nuevo support__list-row) -->

<#if guidesGroup.getSiblings()?has_content>
  <section class="tab-panel-support__list-buttons">
		<div class="tab-panel-support__list">
	<#list guidesGroup.getSiblings() as currentGuide>
		<#assign nameOfGuide = "" />
		<#assign leftLinkLabel = "" />
		<#assign leftLinkURL = "" />
		<#assign rightLinkLabel = "" />
		<#assign rightLinkURL = "" />
		<#assign cleanUrl = "" />
		<#if currentGuide.guideName.getData()?trim?has_content>
		   <#assign nameOfGuide = currentGuide.guideName.getData() />
    </#if>
		<#if currentGuide.guideLinkLeftLabel.getData()?trim?has_content>
		   <#assign leftLinkLabel = currentGuide.guideLinkLeftLabel.getData() />
    </#if>
		<#if currentGuide.guideLeftDocument.getData()?has_content>
		   <#assign leftLinkURL = currentGuide.guideLeftDocument.getData() />
    </#if>
		<#if currentGuide.guideLinkRightLabel.getData()?trim?has_content>
		   <#assign rightLinkLabel = currentGuide.guideLinkRightLabel.getData() />
    </#if>
		<#if currentGuide.guideRightDocument.getData()?has_content>
		   <#assign rightLinkURL = currentGuide.guideRightDocument.getData() />
    </#if>
		<div class="row tab-panel-support__list-row">
		   <div class="col-12 col-md-6 col-lg-7 tab-panel-support__list-description">
           ${nameOfGuide}
       </div>
       <div class="col-12 col-md-6 col-lg-5 tab-panel-support__button-row">
          <#assign cleanUrl = leftLinkURL?split("?")[0] />
			    <a href="${cleanUrl}"
             target="_blank" download
			       class="cta-btn-white">
             ${leftLinkLabel}
          </a>
          <#assign cleanUrl = rightLinkURL?split("?")[0] />
			    <a href="${cleanUrl}"
             target="_blank" download
			       class="cta-btn-white">
             ${rightLinkLabel}
          </a>
       </div>
    </div>
	</#list>
	  </div>
	</section>
</#if>