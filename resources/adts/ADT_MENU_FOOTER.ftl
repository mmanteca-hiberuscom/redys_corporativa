<ul class="align-items-center navbar-nav d-flex flex-wrap justify-content-center list-unstyled mb-0"  role="list"> 
	<li  role="listitem">
		<div class="footer-menu__elemento footer-menu__elemento--line-vertical">
			${languageUtil.get(locale, "enterprise")}
		</div>
	</li>

	<#-- Filtramos los entries visibles (excluyendo SiteMap) -->
	<#assign visibleEntries = entries?filter(entry -> !entry.getURL()?contains("sitemap")) />

	<#list entries as entry>
		<#assign url = entry.getURL()!"" />
		<#assign title = htmlUtil.escape(entry.getName()) />

		<#assign isCookieModal = url?ends_with("/configurar-cookies") />
		<#assign isInclusiveModal = url?ends_with("/inclusivo-modal") />
		<#assign isSiteMap = url?contains("sitemap") />

		<#assign isLastVisible = !isSiteMap && (entry == visibleEntries[visibleEntries?size - 1]) />

		<#assign extraClass = (!isSiteMap && !isLastVisible)?then('footer-menu__elemento--line-vertical', '') />

		<li class="${isSiteMap?then('sr-only', '')}" role="listitem">
			<#if isCookieModal>
				<a href="#"
				   class="footer-menu__elemento ${extraClass} js-open-cookie-modal">
					${title}
				</a>
			<#elseif isInclusiveModal>
				<a href="#"
				   class="footer-menu__elemento ${extraClass} js-open-inclusive-modal">
					${title}
				</a>
			<#else>
				<a href="${url}" target="_blank"
				   class="footer-menu__elemento ${extraClass}">
					${title}
				</a>
			</#if>
		</li>
	</#list>
</ul>

<script>
document.addEventListener('DOMContentLoaded', function () {
	// Modal de Cookies
	document.querySelectorAll('a.js-open-cookie-modal').forEach(function (link) {
		link.addEventListener('click', function (e) {
			e.preventDefault();
			const modal = document.querySelector('#cookiePolicyModal');
			if (modal && typeof $ !== 'undefined' && typeof $(modal).modal === 'function') {
				$(modal).modal('show');
			}
		});
	});

	// Modal de Lenguaje Inclusivo
	document.querySelectorAll('a.js-open-inclusive-modal').forEach(function (link) {
		link.addEventListener('click', function (e) {
			e.preventDefault();
			const modal = document.querySelector('#inclusiveModal');
			if (modal && typeof $ !== 'undefined' && typeof $(modal).modal === 'function') {
				$(modal).modal('show');
			}
		});
	});
});
</script>