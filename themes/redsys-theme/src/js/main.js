AUI().ready(function () {
  resetTabindexes();
    // Este código se ejecuta cuando el DOM está listo, pero no necesariamente cuando los portlets están listos.
});

Liferay.Portlet.ready(function (portletId, node) {
    // Este código se ejecuta después de que cada portlet se carga.
});

Liferay.on('allPortletsReady', function () {
    // Este código se ejecuta cuando todos los portlets están listos.
const javascript_folder =Liferay.ThemeDisplay.getCDNBaseURL() +
                         							Liferay.ThemeDisplay.getPathThemeRoot() +'/js';

const slickFile =javascript_folder +'/libs/slick.min.js';


loadScript(
slickFile, false)
        .then(data => {
        })
        .catch(err => {
            console.error("Error al cargar el script:", err);
        });
});

Liferay.on('endNavigate', function () {
    // Este evento se dispara cuando la navegación AJAX ha terminado.
const javascript_folder =Liferay.ThemeDisplay.getCDNBaseURL() +
                         							Liferay.ThemeDisplay.getPathThemeRoot() +'/js';

const slickFile =javascript_folder +'/libs/slick.min.js';

    loadScript(slickFile, false)
        .then(data => {
        })
        .catch(err => {
            console.error("Error al cargar el script después de navegación:", err);
        });
});

function loadScript(src, async = true) {
    return new Promise((resolve, reject) => {
        const script = document.createElement('script');
        script.src = src;
        script.async = async;
        script.onload = () => resolve(src);
        script.onerror = () => reject(new Error(`Error al cargar el script: ${src}`));
        document.head.appendChild(script);
    });
}

function isEditMode(){
    return document.querySelector("body.has-edit-mode-menu") !=null;
    }

    function isVisible(selector) {
        var element = document.querySelector(selector);
        return element && element.offsetParent !== null;
    }

function resetTabindexes() {
  $('header.header').find('[tabindex]').attr('tabindex', 0);
   $('.c-inner').attr('tabindex', -1);
}