import 'dart:js' as js;
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

}