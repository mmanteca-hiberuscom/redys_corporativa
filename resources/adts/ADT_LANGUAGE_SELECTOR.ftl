<!-- PLANTILLA DE SELECTOR DE IDIOMA DEL HEADER -->
<!-- @Author Yordy Tafur -->

<#if entries?has_content>
    <div class="custom-language-selector">

        <div class="desktop-language-selector">
            <#list entries as entry>
                <#assign cssClass = "" />

                <#if entry.isSelected()>
                    <#assign cssClass = "active" />
                </#if>

                <#if !entry.isDisabled()>
                    <#assign entryUrl = entry.getURL()!"" />
                    <#assign languageCode = entry.getW3cLanguageId()?split("-")[0]?upper_case />

                    <a href="${entryUrl}" class="${cssClass}">
                        ${languageCode}
                    </a>

                    <#if entry_has_next> | </#if>

                </#if>
            </#list>
        </div>

        <div class="mobile-language-selector">
    <button class="dropdown-btn" id="<@portlet.namespace />menuIdioma" aria-expanded="false" aria-controls="<@portlet.namespace />contenidoIdioma">
        <span id="current-language">
            <#list entries as entry>
                <#if entry.isSelected()>
                    ${entry.getW3cLanguageId()?split("-")[0]?upper_case}
                </#if>
            </#list>
        </span>
        <span class="arrow-wrapper">
            <svg class="dropdown-arrow" width="14" height="8" viewBox="0 0 14 8" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M1 1L7 7L13 1" stroke="#FE5B02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
            </svg>
        </span>
    </button>
    <div class="dropdown-content" id="<@portlet.namespace />contenidoIdioma" role="menu" tabindex="-1">
        <#list entries as entry>
            <#if !entry.isDisabled()>
                <#assign entryUrl = entry.getURL()!"" />
                <#assign languageCode = entry.getW3cLanguageId()?split("-")[0]?upper_case />
                <a href="${entryUrl}" role="menuitem">${languageCode}</a>
            </#if>
        </#list>
    </div>
</div>
    </div>
</#if>
<style type="text/css">
    .custom-language-selector .desktop-language-selector {
        font-family: "InterRegular", Arial, sans-serif;
        display: flex;
        align-items: center;
        gap: 5px;
        font-weight: 400;
        background-color: #F7F7F7;
    }

    .custom-language-selector .desktop-language-selector a {
        font-family: "InterRegular", Arial, sans-serif;
        text-decoration: none;
        color: #333333;
        font-weight: 400;
        font-size: 1rem;
        background-color: #F7F7F7;
    }

    .custom-language-selector .desktop-language-selector a:hover {
        text-shadow: 0 0 .40px currentColor;
        color: #333333;
    }

    .custom-language-selector .desktop-language-selector a.active {
        text-decoration: underline;
    }

    .custom-language-selector .mobile-language-selector {
        position: relative;
        display: none;
        width: 89px;
        border-left: 1px solid #BEBEBE;
        border-right: 1px solid #BEBEBE;
        justify-items: center;
    }

    .custom-language-selector .arrow-wrapper {
        width: 1.5rem;
        height: 1.5rem;
				padding-left: 9px;
			  display: flex;
        align-items: center;
    }

    .custom-language-selector .dropdown-btn {
        background: none;
        border: none;
        font-size: 1rem;
        font-weight: 400;
        color: #333333;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0px;
    }

    .custom-language-selector .dropdown-btn[aria-expanded="true"] .dropdown-arrow {
        transform: rotate(180deg);
    }

    .custom-language-selector .dropdown-content {
        display: none;
        position: absolute;
        background-color: #FFFFFF;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 4px;
        min-width: 50px;
        top: 33px;
        left: 17px;
    }

    .custom-language-selector .dropdown-content a {
        display: block;
        text-decoration: none;
        color: #333;
        font-weight: 400;
        padding: 5px 10px;
    }

    .custom-language-selector .dropdown-content a:hover {
        background-color: #FFFFFF;
        text-shadow: 0 0 .40px currentColor;
    }


    .custom-language-selector #current-language,
    .custom-language-selector .mobile-language-selector a {
        font-size: 1.25rem;
    }

    @media screen and (max-width: 1199.98px) {
        .custom-language-selector .desktop-language-selector {
            display: none;
        }

        .custom-language-selector .mobile-language-selector {
            display: block;
        }
    }

    .language-selector .portlet-content,
    .language-selector .portlet,
    .language-selector .portlet-decorate .portlet-content,
    .language-selector .portlet-content a {
        padding: 0;
        margin: 0;
        border: 0;
    }

    .language-selector .portlet-decorate .portlet-content {
        background: none;
    }
</style>

<script>
	AUI().ready(function() {
    const dropdownBtn = document.getElementById("<@portlet.namespace />menuIdioma");
    const dropdownContent = document.getElementById("<@portlet.namespace />contenidoIdioma");

    if (dropdownBtn && dropdownContent) {
        dropdownBtn.addEventListener("click", function () {
            const isOpen = dropdownBtn.getAttribute("aria-expanded") === "true";

     
            dropdownBtn.setAttribute("aria-expanded", !isOpen);
            dropdownContent.style.display = isOpen ? "none" : "block";

            
            if (!isOpen) {
                setTimeout(() => dropdownContent.querySelector("a")?.focus(), 100);
            }
        });
      
        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape" && dropdownBtn.getAttribute("aria-expanded") === "true") {
                dropdownBtn.setAttribute("aria-expanded", "false");
                dropdownContent.style.display = "none";
                dropdownBtn.focus(); 
            }
        });

        document.addEventListener("click", function (event) {
            if (!dropdownBtn.contains(event.target) && !dropdownContent.contains(event.target)) {
                dropdownBtn.setAttribute("aria-expanded", "false");
                dropdownContent.style.display = "none";
            }
        });
    }
});
</script>