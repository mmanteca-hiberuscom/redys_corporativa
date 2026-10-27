<!-- PLANTILLA BARRA DE BUSQUEDA -->

<#assign destination="/search" />
<#assign searchInputId=namespace + stringUtil.randomId() />
<#if searchBarPortletDisplayContext.getDestinationFriendlyURL()?has_content>
  <#assign destination=searchBarPortletDisplayContext.getDestinationFriendlyURL() />
</#if>
<div class="input-group search-bar-simple">
  <div class="input-group-item search-bar-keywords-input-wrapper">
    <input id="search-input" type="text" class="search-bar-empty-search-input form-control input-group-inset input-group-inset-after search-bar-keywords-input"
      name="faq-search"
     placeholder="<@liferay.language key='search' />"
      type="text"
		  aria-label="<@liferay.language key='find-frequently-questions' />" >
    <div class="input-group-inset-item input-group-inset-item-after">
      <svg class="lexicon-icon lexicon-icon-search" role="presentation">
      </svg>
    </div>
  </div>
  <div class="answersFaqs" id="suggestions">
  </div>
</div>
<#if searchBarPortletDisplayContext.isSuggestionsEnabled()>
  <script>
  function searchIntoFAQs(input) {
    let filter = input.value.trim();
    filter = filter.toLowerCase();
    const container = document.getElementById("suggestions");

    // Limpiar resultados anteriores
    container.innerHTML = "";

    // No buscar si tiene 2 caracteres o menos
    if (filter.length <= 2) return;

    const accordionButtons = document.getElementsByClassName("accordion-button");
    let results = [];

    for (let i = 0; i < accordionButtons.length; i++) {
        let txtValue = accordionButtons[i].textContent.toLowerCase();
        let txtValueVista = accordionButtons[i].textContent;
        let dataTarget = accordionButtons[i].getAttribute("data-target");
        if (txtValue.includes(filter)) {
            results.push({ txt: txtValueVista, idData: dataTarget });
        }
    }

    // Si no hay resultados útiles, no pintamos nada
    if (results.length === 0) return;

    // Crear <ul> solo si hay sugerencias
    const ul = document.createElement("ul");
    ul.className = "dropdown-search";
    ul.setAttribute("aria-live", "polite");
    ul.setAttribute("aria-label", "Sugerencias de búsqueda");

    // Agregar hasta 6 resultados
    let count = 0;
    for (let j = 0; j < results.length && count < 6; j++) {
        const numberId = results[j].idData?.split("-")[1];
        if (!numberId) continue;

        const li = document.createElement("li");
        li.className = "dropdown-search-item";

        const link = document.createElement("a");
        link.className = "dropdown-search-item-link";
        link.setAttribute("data-asset-entry-id", numberId);
        link.setAttribute("onclick", 'goToSelectedQuestion(' + numberId + ')');
        link.innerText = results[j].txt;

        li.appendChild(link);
        ul.appendChild(li);
        count++;
    }

    // Solo añadir al DOM si hay resultados reales
    const validItems = ul.querySelectorAll('li');
    if (validItems.length > 0) {
        container.appendChild(ul);
        let suggestionsList = container.querySelector('.dropdown-search');
        if (suggestionsList) {
            suggestionsList.style.display = 'block';
        }
    }
}

function goToSelectedQuestion(assetEntryId) {
    const container = document.getElementById("suggestions");
    container.innerHTML = "";

    // Cerrar todos los acordeones
    document.querySelectorAll(".accordion-button").forEach(button => {
        button.setAttribute("aria-expanded", "false");
    });
    document.querySelectorAll(".accordion-collapse").forEach(panel => {
        panel.classList.remove("show");
        panel.setAttribute("aria-hidden", "true");
    });

    // Esperar antes de hacer scroll y activar
    setTimeout(() => {
        const triggerButton = document.getElementById("btn-" + assetEntryId);
        const targetPanel = document.getElementById("collapse-" + assetEntryId);

        if (triggerButton) {
            triggerButton.click();
            triggerButton.setAttribute("aria-expanded", "true");
        }

        if (targetPanel) {
            targetPanel.setAttribute("aria-hidden", "false");
        }

        if (triggerButton) {
            event?.preventDefault?.();
            const offsetTop = triggerButton.getBoundingClientRect().top + window.pageYOffset - 270;
            window.scrollTo({ top: offsetTop, behavior: "smooth" });
        }
    }, 150);
}

document.addEventListener('click', function(event) {
    const container = document.getElementById('suggestions');
    if (!container.contains(event.target)) {
        let suggestions = container.querySelector('.dropdown-search');
        if (suggestions) {
            suggestions.style.display = 'none';
        }
    }
});

$(document).ready(function () {
    const $input = $('#search-input');
    // Cada vez que cambie el contenido (tecla levantada o pegado)
    $input.on('input', function () {
        searchIntoFAQs(this);
    });
    // Cuando alguien pulse Enter dentro del input
    $input.on('keydown', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            searchIntoFAQs(this);
        }
    });
});

  </script>
</#if>