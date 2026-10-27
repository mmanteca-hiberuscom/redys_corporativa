package com.redsys.service;


import com.liferay.asset.kernel.model.AssetEntry;
import com.liferay.dynamic.data.mapping.model.DDMStructure;
import com.liferay.dynamic.data.mapping.model.Value;
import com.liferay.dynamic.data.mapping.service.DDMStructureLocalService;
import com.liferay.dynamic.data.mapping.storage.DDMFormFieldValue;
import com.liferay.journal.model.JournalArticle;
import com.liferay.journal.service.JournalArticleLocalService;
import com.liferay.journal.service.JournalArticleLocalServiceUtil;
import com.liferay.journal.service.JournalArticleServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.*;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Component(service = ResysServiceImpl.class)
public class ResysServiceImpl implements RedsysService{
    private static final Log _log = LogFactoryUtil.getLog(ResysServiceImpl.class);

    //Metodo que devuelve el valor de un campo de un Journal Article mediante el JournalArticle entry y la referencia del campo

    public JournalArticle getJournarArticleByStructureKey
            (String structureKey, long groupId) {

        _log.debug("getJournarArticleByStructureKey");

        DDMStructure estructura = getStructure(groupId, structureKey);

        List<JournalArticle> articleList =   _journalArticleLocalService.getStructureArticles(groupId,
                    estructura.getStructureId());
        return articleList.get(0);
    }
    public DDMStructure getStructure(long groupId, String structureKey) {
        long journalArticleClassNameId = PortalUtil.getClassNameId(JournalArticle.class.getName());
        DDMStructure estructura = _ddmStructureLocalService.fetchStructure(groupId, journalArticleClassNameId,
                structureKey);
        if (estructura == null) {
            _log.warn("No se encuentra la estructura: " + structureKey);
        }
        return estructura;
    }

    public String getFieldByReference(JournalArticle ja, String campo, Locale locale) {

        if (Validator.isNull(ja)) {
            _log.warn("getFieldByReference("+campo+") no se puede recuperar de un journalArticle nulo");
            return "";
        }

        String value = "";

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);
        value = ddmFormFieldValuesReferenceMap.get(campo).get(0).getValue().getString(locale);

