import 'package:project/views/city/city_card.dart';
import 'package:project/widgets/Dyma_drawer.dart';
import 'package:provider/provider.dart';

import '../../../model/city_model.dart';
import '../../../provider/city_provider.dart';
import '../../city/city_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    List<City> cities = Provider.of<CityProvider>(context).cities;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dymatrip'),
      ),
      drawer: const DymaDrawer(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cities.map(
              (city) {
                return CityCard(city: city);
              },
            ).toList()),
      ),
    );
  }
}
