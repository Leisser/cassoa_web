// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
    int userId;
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
    DateTime dateCreated;
    dynamic dateModified;
    bool isClerk;
    bool isAdmin;
    bool isSuperAdmin;
    bool isAAdmin;
    int status;
    String? token;

    UserLogin({
        required this.userId,
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
        required this.dateCreated,
        this.dateModified,
        required this.isClerk,
        required this.isAdmin,
        required this.isSuperAdmin,
        required this.isAAdmin,
        required this.status,
        this.token,
    });

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        userId: json["user_id"],
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
        dateCreated: DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"],
        isClerk: json["is_clerk"],
        isAdmin: json["is_admin"],
        isSuperAdmin: json["is_super_admin"],
        isAAdmin: json["is_a_admin"],
        status: json["status"],
        token: json["token"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
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
        "date_created": dateCreated.toIso8601String(),
        "date_modified": dateModified,
        "is_clerk": isClerk,
        "is_admin": isAdmin,
        "is_super_admin": isSuperAdmin,
        "is_a_admin": isAAdmin,
        "status": status,
        "token": token,
    };
}
