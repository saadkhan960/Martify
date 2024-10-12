import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  // Add copyWith method
  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profilePicture,
    String? userName,
  }) {
    return UserModel(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  // marge first name and last and make it full name
  String get userFullName => "$firstName $lastName";

  //Static fullname to first and last name
  static List<String> nameparts(fullName) => fullName.split(" ");

  //Static function to genenrate username from the full name

  static String gneerateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = "$firstName$lastName";
    String userNameWithPrefix = "martify_$camelCaseUserName";
    return userNameWithPrefix;
  }

//Convert Model into JSON structure for store in firestore
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture
    };
  }

  //Factory method to create userModel from a firestore document snapshot

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['firstName'],
          lastName: data['lastName'],
          userName: data['userName'],
          email: data['email'],
          phoneNumber: data['phoneNumber'],
          profilePicture: data['profilePicture']);
    } else {
      return UserModel.empty();
    }
  }

  //function for return empty usermodel
  static UserModel empty() => UserModel(
      id: "",
      firstName: "",
      lastName: "",
      userName: "",
      email: "",
      phoneNumber: "",
      profilePicture: "");
}
