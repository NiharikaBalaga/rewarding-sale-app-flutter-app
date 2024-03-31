import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getPlaceId(double latitude, double longitude) async {
  final apiKey = 'AIzaSyCIUjdsc04Iz_cBue2VIoCOLbfzV38qtR8'; // Replace with your Google API key
  final url = 'https://maps.googleapis.com/maps/api/geocode/json'
      '?latlng=$latitude,$longitude'
      '&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final results = jsonResponse['results'];
    if (results.isNotEmpty) {
      return results[0]['place_id'];
    } else {
      throw Exception('No place found for the provided coordinates.');
    }
  } else {
    throw Exception('Failed to load place data');
  }
}
