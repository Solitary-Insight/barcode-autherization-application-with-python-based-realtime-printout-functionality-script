import 'package:logger/web.dart';
import 'package:intl/intl.dart'; // Make sure to import intl package

class UserModel {
  String username;

  String mobile;

  String expiry_date;

  String expiry_time;

  String creation_time;

  String creation_date;
  String? key;

  UserModel(
      {required this.creation_date,
      required this.expiry_date,
      required this.expiry_time,
      required this.username,
      required this.mobile,
      required this.creation_time,
      this.key});

  String get name => username;
  String get k => key ?? "Key is null";

  // Factory method to create a UserModel from a Firebase snapshot
  factory UserModel.fromSnapshot(Map<String, dynamic> snapshot, String key) {
    return UserModel(
      creation_date: snapshot['creation_date'] ?? '',
      expiry_date: snapshot['expiry_date'] ?? '',
      expiry_time: snapshot['expiry_time'] ?? '',
      username: snapshot['username'] ?? '',
      mobile: snapshot['mobile'] ?? '',
      creation_time: snapshot['creation_time'] ?? '',
      key: key,
    );
  }

  static bool checkVerificationValidation(UserModel user) {
    // Correctly parse the expiry date and time (assuming you meant to use expiry date and time here)
    DateTime expiryDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse('${user.expiry_date} ${user.expiry_time}');
    DateTime currentDateTime = DateTime.now();

    // Check if current date and time is after expiryDateTime (indicating it's expired)
    if (expiryDateTime.isAfter(currentDateTime)) {
      return true;
    } else {
      return false;
    }
  }
}
