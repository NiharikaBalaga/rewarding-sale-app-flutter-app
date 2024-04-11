class ApiConfig {

  // Auth service
  static const String baseUrlAuth = 'http://10.0.2.2:3000/api';
  static const String generateOtpEndpoint = '/auth/otp/generate';
  static const String verifyOtpEndpoint = '/auth/otp/verify';
  static const String currentUserEndpoint = '/auth/user';
  static const String userLocationEndpoint = '/auth/user/location';
  static const String refreshTokenEndpoint = '/auth/token/refresh';
  static const String signupUserEndpoint ='/auth/user/signup';
  static const String baseUrlPost = 'http://10.0.2.2:3001/api';
  static const String getPostEndpoint = '/post/allpost';
  static const String logoutUser = '/auth/user/logout';
}