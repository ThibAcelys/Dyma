import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

import '../model/city_model.dart';

class CityProvider with ChangeNotifier {
  bool isLoading = false;
  final String host = "http://10.0.2.2:3001";
  List<City> _cities = [];

  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);
  City getCityByName(String cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  UnmodifiableListView<City> getFilteredCities(String filter) =>
      UnmodifiableListView(
        _cities
            .where(
              (city) => city.name.toLowerCase().startsWith(
                    filter.toLowerCase(),
                  ),
            )
            .toList(),
      );

  Future<void> fetchData() async {
    try {
      isLoading = true;

      http.Response response = await http.get(Uri.parse('$host/api/cities'));
      if (response.statusCode == 200) {
        _cities = ((json.decode(response.body) as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList());
        isLoading = false;

        notifyListeners();
      }
    } catch (e) {
      isLoading = false;

      rethrow;
    }
  }
}
