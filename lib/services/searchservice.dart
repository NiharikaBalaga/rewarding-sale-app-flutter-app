import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';
import '../models/Post.dart';


class SearchService {
  static Future<Iterable<Post> Function(Post Function(dynamic e) toElement)> search(String query) async {
    try {
      // Construct the API URL for searching
      final String apiUrl = '${ApiConfig.baseUrlSearch}${ApiConfig.getSearchEndpoint}?q=$query';

      // Retrieve the access token from secure storage
      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      // Check if the access token is available
      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      // Construct the request headers with content type and authorization
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Perform an HTTP GET request to the search API endpoint
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body as JSON

        final List<dynamic> responseData = json.decode(response.body)['data'];
        return responseData.map<Post>;

        // Extract the search results from the response


       // final List<dynamic> searchResults = responseData['results'];
       // print('Search results retrieved successfully');
       // return searchResults;
      } else {
        // Throw an exception if the request fails
        throw Exception('Failed to retrieve search results: ${response.statusCode}');
      }
    } catch (error) {
      // Catch any errors and throw an exception with an appropriate error message
      throw Exception('Failed to perform search: $error');
    }
  }
}
