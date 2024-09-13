import 'dart:convert';
import 'dart:io';

import 'package:covidapp/utilies/printValue.dart';
import 'package:covidapp/utilies/toastMess.dart';
import 'package:http/http.dart' as http;

class HttpNetworkHelper {
  Map<String, String> header(bool isrequestResponse) {
    if (isrequestResponse) {
      return {
        "Authorization": "Bearer {your access token}",
        'Content-Type': 'application/json',
      };
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }

  //getApi
  Future<dynamic> getApi({
    required String url,
    bool isRequireAuthorization = false,
  }) async {
    try {
      final apirespnse = await http.get(Uri.parse(url),
          headers: header(isRequireAuthorization));
      printvalue(url, tag: "Api Get url: ");
      printvalue(header(isRequireAuthorization), tag: "Api Header: ");
      printvalue(apirespnse.body, tag: "Api Response");
      return _returenResponse(apirespnse);
    } on SocketException {
      return null;
    }
  }
}

dynamic _returenResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responsejson = jsonDecode(response.body);
      return responsejson;
    case 201:
      var responseJson = jsonDecode(response.body);
      return responseJson;

    case 400:
      var decodeError = jsonDecode(response.body);
      if (decodeError.containsKey('error')) {
        toastMessage(decodeError['error'].toString());
      }
      throw Exception('API error status Code 400');
    case 401:
      toastMessage("UnAuthorised url 401");
      throw Exception("UnAuthorised url 401");

    case 500:
      toastMessage(
          "Error occure while communication with server with statusCode 500");
      throw Exception(
          "Error occure while communication with server with statusCode 500");

    default:
      toastMessage(
          "Error occure while communication with server with statusCode ${response.statusCode.toString()}");
      throw Exception(
          "Error occure while communication with server with statusCode ${response.statusCode.toString()}");
  }
  // return null;
}
