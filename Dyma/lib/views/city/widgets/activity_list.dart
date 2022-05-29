import 'package:flutter/material.dart';
import 'package:project/model/activity_model.dart';
import './activity_card.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final List<Activity> selectedActivities;
  final Function toggleActivity;

  const ActivityList(
      {required this.activities,
      required this.selectedActivities,
      required this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      crossAxisCount: 2,
      children: activities
          .map(
            (activity) => ActivityCard(
              activity: activity,
              isSelected: selectedActivities.contains(activity),
              toggleActivity: () {
                toggleActivity(activity);
              },
            ),
          )
          .toList(),
    );
  }
}
