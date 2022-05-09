import 'package:flutter/material.dart';
import 'package:project/views/home/widgets/home_view.dart';

import '../views/trips/widgets/trips_view.dart';

class DymaDrawer extends StatelessWidget {
  const DymaDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      DrawerHeader(
        child: const Text(
          'DymaTrip',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Accueil'),
        onTap: () {
          Navigator.pushNamed(context, HomeView.routeName);
        },
      ),
      ListTile(
        leading: Icon(Icons.flight),
        title: Text('Mes voyages'),
        onTap: () {
          Navigator.pushNamed(context, TripView.routeName);
        },
      ),
    ]));
  }
}
