

class CurrentUser {
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final bool isBlocked;
  final double lastLongitude;
  final double lastLatitude;
  final bool signedUp;
  final String id;

  CurrentUser({
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isBlocked,
    required this.lastLongitude,
    required this.lastLatitude,
    required this.signedUp,
    required this.id,
  });

  factory CurrentUser.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Failed to parse JSON: Data is null');
    }
    return CurrentUser(
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      lastLongitude: (json['lastLongitude'] ?? 0).toDouble(), // Convert to double
      lastLatitude: (json['lastLatitude'] ?? 0).toDouble(), // Convert to double
      signedUp: json['signedUp'] ?? false,
      id: json['id'] ?? '',
    );
  }


}
