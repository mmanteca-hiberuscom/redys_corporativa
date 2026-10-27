package com.redsys.service;

import com.liferay.asset.kernel.model.AssetEntry;
import com.liferay.journal.model.JournalArticle;

import java.util.Locale;
import java.util.TimeZone;

/**
 * @author Abba Chej Dehan
 */
public interface RedsysService {
    String getFieldByReference(JournalArticle ja, String campo,Locale locale);
    String getFieldByReference(String classPK, String campo,Locale locale);
    public String getFieldByReference(AssetEntry assetEntry, String campo, Locale locale) ;
    String getImagenJournalArticleByField(String entry, String campo, String cssClass);
    String getDate( String date);
    String getDate(String date,String format);
}