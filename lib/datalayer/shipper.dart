class UserDetails {
  final String? id;
  final String? userName;
  final bool? lawyer;
  final String? phoneNumber;
  final String? email;

  UserDetails({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.lawyer,
  });

  factory UserDetails.fromJson(Map<String, dynamic>? json) {
    return UserDetails(
      id: json?["id"],
      userName: json?["FirstName"],
      phoneNumber: json?["PhoneNumber"],
      email: json?["Email"],
      lawyer: json?["lawyer"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "FirstName": userName,
      "PhoneNumber": phoneNumber,
      "Email": email,
      "lawyer": lawyer,
      "id": id,
    };
  }
}
