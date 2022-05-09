import 'package:flutter/material.dart';
import 'package:project/model/activity_model.dart';

class TripActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function deleteTripActivity;

  TripActivityList(
      {required this.activities, required this.deleteTripActivity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var activity = activities[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage(activities[index].image)),
              title: Text(activities[index].name,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(activities[index].city),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteTripActivity(activity.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Activité supprimée'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ));
                },
              ),
            ),
          );
        },
        itemCount: activities.length,
      ),
    );
  }
}
