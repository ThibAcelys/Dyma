import 'package:flutter/material.dart';
import 'package:project/model/activity_model.dart';
import 'package:project/provider/trip_provider.dart';
import 'package:provider/provider.dart';

import '../../../model/trip_model.dart';

class TripActivityList extends StatelessWidget {
  final String tripId;
  final ActivityStatus filter;

  TripActivityList({required this.tripId, required this.filter});

  @override
  Widget build(BuildContext context) {
    final Trip trip =
        Provider.of<TripProvider>(context, listen: false).getById(tripId);
    final List<Activity> activities = (trip.activities
        .where((activity) => activity.status == filter)).toList();

    return ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, i) {
          Activity activity = activities[i];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: filter == ActivityStatus.ongoing
                ? Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent[700],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    key: ValueKey(activity.id),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          activity.name,
                        ),
                      ),
                    ),
                    onDismissed: (_) {
                      print('dismissed');
                      Provider.of<TripProvider>(context, listen: false)
                          .upDateTrip(trip, activity.id);
                    },
                  )
                : Card(
                    child: ListTile(
                      title: Text(activity.name,
                          style: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
          );
        });
  }
}
