import 'package:project/model/place_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_KEY_API = 'AIzaSyD4K9VPcJyEIegFK4Cb6XG2Y-pE_Rk6FDY';
Uri _qeryAutocompleteBuilder(String query) {
  return Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=geocode&language=fr&key=$GOOGLE_KEY_API');
}

Future<List<Place>> getAutocompleteSuggestions(String query) async {
  try {
    var response = await http.get(_qeryAutocompleteBuilder(query));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return (body['predictions'] as List)
          .map((suggestion) => Place(
              description: suggestion['description'],
              placeId: suggestion['place_id']))
          .toList();
    } else {
      return [];
    }
  } catch (e) {
    rethrow;
  }
}
