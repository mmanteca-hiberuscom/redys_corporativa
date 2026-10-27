<#-- TPL_COOKIES_TABLE (Secciones Footer - Política de Cookies) -->
<#-- estructura - EST_COOKIES_TABLE -->
<#-- @author Alban Loubet -->

<section class="table-responsive-cookies">
        <#if (cookieCategoryLabel.getData())??>
				<p>
	         ${cookieCategoryLabel.getData()}
			  </p>
        </#if>
        <table class="table-responsive-cookies-content">
            <thead>
                <tr>
                    <th class="nameColumn"><@liferay.language key='cookie-name' /></th>
                    <th class="purposeColumn"><@liferay.language key='cookie-purpose' /></th>
                    <th><@liferay.language key='cookie-provider' /></th>
                    <th><@liferay.language key='cookie-expiration' /></th>
                </tr>
            </thead>
            <tbody>
						    <#if cookiesGroup.getSiblings()?has_content>
	                 <#list cookiesGroup.getSiblings() as cur_cookiesGroup>
		                 <tr>
                        <td>
												   <#if (cur_cookiesGroup.cookieName.getData())??>
	                            ${cur_cookiesGroup.cookieName.getData()}
                           </#if>
												</td>
                        <td>
												   <#if (cur_cookiesGroup.CookiePurpose.getData())??>
	                            ${cur_cookiesGroup.CookiePurpose.getData()}
                           </#if>
                        </td>
                        <td>
												   <#if (cur_cookiesGroup.cookieProvider.getData())??>
	                            ${cur_cookiesGroup.cookieProvider.getData()}
                           </#if>
												</td>
                        <td>
												   <#if (cur_cookiesGroup.cookieExpiration.getData())??>
	                            ${cur_cookiesGroup.cookieExpiration.getData()}
                           </#if>
												</td>
                     </tr>
	                 </#list>
                </#if>
            </tbody>
        </table>
    </section>