package com.redsys.linkedin.publications.model;


import com.liferay.petra.string.StringBundler;
import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.util.HtmlUtil;
import com.liferay.portal.kernel.util.StringUtil;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

public class LinkedInPost {
    private List<String> text;
    private String imageUrl;
    private int likes;
    private String shareUrl;

    public String getId() {
        return id;
    }

    private String id;

    private long timestamp;

    public int getDiasDesde() {
        return diasDesde;
    }

    private int diasDesde;

    private String whatsappUrl;

    public String getWhatsappUrl() {
        return
                "https://api.whatsapp.com/send?text="+shareUrl;
    }

    public String getFacebookUrl() {
        return
                "https://facebook.com/sharer/sharer.php?u="+shareUrl;
    }

    public String getTelegramUrl() {
        return
                "https://telegram.me/share/url?url==t="+shareUrl;
    }

    public String getLinkedinUrl() {
        return
                "https://www.linkedin.com/feed/?linkOrigin=LI_BADGE&shareActive=true&shareUrl=https%3A%2F%2F"+shareUrl.replaceFirst("^https://", "");
    }

    public String getxUrl() {
        return
                "https://x.com/intent/post?url=https%3A%2F%2F"+shareUrl.replaceFirst("^https://", "");
    }

    private String facebookUrl;
    private String telegramUrl;
    private String xUrl;
    private String linkedinUrl;

    public LinkedInPost(String id, List<String> text, String imageUrl, int likes, String shareUrl, long timestamp) {
        this.id = id;
        this.text = text;
        this.imageUrl = imageUrl;
        this.likes = likes;
        this.shareUrl = shareUrl;
        this.timestamp = timestamp;
    }

    public List<String>  getText() {
        return text;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public int getLikes() {
        return likes;
    }

    public String getShareUrl() {
        return shareUrl;
    }

    public String getTiempoTranscurrido(Locale locale) {
        long timestampJson = this.timestamp; // Timestamp obtenido del JSON (milisegundos)
        long timestampActual = new Date().getTime(); // Timestamp actual en milisegundos

        long diferenciaMillis = timestampActual - timestampJson; // Diferencia en milisegundos

        long minutos = TimeUnit.MILLISECONDS.toMinutes(diferenciaMillis);
        long horas = TimeUnit.MILLISECONDS.toHours(diferenciaMillis);
        long dias = TimeUnit.MILLISECONDS.toDays(diferenciaMillis);

        if (dias > 0) {
            return dias + (dias == 1 ? " "+ LanguageUtil.get(locale,"day") : " "+LanguageUtil.get(locale,"days"));
        } else if (horas > 0) {
            return horas + (horas == 1 ? " "+LanguageUtil.get(locale,"hour") : " "+LanguageUtil.get(locale,"hours"));
        } else {
            return minutos + (minutos == 1 ? " "+LanguageUtil.get(locale,"minute") : " "+LanguageUtil.get(locale,"minutes"));
        }
    }
}
