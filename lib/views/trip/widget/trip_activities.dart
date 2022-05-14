import 'package:flutter/material.dart';
import 'package:project/model/activity_model.dart';
import 'package:project/views/trip/widget/trip_activity_list.dart';

class TripActivities extends StatelessWidget {
  final String tripId;

  TripActivities({required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                  unselectedLabelColor: Colors.white54,
                  indicatorColor: Colors.deepPurple[200],
                  tabs: const [
                    Tab(text: 'En cours'),
                    Tab(text: 'Terminé'),
                  ]),
            ),
            Container(
              height: 600,
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TripActivityList(
                      tripId: tripId,
                      filter: ActivityStatus.ongoing,
                    ),
                    TripActivityList(
                      tripId: tripId,
                      filter: ActivityStatus.done,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
