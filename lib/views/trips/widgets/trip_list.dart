import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/trip_model.dart';
import '../../trip/widget/one_trip_view.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;

  TripList({required this.trips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, i) {
        var trip = trips[i];
        return ListTile(
          title: Text(trip.city),
          subtitle: Text(DateFormat("d/M/y").format(trip.date)),
          trailing: const Icon(Icons.info),
          onTap: () {
            Navigator.pushNamed(context, OneTripView.routeName,
                arguments: {'tripId': trip.id, 'cityName': trip.city});
          },
        );
      },
    );
  }
}
