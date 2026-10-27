document.addEventListener("DOMContentLoaded", function () {
    // === Desktop ===
    const dots = document.querySelectorAll(".map__dot");
    const popup = document.getElementById("map-popup");
    const popupFlag = document.getElementById("popup-flag");
    const popupTitle = document.getElementById("map-popup__title");
    const popupDescription = document.getElementById("map-popup__description");

    let activeDot = null;

    popup.style.display = "none";

    dots.forEach(dot => {
        dot.addEventListener("click", function (event) {
            event.stopPropagation();

            if (activeDot === this) {
                resetDots();
                activeDot = null;
                popup.classList.remove("visible");
                popup.style.display = "none";
                return;
            }

            resetDots();
            this.classList.add("selected");
            activeDot = this;

            dots.forEach(otherDot => {
                if (otherDot !== this) {
                    otherDot.classList.add("inactive");
                }
            });

            popupFlag.src = this.getAttribute("data-flag");
            popupFlag.alt = `Bandera de ${this.getAttribute("data-title")}`;
            popupTitle.textContent = this.getAttribute("data-title");
            popupDescription.textContent = this.getAttribute("data-description");

            if (!popupTitle.textContent.trim()) return;

            popup.style.display = "block";

            const dotX = this.offsetLeft + this.offsetWidth / 2;
            const dotY = this.offsetTop;

            const popupHeight = popup.offsetHeight;

            const popupMargin = 20;
            popup.style.top = `${dotY - popupHeight - popupMargin}px`;
            popup.style.left = `${dotX}px`;
            popup.classList.add("visible");
        });
    });

    function resetDots() {
        dots.forEach(dot => {
            dot.classList.remove("selected", "inactive");
        });
    }

    document.addEventListener("click", function (e) {
        if (!popup.contains(e.target) && !e.target.classList.contains("map__dot")) {
            popup.classList.remove("visible");
            popup.style.display = "none";
            resetDots();
            activeDot = null;
        }
    });
});

// === Mobile ===
$(document).ready(function () {
    $('.country-item').each(function () {
        var flag = $(this).attr('data-flag');
        var title = $(this).attr('data-title');
        $(this).html('<div class="country-info"><img src="' + flag + '" alt="' + title + '" class="flag"> <strong>' + title + '</strong></div>');
    });

    $(document).on('click', '.country-item', function () {
        var flag = $(this).attr('data-flag');
        var title = $(this).attr('data-title');
        var description = $(this).attr('data-description');

        if (!$(this).hasClass('expanded')) {
            $('.country-item').removeClass('expanded').find('.modal-country').remove();
            $(this).addClass('expanded');
            $(this).find('.country-info').hide();
            $(this).append('<div class="modal-country"><img src="' + flag + '" alt="' + title + '" class="flag"> <strong>' + title + '</strong><p>' + description + '</p></div>');
        } else {
            $(this).removeClass('expanded').find('.modal-country').remove();
            $(this).find('.country-info').show();
        }
    });

    $('.card-header button').on('click', function () {
        setTimeout(() => {
            $('.country-item').each(function () {
                if (!$(this).hasClass('expanded')) {
                    $(this).find('.country-info').show();
                }
            });
        }, 300);
    });
});