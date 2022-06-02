import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:adequate_travel_app/Models/login_model.dart';

WebRequester(String URL, Map param) async {
print(URL);
print(param);
  String url = URL;
  print(await apiRequest(url, param));
}

Future<String> apiRequest(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();



  var reply = await response.transform(utf8.decoder).join();
  httpClient.close();

  print(reply);

  return reply;
}