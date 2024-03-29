import 'dart:convert';

import 'package:rewarding_sale_app_flutter_app/Enums/httpenums.dart';
import 'package:rewarding_sale_app_flutter_app/config/apiconfig.dart';
import 'package:rewarding_sale_app_flutter_app/helpers/httpclient.dart';

import '../storage/secureStorageService.dart';

class AuthService {
  final SecureStorageService secureStorageService = SecureStorageService();

  // Keys for secure storage
  static const String _keyAccessToken = SecureStorageService.keyAccessToken;
  static const String _keyRefreshToken = SecureStorageService.keyRefreshToken;

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final accessToken = await _getAccessToken();
      if (accessToken == null) return {};

      final response = await HttpClient.sendRequest(
        HttpMethod.GET,
        null, // No payload for GET request
        '${ApiConfig.baseUrlAuth}${ApiConfig.currentUserEndpoint}',
        authToken: accessToken,
      );

      if (response.statusCode == 403) {
        // user is blocked
        return {'isBlocked': true};
      }

      if (response.statusCode != 200) {
        await _handleTokenRefresh();
        final newAccessToken = await _getAccessToken();
        if (newAccessToken == null) return {};
        final newCurrentUserResponse = await HttpClient.sendRequest(
          HttpMethod.GET,
          null, // No payload for GET request
          '${ApiConfig.baseUrlAuth}${ApiConfig.currentUserEndpoint}',
          authToken: newAccessToken,
        );
        return jsonDecode(newCurrentUserResponse.body);
      }

      return jsonDecode(response.body);
    } catch (error) {
      print("getCurrentUser-error----${error}");
      rethrow;
    }
  }

  Future<String?> _getAccessToken() async {
    return secureStorageService.read(_keyAccessToken);
  }

  Future<void> _handleTokenRefresh() async {
    final refreshToken = await secureStorageService.read(_keyRefreshToken);
    if (refreshToken == null) return;

    final response = await HttpClient.sendRequest(
      HttpMethod.GET,
      null, // No payload for GET request
      '${ApiConfig.baseUrlAuth}${ApiConfig.refreshTokenEndpoint}',
      authToken: refreshToken,
    );

    if (response.statusCode != 200) {
      await secureStorageService.delete(_keyRefreshToken);
      return;
    }

    final responseBody = jsonDecode(response.body);
    final newAccessToken = responseBody['accessToken'];
    final newRefreshToken = responseBody['refreshToken'];

    await secureStorageService.write(_keyAccessToken, newAccessToken);
    await secureStorageService.write(_keyRefreshToken, newRefreshToken);
  }
}
