import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class RewardsService {
  static Future<int> fetchPoints() async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlRewards}${ApiConfig.getRewardsEndpoint}';
      final secureStorageService = SecureStorageService();
      final accessToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      if (accessToken == null) {
        throw Exception('Access token not available');
      }

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Include authorization header
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final int points = responseData['points']; // Adjust the JSON key according to your API response
        return points;
      } else {
        throw Exception('Failed to load points: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load points: $error');
    }
  }
}
