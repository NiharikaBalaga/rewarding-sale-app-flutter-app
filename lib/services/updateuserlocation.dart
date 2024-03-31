import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class LocationService {
  static Future<void> updateUserLocation(double latitude, double longitude) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlAuth}${ApiConfig.userLocationEndpoint}';
      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      if (response.statusCode == 200) {
        print('User location updated successfully');
      } else {
        throw Exception('Failed to update user location: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update user location: $error');
    }
  }
}
