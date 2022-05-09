import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/provider/city_provider.dart';
import 'package:project/views/home/widgets/home_view.dart';
import 'package:project/widgets/Dyma_drawer.dart';
import 'package:provider/provider.dart';

import '../../../model/city_model.dart';
import '../../../provider/trip_provider.dart';
import '../widgets/activity_list.dart';
import '../widgets/trip_activity_list.dart';
import '../widgets/trip_overview.dart';

import '../../../model/activity_model.dart';
import '../../../model/trip_model.dart';

class CityView extends StatefulWidget {
  static const String routeName = '/city';

  @override
  State<CityView> createState() => _CityState();
}

class _CityState extends State<CityView> with WidgetsBindingObserver {
  late Trip myTrip;
  late int index;
  double amount = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    myTrip = Trip(
      activities: [],
      city: 'Ville',
      date: DateTime.now(),
    );
    index = 0;
    super.initState();
  }

  showContext({required BuildContext context, required List<Widget> children}) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
    } else {
      return Column(children: children);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 765)),
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          myTrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(Activity activity) {
    setState(() {
      if (myTrip.activities.contains(activity)) {
        myTrip.activities.remove(activity);
        amount -= activity.price;
      } else {
        myTrip.activities.add(activity);
        amount += activity.price;
      }
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      myTrip.activities.remove(activity);
      amount -= activity.price;
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Voulez-vous sauvegarder?'),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'canceled');
                    },
                    child: const Text('Annuler'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey))),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'saved');
                    },
                    child: const Text('Sauvegarder')),
              ],
            )
          ],
        );
      },
    );
    if (result == 'saved') {
      // widget.addTrip(myTrip);
      myTrip.city = cityName;
      Provider.of<TripProvider>(context).addTrip(myTrip);
      Navigator.pushNamed(context, HomeView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)?.settings.arguments as String;
    City city = Provider.of<CityProvider>(context).getCityByName(cityName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation voyage'),
        actions: const <Widget>[
          Icon(Icons.more_vert),
        ],
      ),
      drawer: const DymaDrawer(),
      body: Container(
        child: showContext(
          context: context,
          children: <Widget>[
            TripOverview(
                cityName: city.name,
                setDate: setDate,
                myTrip: myTrip,
                amount: amount),
            Expanded(
                child: index == 0
                    ? ActivityList(
                        activities: city.activities,
                        selectedActivities: myTrip.activities,
                        toggleActivity: toggleActivity,
                      )
                    : TripActivityList(
                        activities: myTrip.activities,
                        deleteTripActivity: deleteTripActivity,
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: (DateFormat("dd/MM/yyyy").format(myTrip.date) !=
                    DateFormat("dd/MM/yyyy").format(DateTime.now())) &&
                myTrip.activities.isNotEmpty
            ? () {
                saveTrip(city.name);
              }
            : () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Veuillez selectionner un date et au moins une activité'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2)));
              },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Découverte",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: "Mes activités",
          )
        ],
        onTap: switchIndex,
      ),
    );
  }
}
