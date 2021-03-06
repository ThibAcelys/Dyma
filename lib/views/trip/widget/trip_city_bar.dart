import 'package:flutter/material.dart';

import '../../../model/city_model.dart';

class TripCityBar extends StatelessWidget {
  final City city;

  const TripCityBar({required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(city.image, fit: BoxFit.cover),
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(children: [
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back,
                          size: 30, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Expanded(
                  child: Center(
                      child: Text(
                city.name,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )))
            ]),
          ),
        ],
      ),
    );
  }
}
