import 'dart:convert';

import 'package:flutter/foundation.dart';
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
      if (kDebugMode) {
        print("getCurrentUser-error----$error");
      }
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
  
  Future updateUserLocation(double longitude, double latitude) async {
    try {
      // Compare last location to check should we make the API call
      var lastLongitude =
      await secureStorageService.read(SecureStorageService.KeyLongitude);
      var lastLatitude =
      await secureStorageService.read(SecureStorageService.KeyLatitude);


      if (lastLongitude != null && lastLatitude != null) {
        if (double.parse(lastLongitude) == longitude &&
            double.parse(lastLatitude) == latitude) {
          return;
        }
      }
      final payload =
      jsonEncode({'longitude': longitude, 'latitude': latitude});
      final authToken = await _getAccessToken();
      final response = await HttpClient.sendRequest(HttpMethod.PATCH, payload,
          '${ApiConfig.baseUrlAuth}${ApiConfig.userLocationEndpoint}',
          authToken: authToken);

      if (response.statusCode == 200) {
        // Sore the location into storage
        await secureStorageService.write(
            SecureStorageService.KeyLongitude, longitude.toString());
        await secureStorageService.write(
            SecureStorageService.KeyLatitude, latitude.toString());
      }
      if (kDebugMode) {
        print('User-Location-Update:${response.statusCode}, ${response.body}');
      }
    } catch (error) {
      if (kDebugMode) {
        print("updateUserLocation-error----$error");
      }
    }
  }

  Future<bool> logoutUser() async {
    try {
      final authToken = await _getAccessToken();
      await HttpClient.sendRequest(
          HttpMethod.GET, null, '${ApiConfig.baseUrlAuth}${ApiConfig.logoutUser}',
          authToken: authToken);

      // Clear Up all tokens and Locations
      await secureStorageService.deleteAll();

      return true;
    } catch (error) {
      if (kDebugMode) {
        print("logoutUser-error----$error");
      }
      return false;
    }
  }

}
