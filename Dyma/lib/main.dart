import 'package:flutter/material.dart';
import 'package:project/provider/city_provider.dart';
import 'package:project/views/404/not_found.dart';
import 'package:project/views/city/widgets/city_view.dart';
import 'package:project/views/home/widgets/home_view.dart';
import 'package:project/views/trip/widget/one_trip_view.dart';
import 'package:provider/provider.dart';
import 'provider/trip_provider.dart';
import 'views/activity_form/activity_form_view.dart';
import 'views/trips/widgets/trips_view.dart';

main() {
  runApp(DymaTrip());
}

class DymaTrip extends StatefulWidget {
  @override
  _DymaTripState createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {
  final CityProvider cityProvider = CityProvider();
  final TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    cityProvider.fetchData();
    tripProvider.fetchData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cityProvider),
        ChangeNotifierProvider.value(value: tripProvider),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            appBarTheme: AppBarTheme(
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    titleLarge: const TextStyle(fontSize: 25),
                  )
                  .headline6,
            ),
          ),
          debugShowCheckedModeBanner: false,
          //home: HomeView(),
          routes: {
            '/': (context) => HomeView(),
            CityView.routeName: (_) => CityView(),
            TripView.routeName: (_) => TripView(),
            OneTripView.routeName: (_) => OneTripView(),
            ActivityFormView.routeName: (_) => ActivityFormView(),
          },
          onUnknownRoute: (_) =>
              MaterialPageRoute(builder: (_) => const notFound())),
    );
  }
}
