import '../model/activity_model.dart';
import '../model/city_model.dart';
import '../model/trip_model.dart';

List<City> cities = [
  City(
    name: 'Paris',
    image: 'assets/images/paris.jpg',
    activities: [
      Activity(
        image: 'assets/images/activities/louvre.jpg',
        name: 'Louvre',
        id: 'a1',
        city: 'Paris',
        price: 12.00,
      ),
      Activity(
        image: 'assets/images/activities/chaumont.jpg',
        name: 'Chaumont',
        id: 'a2',
        city: 'Paris',
        price: 0.00,
      ),
      Activity(
        image: 'assets/images/activities/notreDame.jpg',
        name: 'Notre Dame',
        id: 'a3',
        city: 'Paris',
        price: 15.00,
      ),
      Activity(
        image: 'assets/images/activities/laDefense.jpg',
        name: 'La Défense',
        id: 'a4',
        city: 'Paris',
        price: 0.00,
      ),
      Activity(
        image: 'assets/images/activities/BFM.jpg',
        name: 'Bibliothèque François Miterrand',
        id: 'a5',
        city: 'Paris',
        price: 1.00,
      ),
      Activity(
        image: 'assets/images/activities/jeuPaume.jpg',
        name: 'jeu de Paume',
        id: 'a6',
        city: 'Paris',
        price: 11.00,
      ),
      Activity(
        image: 'assets/images/activities/tourEiffel.jpg',
        name: 'La Tour Eiffel',
        id: 'a7',
        city: 'Paris',
        price: 21.00,
      ),
    ],
  ),
  City(
    name: 'Lyon',
    image: 'assets/images/Lyon.jpg',
    activities: [
      Activity(
        image: 'assets/images/activities/lyon/bellecourt.jpg',
        name: 'Place Bellecourt',
        id: 'a8',
        city: 'Lyon',
        price: 0.00,
      ),
      Activity(
        image: 'assets/images/activities/lyon/cat_st_jean.jpg',
        name: 'Cathédrale de Saint-Jean',
        id: 'a9',
        city: 'Lyon',
        price: 1.00,
      ),
      Activity(
        image: 'assets/images/activities/lyon/musee_beaux_art.jpg',
        name: 'Musée des beaux Arts',
        id: 'a10',
        city: 'Lyon',
        price: 10.00,
      ),
    ],
  ),
  City(
    name: 'Nice',
    image: 'assets/images/Nice.jpg',
    activities: [
      Activity(
        image: 'assets/images/activities/nice/anglais.jpg',
        name: 'Promenade des Anglais',
        id: 'a11',
        city: 'Nice',
        price: 0.00,
      ),
      Activity(
        image: 'assets/images/activities/nice/carnaval.jpg',
        name: 'Carnaval de Nice',
        id: 'a12',
        city: 'Nice',
        price: 0.00,
      ),
      Activity(
        image: 'assets/images/activities/nice/matisse.jpg',
        name: 'Musée Matisse',
        id: 'a13',
        city: 'Nice',
        price: 10.00,
      ),
      Activity(
        image: 'assets/images/activities/nice/parc_chateau.jpg',
        name: 'Parc du Château',
        id: 'a14',
        city: 'Nice',
        price: 1.00,
      ),
    ],
  ),
];

List<Trip> trips = [
  Trip(
    activities: [
      Activity(
        image: 'assets/images/activities/louvre.jpg',
        name: 'Louvre',
        id: 'a1',
        city: 'Paris',
        price: 12.00,
      ),
      Activity(
        image: 'assets/images/activities/chaumont.jpg',
        name: 'Chaumont',
        id: 'a2',
        city: 'Paris',
        price: 0.00,
        status: ActivityStatus.done,
      ),
      Activity(
        image: 'assets/images/activities/notreDame.jpg',
        name: 'Notre Dame',
        id: 'a3',
        city: 'Paris',
        price: 15.00,
      ),
    ],
    city: 'Paris',
    date: DateTime.now().add(
      const Duration(days: 1),
    ),
  ),
  Trip(
      activities: [],
      city: 'Lyon',
      date: DateTime.now().add(const Duration(days: 2))),
  Trip(
      activities: [],
      city: 'Nice',
      date: DateTime.now().subtract(const Duration(days: 1))),
];
