import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

import '../model/city_model.dart';

class CityProvider with ChangeNotifier {
  bool isLoading = false;

  List<City> _cities = [];

  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);
  final String host = "http://10.0.2.2:3001";
  City getCityByName(String cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  Future<void> fetchData() async {
    try {
      isLoading = true;

      http.Response response = await http.get(Uri.parse('$host/api/cities'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        _cities = ((json.decode(response.body) as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList());
        isLoading = false;

        notifyListeners();
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading = false;

      rethrow;
    }
  }
}
