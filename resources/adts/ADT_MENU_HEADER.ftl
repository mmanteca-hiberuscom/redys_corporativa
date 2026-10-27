<#include "${templatesPath}/NAVIGATION-MACRO-FTL" />
<#assign redsysService=serviceLocator.findService("com.redsys.service.ResysServiceImpl") />
<#assign latestJournalArticle = redsysService.getJournarArticleByStructureKey("EST_COLUMN_TABS", themeDisplay.getSiteGroupId()) />
<#assign listadoGrupo = redsysService.getListFieldByReference(latestJournalArticle,"iconGroupTitle", locale) />
<#assign enlaceContenidoWeb = redsysService.getFieldByReference(latestJournalArticle,"assetLinkRelated", locale)?eval />

<#if !entries?has_content>
	<#if themeDisplay.isSignedIn()>
		<div class="alert alert-info">
			<@liferay.language key="there-are-no-menu-items-to-display" />
		</div>
	</#if>
<#else>
	<#assign portletDisplay = themeDisplay.getPortletDisplay() />

	<#if validator.isNull(portletDisplay.getId())>
		<#assign navbarId = "navbar_" + stringUtil.randomId() />
	<#else>
		<#assign navbarId = "navbar_" + portletDisplay.getId() />
	</#if>

	<div id="${navbarId}">
		<ul aria-label="<@liferay.language key='site-pages' />" class="navbar-blank navbar-nav navbar-site" role="menubar">
			<#assign navItems = entries />

			<#list navItems as navItem>
				<#assign showChildrenNavItems = ((displayDepth != 1) && navItem.hasBrowsableChildren()) />

				<#if navItem.isBrowsable() || showChildrenNavItems>
					<#-- valores base -->
					<#assign nav_item_attr_has_popup = "" />
					<#assign nav_item_caret = "" />
					<#assign nav_item_css_class = "lfr-nav-item nav-item" />
					<#assign nav_item_href_link = "" />
					<#assign nav_item_link_css_class = "nav-link text-truncate" />

					<#if showChildrenNavItems>
						<#assign nav_item_attr_has_popup = "aria-haspopup='true'" />

						<#assign nav_item_caret>
							<span class="lfr-nav-child-toggle">
								<@liferay_aui.icon image="angle-down" markupView="lexicon" />
							</span>
						</#assign>

						<#assign nav_item_css_class = nav_item_css_class + " dropdown" />
						<#assign nav_item_link_css_class = nav_item_link_css_class + " dropdown-toggle" />
					</#if>

					<#if navItem.isBrowsable()>
						<#assign originalHref = navItem.getURL() />
						<#if originalHref?contains("#")>
							<#assign baseHref = originalHref?split("#")[0] />
							<#assign anchor = originalHref?split("#")[1] />
							<#-- (respetamos tu lógica de slug tal como la usabas) -->
							<#assign anchorId = anchor?lower_case?replace("[^a-z0-9]", "-", "r")?replace("-+", "-", "r")?trim("-") />
							<#assign nav_item_href_link = "href='${baseHref}#${anchorId}'" />
						<#else>
							<#assign nav_item_href_link = "href='${originalHref}'" />
						</#if>
					</#if>

					<#if !navItem.isChildSelected() && navItem.isSelected()>
						<#assign nav_item_css_class = nav_item_css_class + " selected active" />
					</#if>

					<#assign isSelected = navItem.isSelected() />
					<#assign isChildSelected = navItem.isChildSelected() />
					<#assign shouldOpen = false />
					<#if showChildrenNavItems && isSelected>
						<#assign shouldOpen = true />
					</#if>
					<#if showChildrenNavItems && isChildSelected>
						<#assign shouldOpen = true />
					</#if>

					<#if shouldOpen>
						<#assign nav_item_css_class = nav_item_css_class + " open show active-parent" />
						<#if nav_item_attr_has_popup?has_content>
							<#assign nav_item_attr_has_popup = nav_item_attr_has_popup + " aria-expanded='true'" />
						<#else>
							<#assign nav_item_attr_has_popup = "aria-haspopup='true' aria-expanded='true'" />
						</#if>
					</#if>

					<li class="${nav_item_css_class}" id="layout_${portletDisplay.getId()}_${navItem.getLayoutId()}" role="presentation">
						<a ${nav_item_attr_has_popup} class="${nav_item_link_css_class}" ${nav_item_href_link} ${navItem.getTarget()} role="menuitem">
							<span class="text-truncate"><@liferay_theme["layout-icon"] layout=navItem.getLayout() /> ${navItem.getName()} ${nav_item_caret}</span>
						</a>

						<#if showChildrenNavItems>
							<ul role="menu" class="child-menu dropdown-menu<#if shouldOpen> show</#if>" aria-expanded="<#if shouldOpen>true<#else>false</#if>">
								<@buildChildrenNavItems
									displayDepth=displayDepth
									navItem=navItem
								/>
							</ul>
						</#if>
					</li>
				</#if>
			</#list>
		</ul>
						</div>
					
	 <@liferay_aui.script use="liferay-navigation-interaction">
    var navigation = A.one('#${navbarId}');
    if (navigation && window.innerWidth < 1200) {
        navigation.plug(Liferay.NavigationInteraction);
    }
   </@liferay_aui.script>
</#if>