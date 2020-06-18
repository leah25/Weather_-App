import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Networking {
  final String url;

  Networking({this.url});

  Future getNetworkingData() async {
    http.Response response = await http.get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
      

    }
    else {
      print(response.statusCode);
    }
  }
}