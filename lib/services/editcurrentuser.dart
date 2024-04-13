import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';
import '../config/apiconfig.dart';

class UserProfileService {
  final SecureStorageService _secureStorageService = SecureStorageService();

  Future<Map<String, dynamic>>updateProfile(String firstName, String email) async {
    try {
      final String apiUrl = '${ApiConfig.baseUrlAuth}${ApiConfig.updateUserEndpoint}';
      final String? token = await _secureStorageService.read(SecureStorageService.keyAccessToken);

      if (token == null) {
        return {'success': false, 'error': 'Access token not found'};
      }

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'firstName': firstName,
          'email': email
        }),
      );

      if (response.statusCode == 200) {
        print("User profile updated successfully: ${response.reasonPhrase}");
        return {'success': true};
      } else {
        print("Failed to update user profile: ${response.reasonPhrase}");
        return {'success': false, 'error': response.reasonPhrase};
      }
    } catch (error) {
      print("UserProfileService Error: $error");
      return {'success': false, 'error': 'An unexpected error occurred'};
    }
  }
}
