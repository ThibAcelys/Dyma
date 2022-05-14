import 'package:flutter/material.dart';
import 'package:project/provider/trip_provider.dart';
import 'package:project/views/trips/widgets/trip_list.dart';
import 'package:project/widgets/Dyma_loader.dart';
import 'package:provider/provider.dart';
import '../../../widgets/Dyma_drawer.dart';

class TripView extends StatelessWidget {
  static const String routeName = '/trips';
  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider =
        Provider.of<TripProvider>(context, listen: false);

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
          body: tripProvider.isLoading != true
              ? tripProvider.trips.isNotEmpty
                  ? TabBarView(
                      children: <Widget>[
                        TripList(
                          trips: tripProvider.trips
                              .where(
                                  (trip) => DateTime.now().isBefore(trip.date))
                              .toList(),
                        ),
                        TripList(
                          trips: tripProvider.trips
                              .where(
                                  (trip) => DateTime.now().isAfter(trip.date))
                              .toList(),
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: const Text('Aucun voyage pour le moment'))
              : const DymaLoader()),
    );
  }
}
