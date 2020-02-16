import 'dart:js' as js;
import 'dart:html';
import 'package:flutter/foundation.dart';

class BrazWebUtils {

  static Map<String, String> getQueryParams({String url}){
    Map<String, String> result;
    if (kIsWeb){
      var uri = getUri(url:url);
      if (uri != null) {
        // uri.queryParameters.forEach((k,v) => print(k + " - " + v));
        result = uri.queryParameters;
      }
      return result;
    } 
    return result;
  }

  static String getQueryParam(String key, {String url}){
    var params = getQueryParams(url: url);
    return params[key];
  }

  static Uri getUri({String url}){
    Uri uri;
    if (kIsWeb){
      uri = Uri.tryParse(url ?? js.context['location']['href']);
    }
    return uri;
  }

  static String getCurrentRoute({String url}){
    var uri = getUri(url: url);
    return uri?.fragment;
  }

  static Browser getBrowser() {
    if (window.navigator.userAgent.contains("Opera") || window.navigator.userAgent.toUpperCase().contains('OPR')) {
      return Browser.Opera;
    } else if (window.navigator.userAgent.indexOf("Chrome") != -1) {
      return Browser.Chrome;
    } else if (window.navigator.userAgent.indexOf("Safari") != -1) {
      return Browser.Safari;
    } else if (window.navigator.userAgent.indexOf("Firefox") != -1) {
      return Browser.Firefox;
    } else if ((window.navigator.userAgent.indexOf("MSIE") != -1) 
      //|| (!!window.document.documentElement. == true)
      ){ //IF IE > 10
      return Browser.IE;
    } else {
      return Browser.Unknown;
    }
  }

  static QualityInternet getInternetQualityInfo(int value){
    if (value == null || value == 0) return QualityInternet.Unknown;
    if (value <= 200){
      return QualityInternet.VeryGood;
    } else if (value <= 500){
      return QualityInternet.Good;
    } else if (value <= 1000){
      return QualityInternet.Moderate;
    } else if (value <= 2000){
      return QualityInternet.Poor;
    } else {
      return QualityInternet.VeryPoor;
    }
  }
}

enum Browser {
  Opera, Chrome, Safari, Firefox, IE, Unknown
}

enum QualityInternet {VeryPoor, Poor, Moderate, Good, VeryGood, Unknown}