// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String password;
    String firstName;
    String lastName;
    String otherName;
    String address;
    String phoneNumber;
    String email;
    String passportNumber;
    String nationalIdentificationNumber;
    DateTime dateOfBirth;
    String country;
    bool isClerk;
    bool isAdmin;
    bool isSuperAdmin;
    bool isAAdmin;
    int status;

    User({
        required this.password,
        required this.firstName,
        required this.lastName,
        required this.otherName,
        required this.address,
        required this.phoneNumber,
        required this.email,
        required this.passportNumber,
        required this.nationalIdentificationNumber,
        required this.dateOfBirth,
        required this.country,
        required this.isClerk,
        required this.isAdmin,
        required this.isSuperAdmin,
        required this.isAAdmin,
        required this.status,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        password: json["password"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        otherName: json["other_name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        passportNumber: json["passport_number"],
        nationalIdentificationNumber: json["national_identification_number"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        country: json["country"],
        isClerk: json["is_clerk"],
        isAdmin: json["is_admin"],
        isSuperAdmin: json["is_super_admin"],
        isAAdmin: json["is_a_admin"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "other_name": otherName,
        "address": address,
        "phone_number": phoneNumber,
        "email": email,
        "passport_number": passportNumber,
        "national_identification_number": nationalIdentificationNumber,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "country": country,
        "is_clerk": isClerk,
        "is_admin": isAdmin,
        "is_super_admin": isSuperAdmin,
        "is_a_admin": isAAdmin,
        "status": status,
    };
}
