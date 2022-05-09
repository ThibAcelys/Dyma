import 'package:flutter/material.dart';
import 'package:project/views/trip/widget/trip_activities.dart';
import 'package:project/views/trip/widget/trip_city_bar.dart';
import 'package:provider/provider.dart';

import '../../../model/city_model.dart';
import '../../../model/trip_model.dart';
import '../../../provider/city_provider.dart';
import '../../../provider/trip_provider.dart';

class OneTripView extends StatelessWidget {
  static const String routeName = '/trip';

  @override
  Widget build(BuildContext context) {
    print('BUILD : TRIPVIEW');

    final String cityName =
        (ModalRoute.of(context)?.settings.arguments as Map)['cityName'];

    final String tripId =
        (ModalRoute.of(context)?.settings.arguments as Map)['tripId'];

    final City city = Provider.of<CityProvider>(context, listen: false)
        .getCityByName(cityName);

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          TripCityBar(
            city: city,
          ),
          TripActivities(
            tripId: tripId,
          )
        ],
      )),
    );
  }
}