        return value;
    }


    public List<String> getListFieldByReference(JournalArticle ja, String campo,Locale locale) {

        List<String> valores = new ArrayList<>();

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);


        List<DDMFormFieldValue> fieldValues = ddmFormFieldValuesReferenceMap.get(campo);
        //crear un array o list de atring en el que recorrer el fieldValues y meter lo siguiente
        //        value = ddmFormFieldValuesReferenceMap.get(campo).get(i).getValue().toString(locale);
        if (fieldValues != null) {
            for (DDMFormFieldValue fieldValue : fieldValues) {
                String value = fieldValue.getValue().getString(locale);
                valores.add(value);
            }
        }
        return valores;
    }

    //Metodo que devuelve el valor de un campo de un Journal Article mediante el asset entry y la referencia del campo

    public String getFieldByReference(AssetEntry assetEntry, String campo, Locale locale) {

        if (Validator.isNull(assetEntry)) {
            _log.warn("getFieldByReference("+campo+") no se puede recuperar de un journalArticle nulo");
            return "";
        }
        JournalArticle ja = JournalArticleLocalServiceUtil.fetchLatestArticle(assetEntry.getClassPK());

        String value = "";

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);
        value = ddmFormFieldValuesReferenceMap.get(campo).get(0).getValue().getString(locale);

        return value;
    }

    public String getFieldByReference(String classPK, String campo,Locale locale) {

        if (Validator.isNull(classPK)) {
            _log.warn("getFieldByReference("+campo+") no se puede recuperar de un journalArticle nulo");
            return "";
        }
        JournalArticle ja = JournalArticleLocalServiceUtil.fetchLatestArticle(GetterUtil.getLong(classPK));

        String value = "";

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);
        value = ddmFormFieldValuesReferenceMap.get(campo).get(0).getValue().getString(locale);
        return value;
    }

    public String getFieldByReferenceByIndex(String classPK, String campo,int index,Locale locale) {

        if (Validator.isNull(classPK)) {
            _log.warn("getFieldByReference("+campo+") no se puede recuperar de un journalArticle nulo");
            return "";
        }
        JournalArticle ja = JournalArticleLocalServiceUtil.fetchLatestArticle(GetterUtil.getLong(classPK));

        String value = "";

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);

        value = ddmFormFieldValuesReferenceMap.get(campo).get(index).getValue().getString(locale);
        return value;
    }
    public String getInstanceIdByReferenceByIndex(String classPK, String campo,int index,Locale locale) {

        if (Validator.isNull(classPK)) {
            _log.warn("getFieldByReference("+campo+") no se puede recuperar de un journalArticle nulo");
            return "";
        }
        JournalArticle ja = JournalArticleLocalServiceUtil.fetchLatestArticle(GetterUtil.getLong(classPK));

        String value = "";

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);

        value = ddmFormFieldValuesReferenceMap.get(campo).get(index).getInstanceId();

        List<DDMFormFieldValue> fieldValues = ddmFormFieldValuesReferenceMap.get(campo);

        /*for (int i = 0; i < fieldValues.size(); i++) {
            DDMFormFieldValue fieldValue = fieldValues.get(i);
            String val = fieldValue.getValue().getString(locale);
            String instanceId = fieldValue.getInstanceId();

            System.out.println("Índice " + i + ": " + val + " (InstanceId: " + instanceId + ")");
        }*/


        return value;
    }

    //Metodo que devuelve el src de una imagen de un Journal Article mediante el asset entry
    @Override
    public String getImagenJournalArticleByField(String classPK, String campo, String cssClass){
        String urlImagen="";
        try {
            JSONObject jsonImage = JSONFactoryUtil.createJSONObject(
                    getFieldByReference(classPK, campo,LocaleUtil.getDefault()));
            urlImagen =  String.format(
                    "<img src=\"%s\" alt=\"%s\" class=\"%s\" />",
                    HtmlUtil.stripHtml(jsonImage.getString("url")),
                    jsonImage.getString("alt"),
                    cssClass
            );
        }
        catch( Exception e){

        }
        return urlImagen;

    }

    /*public String getGroupFieldByReference(String classPK, String campo,Locale locale) {

        if (Validator.isNull(classPK)) {
            _log.warn("getFieldByReference("+campo+") no se puede recuperar de un journalArticle nulo");
            return "";
        }
        JournalArticle ja = JournalArticleLocalServiceUtil.fetchLatestArticle(GetterUtil.getLong(classPK));

        String value = "";

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap = ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);
        //value = ddmFormFieldValuesReferenceMap.get(campo).get(0).getValue().getString(locale);
        List<DDMFormFieldValue> ddmFormFieldValues =
                ddmFormFieldValuesReferenceMap.get(campo);

        ddmFormFieldValues.forEach(
                ddmFormFieldValue -> {
                    System.out.println(ddmFormFieldValue.getValue().getString(locale));
                    System.out.println(ddmFormFieldValue.getInstanceId());
                }
        );
        return value;
    }*/

    public Map<String, String> getGroupFieldByReference(String classPK, String campo, Locale locale) {

        Map<String, String> result = new LinkedHashMap<>();

        if (Validator.isNull(classPK)) {
            _log.warn("getFieldByReference(" + campo + ") no se puede recuperar de un journalArticle nulo");
            return result;
        }

        JournalArticle ja = JournalArticleLocalServiceUtil.fetchLatestArticle(GetterUtil.getLong(classPK));

        Map<String, List<DDMFormFieldValue>> ddmFormFieldValuesReferenceMap =
                ja.getDDMFormValues().getDDMFormFieldValuesReferencesMap(true);

        List<DDMFormFieldValue> ddmFormFieldValues = ddmFormFieldValuesReferenceMap.get(campo);

        if (ddmFormFieldValues != null) {
            ddmFormFieldValues.forEach(ddmFormFieldValue -> {
                String instanceId = ddmFormFieldValue.getInstanceId();
                String value = ddmFormFieldValue.getValue().getString(locale);
                result.put(instanceId, value);
            });
        }

        return result;
    }

    @Override
    public String getDate(String date) {
        String format = "dd/MM/YYYY";
        String inputFormat = "E, dd MMM yyyy HH:mm:ss Z";

        DateFormat dateFormat = DateFormatFactoryUtil.getSimpleDateFormat(inputFormat);
        DateFormat dateFormatString = new SimpleDateFormat(format);
        Date date1 = null;
        try {
             date1 = dateFormat.parse(date);
        } catch (ParseException e) {
            System.out.println("e "+e.getMessage());
            throw new RuntimeException(e);
        }
        return dateFormatString.format(date1);
    }
    @Override
    public String getDate(String date,String format) {
        String inputFormat = "E, dd MMM yyyy HH:mm:ss Z";

        DateFormat dateFormat = DateFormatFactoryUtil.getSimpleDateFormat(inputFormat);
        DateFormat dateFormatString = new SimpleDateFormat(format);
        Date date1 = null;
        try {
            date1 = dateFormat.parse(date);
        } catch (ParseException e) {
            System.out.println("e "+e.getMessage());
            throw new RuntimeException(e);
        }
        return dateFormatString.format(date1);
    }
    @Activate
    protected void activate() {

    }

    @Deactivate
    protected void deactivate() {
    }

    @Reference
    private JournalArticleLocalService _journalArticleLocalService;

    @Reference
    private DDMStructureLocalService _ddmStructureLocalService;
}
