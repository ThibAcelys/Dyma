import 'package:project/views/city/city_card.dart';
import 'package:project/widgets/Dyma_drawer.dart';
import 'package:project/widgets/Dyma_loader.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);

    List<City> filteredCities =
        cityProvider.getFilteredCities(searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dymatrip'),
      ),
      drawer: const DymaDrawer(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher une ville',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() => searchController.clear());
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                    onRefresh: Provider.of<CityProvider>(context).fetchData,
                    child: cityProvider.isLoading
                        ? const DymaLoader()
                        : filteredCities.isNotEmpty
                            ? ListView.builder(
                                itemCount: filteredCities.length,
                                itemBuilder: (context, i) => CityCard(
                                  city: filteredCities[i],
                                ),
                              )
                            : const Text('Aucun résultat'))),
          ),
        ],
      ),
    );
  }
}
