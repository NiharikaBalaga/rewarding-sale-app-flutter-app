import 'package:http/http.dart' as http;
import 'package:rewarding_sale_app_flutter_app/services/storage/secureStorageService.dart';

import '../config/apiconfig.dart'; // Import the SecureStorageService

class ReportService {
  static Future<void> fetchReport(String postId, String reportType) async {
    try {
      var url = Uri.parse('${ApiConfig.baseUrlReport}${ApiConfig.getReportEndpoint}/$postId/report/$reportType');

      final secureStorageService = SecureStorageService();
      final authToken = await secureStorageService.read(SecureStorageService.keyAccessToken);

      // Make GET request with authorization header
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken', // Include authorization token in the headers
          'Content-Type': 'application/json', // Set content-type header
        },
      );

      // Check response status
      if (response.statusCode == 200) {
        print('Post Reported successfully');
      } else {
        // Error handling
        print('Error fetching report: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
