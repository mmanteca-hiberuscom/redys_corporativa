<%@ include file="/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="com.redsys.linkedin.publications.model.LinkedInPost" %>
<%@page import="java.util.List" %>

<% List<LinkedInPost> publicaciones = (List<LinkedInPost>) request.getAttribute("linkedinPosts"); %>
<section class="section-linkedin">
    <div class="linkedin__container container">
        <div class="linkedin-slider js-slider-linkedin" role="region" aria-label='<liferay-ui:message key="redsys.linkedin.news.recent" />'>
        <% if (publicaciones !=null && !publicaciones.isEmpty()) { %>
            <% for (LinkedInPost post : publicaciones) { %>
            <div class="linkedin__news">
                <div class="row">
                    <div class="col-12 col-xl-7">
                        <article aria-label="Linkedin" class="card-news" aria-labelledby="news-title-1">
                            <header class="card-news__header">
                               <a href="<%= post.getShareUrl() %> " target="_blank"> <i class="social-icon">Linkedin</i></a>
                                <div>
                                    <p class="card-news__header-title"><liferay-ui:message key="redsys.linkedin.title" /></p>
                                    <p><%= post.getTiempoTranscurrido(locale) %> </p>
                                </div>
                            </header>
                            <div class="card-news__body">
                                <%  List<String> textParts = post.getText(); 
                                if (textParts != null && !textParts.isEmpty()) {
                                    for (String part : textParts) {
                                 %>
                                        <p><%= part %></p>
                                <%}
                                } else { %>
                                    <p>Sin contenido disponible</p>
                                <% } %>
                            </div>
                            <footer class="card-news__footer">
                            <div class="dropdown">
                                <button aria-haspopup="true" class="btn btn-link dropdown-toggle compartir compartir-wrapper" data-toggle="liferay-dropdown">
                                            <liferay-ui:message key="share" />
                            			</button>
                              <ul class="dropdown-menu dropdown-menu-right" role="menu">
                              				<li>
                              				<a class="compartir compartir-copy btn-link copies"   onclick="copyToClipboard('<%= post.getShareUrl() %>',this)" ><liferay-ui:message key="copy-link" /></a>
                              				</li>
                              				<li>
                              				<a class="compartir compartir-whatsapp" target="_blank" href="<%= post.getWhatsappUrl() %>"><liferay-ui:message key="Whatsapp" /></a>
                              				</li>
                              				<li>
                              				<a class="compartir compartir-facebook" target="_blank" href="<%= post.getFacebookUrl() %>"><liferay-ui:message key="facebook" /></a>
                              				</li>
                              				<li>
                              				<a class="compartir compartir-telegram" target="_blank" href="<%= post.getTelegramUrl() %>"><liferay-ui:message key="Telegram" /></a>
                              				</li>
                              				<li>
                              				<a class="compartir compartir-x" target="_blank" href="<%= post.getxUrl() %>"><liferay-ui:message key="X" /></a>
                              				</li>
                              				<li>
                              				<a class="compartir compartir-linkedin" target="_blank" href="<%= post.getLinkedinUrl() %>"><liferay-ui:message key="linkedin" /></a>
                              				</li>

                              </ul>
                            </div>

                            </footer>
                        </article>
                    </div>

                    <div class="col-12 col-xl-5">
                        <figure class="card-news__image-container">
                            <% if (!post.getImageUrl().isEmpty()) { %>
                            <img src="<%= post.getImageUrl() %>" class="img-fluid" alt='<liferay-ui:message key="redsys.linkedin.img.alt" />'>
                            <% } else { %>

                            <% } %>
                        </figure>
                    </div>
                </div>
            </div>
            <% } %>
        <% } else { %>
            <p><liferay-ui:message key="not.published.found" /> </p>
        <% } %>
        </div>
    </div>
</section>

<script>
    function copyToClipboard(url, element) {
            var tempInput = document.createElement("input");
            tempInput.style.position = "absolute";
            tempInput.style.left = "-9999px";
            tempInput.value = url;

            document.body.appendChild(tempInput);
            tempInput.select();
            tempInput.setSelectionRange(0, 99999);
            document.execCommand("copy");
            document.body.removeChild(tempInput);
            element.classList.remove("compartir-copy");
            element.classList.add("compartir-check");
            element.setAttribute("aria-label", '<liferay-ui:message key="redsys.linkedin.copy.success" />');
        }
 $(document).ready(function () {
    var copyLinks = document.querySelectorAll(".copies");

     var onDropdownEvent = function () {
         copyLinks.forEach(function(element) {
             if (!element.classList.contains("compartir-copy")) {
                             element.classList.add("compartir-copy");
                         }
                         if (element.classList.contains("compartir-check")) {
                             element.classList.remove("compartir-check");
                         }
         });
     };


    Liferay.on('liferay.dropdown.shown', onDropdownEvent);
            Liferay.on('liferay.dropdown.hidden', onDropdownEvent);

            initSlickLinkedin();
                            function initSlickLinkedin() {
    if (typeof $().slick === 'function' && !isEditMode() && isVisible('.js-slider-linkedin')) {
     try {
        if ($(".js-slider-linkedin").length > 0) {
            $(".js-slider-linkedin").each(function (i, slider) {
            $(slider)
                .not(".slick-initialized")
                .slick({
                infinite: true,
                slidesToShow: 1,
                slidesToScroll: 1,
                dots: true,
                arrows: true,
                });
            });
        }
    } catch (error) {
    // console.log("Try set slider blog got " + error);
    }
} else {
                    //    console.log("...try loading initSlickLinkedin")
                        setTimeout(initSlickLinkedin, 10);
                    }
                }

 });
</script>


