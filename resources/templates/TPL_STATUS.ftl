<section class="service-status" role="region" aria-labelledby="service-status-title">
  <div class="service-status__container">

    <div class="service-status__box">

      <#if (SelectColor?? && SelectColor.getData()?has_content) || (titleStatus?? && titleStatus.getData()?has_content)>
        <div class="service-status__header">
          <#assign statusClass = SelectColor.getData()!"success" />
          <#if SelectColor?? && SelectColor.getData()?has_content>
            <i class="service-status__status-ball ${statusClass}"></i>
          </#if>
          <#if titleStatus?? && titleStatus.getData()?has_content>
            <div id="service-status-title" class="service-status__title">
              ${titleStatus.getData()}
            </div>
          </#if>
        </div>
      </#if>

      <#if descriptionStatus?? && descriptionStatus.getData()?has_content>
        <div class="service-status__description">
          ${descriptionStatus.getData()}
        </div>
      </#if>

      <#if descriptionError?? && descriptionError.getData()?has_content>
        <div class="service-status__error">
						<i class="service-status__error-icon"></i>
						${descriptionError.getData()}
				</div>
      </#if>

      <#if dateTimeStatus?? && dateTimeStatus.getData()?has_content>
  <div class="service-status__date-time">
    <#assign dateTimeParts = dateTimeStatus.getData()?split(" ")>
    <#if (dateTimeParts?size > 0)>
      <time class="service-status__date">${dateTimeParts[0]}</time>
    </#if>
    <#if (dateTimeParts?size > 1)>
      <span class="service-status__time">${dateTimeParts[1]}</span>
    </#if>
  </div>
</#if>

    </div>

    <#if titleButtonStatus?? && titleButtonStatus.getData()?has_content>
  <div class="service-status__button">
    
    <#-- Estado -->
    <#assign statusClass = SelectColor.getData()!"success" />
    <#if SelectColor?? && SelectColor.getData()?has_content>
      <i class="service-status__status-ball ${statusClass}"></i>
    </#if>

    <#-- Icono de error si hay alerta -->
    <#if descriptionError?? && descriptionError.getData()?has_content>
      <i class="service-status__error-icon--inline"></i>
    </#if>

    ${titleButtonStatus.getData()}
    <i class="service-status__arrow-icon"></i>
  </div>
</#if>

  </div>
</section>
