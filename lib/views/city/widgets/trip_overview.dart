import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/trip_model.dart';

class TripOverview extends StatelessWidget {
  final Function()? setDate;
  final Trip myTrip;
  final String? cityName;
  final double? amount;

  TripOverview(
      {this.amount, this.cityName, this.setDate, required this.myTrip});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      width: orientation == Orientation.landscape
          ? size.width * 0.5
          : double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(cityName!,
              style: const TextStyle(
                  fontSize: 25, decoration: TextDecoration.underline)),
          const SizedBox(
            height: 30,
          ),
          Row(
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
          const SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Montant/personne :',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                '$amount € ',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
