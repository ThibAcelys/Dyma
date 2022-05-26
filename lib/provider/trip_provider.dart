import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/model/activity_model.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import '../model/trip_model.dart';

class TripProvider with ChangeNotifier {
  List<Trip> _trips = [];
  final String host = "http://10.0.2.2:3001";
  bool isLoading = false;
  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse('$host/api/trips'));
      if (response.statusCode == 200) {
        _trips = (jsonDecode(response.body) as List)
            .map(
              (tripJson) => Trip.fromJson(tripJson),
            )
            .toList();

        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> addTrip(Trip trip) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$host/api/trip'),
        body: json.encode(trip.toJson()),
        headers: {'Content-type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        _trips.add(
          Trip.fromJson(
            json.decode(response.body),
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> upDateTrip(Trip trip, String activityId) async {
    try {
      Activity activity =
          trip.activities.firstWhere((activity) => activity.id == activityId);
      activity.status = ActivityStatus.done;

      http.Response response = await http.put(
        Uri.parse('$host/api/trip'),
        body: json.encode(
          trip.toJson(),
        ),
        headers: {'Content-type': 'application/json'},
      );
      if (response.statusCode != 200) {
        activity.status = ActivityStatus.ongoing;
        throw const HttpException('error');
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Trip getById(String tripId) {
    return trips.firstWhere((trip) => trip.id == tripId);
  }
}
