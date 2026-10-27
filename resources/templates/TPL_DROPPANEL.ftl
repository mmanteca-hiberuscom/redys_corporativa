<#-- PLANTILLA DE CARDS DE AÑOS  -->
<#-- @Author Yordy Tafur -->
<#-- ESTRUCTURA EST_DROPPANEL -->

<#assign classPK = .vars["reserved-article-id"].data />

<#if (yearGroup.year.getData()?trim?has_content)>
    <div class="droppanel container">
        <#if (yearGroup.year.getData()?trim?has_content)>
            <div class="d-block d-md-none mb-3">
                <div class="droppanel__select-container">


                    <button class="droppanel__select" id="mobile-select${classPK}">
                        <span id="selected-year${classPK}">${yearGroup.year.getData()}</span>
                        <i class="droppanel__icon"></i>
                    </button>

                    <ul class="droppanel__dropdown" id="mobile-dropdown${classPK}">
											<#list yearGroup.getSiblings() as cur_yearGroup>
													<li class="droppanel__dropdown-item" tabindex="0" role="list">
															${cur_yearGroup.year.getData()}
													</li>
											</#list>
									</ul>
                </div>
            </div>
        </#if>

        <#if (yearGroup.year.getData()?trim?has_content)>
            <div class="d-none d-md-block">
                <ul class="droppanel__list">
                    <#list yearGroup.getSiblings() as cur_yearGroup>
                        <li>
                            <#assign droppanelSelected="" />
                            <#if cur_yearGroup_index==0>
                                <#assign droppanelSelected="droppanel__option--selected${classPK}" />
                            </#if>
														<button class="droppanel__option${classPK} ${droppanelSelected}" tabindex="0"  
 														    data-target="#tab-${cur_yearGroup.year.getData()}-${classPK}" 
														    aria-controls="tab-${cur_yearGroup.year.getData()}-${classPK}">
														    ${cur_yearGroup.year.getData()}
														</button>

                        </li>
                    </#list>
                </ul>
                <hr class="droppanel__divider">
            </div>
        </#if>
    </div>
</#if>
<#if (yearGroup.year.getData()?trim?has_content)>
    <div id="yearTabsContent" class="droppanel__yearTabsContent" aria-live="polite">
			<div class="container">
        <#list yearGroup.getSiblings() as cur_yearGroup>
				<#assign classShow="" />
            <#if cur_yearGroup_index==0>
                <#assign classShow="show" />
            </#if>
            <div class="card-descargas card-descargas--first collapse tab-content${classPK} ${classShow}" data-parent="#yearTabsContent"
                id="tab-${cur_yearGroup.year.getData()}-${classPK}">

                <div class="card-descargas__container">
                    <div class="row">
                        <#list cur_yearGroup.cardGroup.getSiblings() as cur_yearGroup_cardGroup>
                            <#if (cur_yearGroup_cardGroup.title.getData()?trim?has_content) ||
                                (cur_yearGroup_cardGroup.textLabel.getData()?trim?has_content)>
                                <div class="col-xl-4 col-12">
                                    <article class="card-descargas__card" style="border-color: #E2E2E2;">
                                        <#if (cur_yearGroup_cardGroup.title.getData()?trim?has_content)>
                                            <p class="card-descargas__card-title" >
                                                ${cur_yearGroup_cardGroup.title.getData()}
                                            </p>
                                        </#if>
                                        <#if (cur_yearGroup_cardGroup.textLabel.getData()?trim?has_content) && (cur_yearGroup_cardGroup.linkUrl.getData()?trim?has_content)>
                                            <a class="cta-btn-white"
                                                href="${cur_yearGroup_cardGroup.linkUrl.getData()}"
																								target="_blank">
																								${cur_yearGroup_cardGroup.textLabel.getData()}
                                            </a>
                                        </#if>
                                    </article>
                                </div>
                            </#if>
                        </#list>
                    </div>
                </div>
            </div>
        </#list>
			</div>
    </div>
</#if>

 <script>
 
var functionInEffect = false;
    $(document).ready(function() {
		  if(!functionInEffect){
			  functionInEffect = true;
				dropPannelController();
			//	console.log("document ready!");
			}
		});
    Liferay.on('allPortletsReady', function() {
		  if(!functionInEffect){
			  functionInEffect = true;
		  //console.log("allPortletsReady!");
      dropPannelController();
			}
    });
	
	function dropPannelController(){
	   const desktopOptions = $(".droppanel__option${classPK}");
      const mobileSelect = $("#mobile-select${classPK}");
			//console.log("mobileSelect: "+mobileSelect);
      const mobileDropdown = $("#mobile-dropdown${classPK}");
      const mobileOptions = mobileDropdown.find(".droppanel__dropdown-item");
      const selectedYear = $("#selected-year${classPK}");

      function isDesktop() {
					//return $(window).width() > 1025;
          return window.matchMedia("(min-width: 768px)").matches;
      }

      function initDesktopEvents() {
          desktopOptions.on("click", function(e) {
              e.preventDefault();
							//console.log("Seleccionamos opción.");
              desktopOptions.removeClass("droppanel__option--selected${classPK}");
              $(this).addClass("droppanel__option--selected${classPK}");
              let target = $(this).data("target");
              $(".tab-content${classPK}").removeClass("show");
              $(target).addClass("show");
          });
      }

      function initMobileEvents() {
			   // console.log("Entrando en initMobileEvents.");
          mobileSelect.on("click", function(e) {
					    //e.preventDefault();
              e.stopPropagation();
							//console.log("valor de hasClass show: "+mobileDropdown.hasClass("show"));
              if (!mobileDropdown.hasClass("show")) {
                  mobileDropdown.addClass("show");
              } else {
                  mobileDropdown.removeClass("show");
              }
          });

          mobileOptions.on("click", function() {
              selectedYear.text($(this).text());
              mobileDropdown.removeClass("show");

              let target = `#tab-` + $.trim(selectedYear.text()) + `-` + `${classPK?string}`.trim();
              $(".tab-content${classPK}").removeClass("show");
              $(target).addClass("show");

          });

          $(document).on("click", function(e) {
					  //  console.log("entrando en opcion 3:");
              if (!mobileSelect.is(e.target) && !mobileDropdown.has(e.target).length) {
                  mobileDropdown.removeClass("show");
              }
          });

      }
     // console.log(isDesktop());

      if (isDesktop()) {
          initDesktopEvents();
      } else {
          initMobileEvents();
      }

      $(window).on("resize", function() {
          if (isDesktop()) {
              initDesktopEvents();
          } else {
              initMobileEvents();
          }
      });
	}
</script>