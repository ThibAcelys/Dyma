import 'package:flutter/material.dart';
import '../../model/city_model.dart';

class CityCard extends StatelessWidget {
  final City city;

  const CityCard({required this.city});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: Hero(
                tag: city.name,
                child: Image.network(
                  city.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/city',
                    arguments: city.name,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black26,
                  child: Text(
                    city.name,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
