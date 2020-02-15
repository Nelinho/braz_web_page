import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class WebUtils {

  static Map<String, String> getQueryParams({String url}){
    Map<String, String> result;
    if (kIsWeb){
      var uri = Uri.tryParse(url ?? js.context['location']['href']);
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
}