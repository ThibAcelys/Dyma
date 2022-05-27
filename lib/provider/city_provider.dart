import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

import '../model/activity_model.dart';
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

  Future<void> addActivityToCity(Activity newActivity) async {
    try {
      String cityId = getCityByName(newActivity.city).id;
      http.Response response = await http.post(
        Uri.parse('$host/api/city/$cityId/activity'),
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          newActivity.toJson(),
        ),
      );
      if (response.statusCode == 200) {
        int index = _cities.indexWhere((city) => city.id == cityId);
        _cities[index] = City.fromJson(
          json.decode(response.body),
        );
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> verifyIfActivityNameIsUnique(
      String cityName, String activityName) async {
    try {
      City city = getCityByName(cityName);
      http.Response response = await http.get(Uri.parse(
          '$host/api/city/${city.id}/activities/verify/$activityName'));
      return json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
