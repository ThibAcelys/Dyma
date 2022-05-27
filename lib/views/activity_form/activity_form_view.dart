import 'package:flutter/material.dart';
import 'package:project/widgets/Dyma_drawer.dart';

import 'widgets/activity_form.dart';

class ActivityFormView extends StatelessWidget {
  static const String routeName = '/activity-form';
  const ActivityFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String cityName = (ModalRoute.of(context)!.settings.arguments).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une activité'),
      ),
      drawer: DymaDrawer(),
      body: ActivityForm(cityName: cityName),
    );
  }
}
