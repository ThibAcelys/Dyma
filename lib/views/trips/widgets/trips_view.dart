import 'package:flutter/material.dart';
import 'package:project/provider/trip_provider.dart';
import 'package:project/views/trips/widgets/trip_list.dart';
import 'package:provider/provider.dart';

import '../../../model/trip_model.dart';
import '../../../widgets/Dyma_drawer.dart';

class TripView extends StatelessWidget {
  static const String routeName = '/trips';
  @override
  Widget build(BuildContext context) {
    List<Trip> trips = Provider.of<TripProvider>(context).trips;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Mes voyages'),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'A venir',
              ),
              Tab(
                text: 'Passés',
              ),
            ]),
          ),
          drawer: const DymaDrawer(),
          body: TabBarView(
            children: <Widget>[
              TripList(
                trips: trips
                    .where((trip) => DateTime.now().isBefore(trip.date))
                    .toList(),
              ),
              TripList(
                trips: trips
                    .where((trip) => DateTime.now().isAfter(trip.date))
                    .toList(),
              ),
            ],
          )),
    );
  }
}
