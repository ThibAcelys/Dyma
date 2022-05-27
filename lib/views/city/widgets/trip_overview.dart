import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/trip_model.dart';
import 'trip_overview_city.dart';

class TripOverview extends StatelessWidget {
  final Function()? setDate;
  final Trip myTrip;
  final String cityName;
  final String cityImage;
  final double? amount;

  TripOverview(
      {this.amount,
      required this.cityName,
      this.setDate,
      required this.myTrip,
      required this.cityImage});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;

    return Container(
      width: orientation == Orientation.landscape
          ? size.width * 0.5
          : double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TripOverviewCity(
            cityName: cityName,
            cityImage: cityImage,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DateFormat("dd/MM/yyyy").format(myTrip.date) !=
                        DateFormat("dd/MM/yyyy").format(DateTime.now())
                    ? Expanded(
                        child: Text(
                        DateFormat("dd/MM/yyyy").format(myTrip.date),
                        style: const TextStyle(fontSize: 20),
                      ))
                    : const Text(
                        'Vos dates ',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: orientation == Orientation.landscape
                          ? const Size(150, 50)
                          : const Size(250, 25),
                      primary: Colors.grey),
                  child: const Text('selectionner une date',
                      style: TextStyle(fontSize: 20)),
                  onPressed: setDate,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Montant/personne :',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  '$amount € ',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
