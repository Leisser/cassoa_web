// import 'dart:convert';
// // import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../../config/base.dart';
// import '../../config/constants.dart';
// import '../../models/userModel.dart';
// import 'sign_in.dart';
// import 'package:intl/intl.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends Base<SignUpPage> {
//   String? password;
//   String? password2;
//   String? firstName;
//   String? lastName;
//   String? otherName;
//   String? address;
//   String? phoneNumber;
//   String? email;
//   String? passportNumber;
//   String? nationalIdentificationNumber;
//   DateTime? dateOfBirth;
//   Country? selectedCountry;
//   String initialCountry = 'US';
//   PhoneNumber number = PhoneNumber(isoCode: 'US');
//   TextEditingController? passwordController = TextEditingController();
//   TextEditingController? password2Controller = TextEditingController();
//   TextEditingController? firstNameController = TextEditingController();
//   TextEditingController? lastNameController = TextEditingController();
//   TextEditingController? otherNameController = TextEditingController();
//   TextEditingController? addressController = TextEditingController();
//   TextEditingController? phoneNumberController = TextEditingController();
//   TextEditingController? emailController = TextEditingController();
//   TextEditingController? passportNumberController = TextEditingController();
//   TextEditingController? nationalIdentificationNumberController =
//       TextEditingController();
//   FocusNode? passwordFocus = FocusNode();
//   FocusNode? password2Focus = FocusNode();
//   FocusNode? firstNameFocus = FocusNode();
//   FocusNode? lastNameFocus = FocusNode();
//   FocusNode? otherNameFocus = FocusNode();
//   FocusNode? addressFocus = FocusNode();
//   FocusNode? phoneNumberFocus = FocusNode();
//   FocusNode? emailFocus = FocusNode();
//   FocusNode? passportNumberFocus = FocusNode();
//   FocusNode? nationalIdentificationNumberFocus = FocusNode();
//   bool _responseLoading = false;
//   String _validatedphoneNumber = "";

//   checkIfFilled() {
//     if (password!.isNotEmpty &&
//         password2!.isNotEmpty &&
//         firstName!.isNotEmpty &&
//         lastName!.isNotEmpty &&
//         otherName!.isNotEmpty &&
//         address!.isNotEmpty &&
//         phoneNumber!.isNotEmpty &&
//         email!.isNotEmpty &&
//         passportNumber!.isNotEmpty &&
//         nationalIdentificationNumber!.isNotEmpty &&
//         dateOfBirth!.toString().isNotEmpty &&
//         selectedCountry!.displayName.isNotEmpty) {
//       if (password == password2) {
//         _register();
//       } else {
//         showSnackBar("Passwords should macth");
//       }
//     } else {
//       showSnackBar("Fill all fields");
//     }
//   }

//   String _validateMobile(String countrycode, phoneNumber) {
//     String nonzeropattern = r'(^[1-9]{1}[0-9]{8}$)';
//     String zeropattern = r'(^[0]{1}[1-9]{1}[0-9]{8}$)';
//     RegExp nonzeroregExp = RegExp(nonzeropattern);
//     RegExp zeroregExp = RegExp(zeropattern);
//     if (phoneNumber.length == 10 && zeroregExp.hasMatch(phoneNumber)) {
//       _validatedphoneNumber = countrycode + phoneNumber.substring(1);
//     } else if (phoneNumber.length == 9 && nonzeroregExp.hasMatch(phoneNumber)) {
//       _validatedphoneNumber = countrycode + phoneNumber;
//     } else {}

//     return _validatedphoneNumber;
//   }

//   goToSignUp() {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => const SignInPage(),
//       ),
//       ModalRoute.withName("/"),
//     );
//   }

//   Future<void> _register() async {
//     var url = Uri.parse("${AppConstants.baseUrl}user/register/");
//     print(url);
//     bool responseStatus = false;
//     String _authToken = "";
//     // Navigator.pushNamed(context, AppRouter.home);
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _responseLoading = true;
//       _validatedphoneNumber =
//           _validateMobile(number.isoCode!, phoneNumberController!.text);
//       // print("++++++ VALIDATED PHONE NUMBER ++++" + _validatedphoneNumber);
//     });
//     var bodyString = {
//       "password": password,
//       "first_name": firstName,
//       "last_name": lastName,
//       "other_name": otherName,
//       "address": address,
//       "phone_number": _validatedphoneNumber,
//       "email": email,
//       "passport_number": passportNumber,
//       "national_identification_number": nationalIdentificationNumber,
//       "date_of_birth":
//           DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(dateOfBirth!),
//       "country": selectedCountry!.displayName,
//       "is_clerk": true,
//       "is_admin": true,
//       "is_super_admin": true,
//       "is_a_admin": true,
//       "status": 1
//     };

//     // var bodyString = {
//     //   "password": "mm",
//     //   "first_name": "Mm",
//     //   "last_name": "Mm",
//     //   "other_name": "Mm",
//     //   "address": "Mm",
//     //   "phone_number": "07847941d6",
//     //   "email": "enoch.mbufga@gmail.com",
//     //   "passport_number": "mm",
//     //   "national_identification_number": "mm",
//     //   "date_of_birth":
//     //       DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(dateOfBirth!),
//     //   "country": "Uganda (UG) [+256]",
//     //   "is_clerk": true,
//     //   "is_admin": true,
//     //   "is_super_admin": true,
//     //   "is_a_admin": true,
//     //   "status": 1
//     // };

//     var body = jsonEncode(bodyString);
//     print(body);

//     var response = await http.post(url,
//         headers: {
//           "Content-Type": "Application/json",
//         },
//         body: body);
//     print("THE RESPONSE IS ++++++" + response.body.toString() + "+++++++");
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       setState(() {
//         _responseLoading = false;
//       });
//       final item = json.decode(response.body);
//       User userModel = User.fromJson(item);
//       print("++++THE USER IS +++" + item["lastName"].toString());

//       goToSignUp();
//     } else if (response.statusCode == 409) {
//       setState(() {
//         _responseLoading = false;
//       });
//       showSnackBar("User already exists with this email.");
//     } else {
//       setState(() {
//         _responseLoading = false;
//       });
//       showSnackBar("Registration Failure: Invalid data.");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // httpOverrides();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xffd6e2ea),
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           toolbarHeight: 50,
//           automaticallyImplyLeading: false,
//           flexibleSpace: SizedBox(
//             height: 50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Icons.arrow_back,
//                     ),
//                   ),
//                 ),
//                 const Image(
//                   height: 30,
//                   width: 70,
//                   image: AssetImage('assets/images/cassoa.png'),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 )
//               ],
//             ),
//           ),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width < 600
//                   ? double.infinity
//                   : 700,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ListView(
//                   children: [
//                     TextField(
//                       controller: passwordController,
//                       focusNode: passwordFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           password = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         hintText: "password",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.visiblePassword,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: password2Controller,
//                       focusNode: password2Focus,
//                       onChanged: (value) {
//                         setState(() {
//                           password2 = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Re-Type Password',
//                         hintText: "Re-Type password",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                             color: Color(0xFF432a72),
//                             width: 3.0,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.visiblePassword,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: firstNameController,
//                       focusNode: firstNameFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           firstName = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'First Name',
//                         hintText: 'YourFirstName',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.name,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: lastNameController,
//                       focusNode: lastNameFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           lastName = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Last Name',
//                         hintText: "YourLastName",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.name,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: otherNameController,
//                       focusNode: otherNameFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           otherName = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Other Name',
//                         hintText: "Other Name",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.name,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: addressController,
//                       focusNode: addressFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           address = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Address',
//                         hintText: 'Address',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.streetAddress,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: emailController,
//                       focusNode: emailFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           email = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         hintText: 'example@email.com',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: passportNumberController,
//                       focusNode: passportNumberFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           passportNumber = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Passport Number',
//                         hintText: "Passport Number",
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextField(
//                       controller: nationalIdentificationNumberController,
//                       focusNode: nationalIdentificationNumberFocus,
//                       onChanged: (value) {
//                         setState(() {
//                           nationalIdentificationNumber = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'National Identification Number',
//                         hintText: 'National Identification Number',
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                           borderSide: const BorderSide(
//                               color: Color(0xFF432a72), width: 3.0),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 4.0),
//                           borderRadius: BorderRadius.circular(15),
//                           gapPadding: 5,
//                         ),
//                       ),
//                       textInputAction: TextInputAction.done,
//                       keyboardType: TextInputType.text,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     InternationalPhoneNumberInput(
//                       selectorButtonOnErrorPadding: 5,
//                       spaceBetweenSelectorAndTextField: 5,
//                       onInputChanged: (PhoneNumber number) {
//                         setState(() {
//                           phoneNumber = number.phoneNumber;
//                           number = number;
//                         });
//                       },
//                       onInputValidated: (bool value) {
//                         // setState(() {
//                         //   phoneNumber = number.phoneNumber;
//                         //   number = number;
//                         // });
//                       },
//                       selectorConfig: const SelectorConfig(
//                         selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                       ),
//                       ignoreBlank: false,
//                       autoValidateMode: AutovalidateMode.onUserInteraction,
//                       selectorTextStyle: const TextStyle(color: Colors.black),
//                       initialValue: number,
//                       textFieldController: phoneNumberController,
//                       focusNode: phoneNumberFocus,
//                       formatInput: false,
//                       keyboardType: const TextInputType.numberWithOptions(
//                           signed: true, decimal: true),
//                       inputBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(width: 4.0),
//                         borderRadius: BorderRadius.circular(15),
//                         gapPadding: 5,
//                       ),
//                       onSaved: (PhoneNumber number) {
//                         setState(() {
//                           phoneNumber = number.phoneNumber;
//                           number = number;
//                         });
//                       },
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1900),
//                           lastDate: DateTime.now(),
//                         ).then((selectedDate) {
//                           if (selectedDate != null) {
//                             setState(() {
//                               dateOfBirth = selectedDate;
//                             });
//                           }
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: MouseRegion(
//                           cursor: MaterialStateMouseCursor.clickable,
//                           child: Text(
//                             dateOfBirth != null
//                                 // String formattedDateTime = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now);
//                                 ? 'Date of Birth: ${DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(dateOfBirth!)}'
//                                 : 'Select Date of Birth',
//                             style: const TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueGrey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         showCountryPicker(
//                           context: context,
//                           countryListTheme: CountryListThemeData(
//                             flagSize: 25,
//                             backgroundColor: Colors.white,
//                             textStyle:
//                                 TextStyle(fontSize: 16, color: Colors.blueGrey),
//                             bottomSheetHeight:
//                                 500, // Optional. Country list modal height
//                             //Optional. Sets the border radius for the bottomsheet.
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(20.0),
//                               topRight: Radius.circular(20.0),
//                             ),
//                             //Optional. Styles the search field.
//                             inputDecoration: InputDecoration(
//                               labelText: 'Search',
//                               hintText: 'Start typing to search',
//                               prefixIcon: const Icon(Icons.search),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color:
//                                       const Color(0xFF8C98A8).withOpacity(0.2),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           onSelect: (Country country) => setState(() {
//                             selectedCountry = country;
//                           }),
//                         );
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: Row(
//                           children: [
//                             selectedCountry != null
//                                 ? Text(selectedCountry!.flagEmoji)
//                                 : const SizedBox.shrink(),
//                             selectedCountry != null
//                                 ? const SizedBox(width: 8.0)
//                                 : const SizedBox.shrink(),
//                             MouseRegion(
//                               cursor: MaterialStateMouseCursor.clickable,
//                               child: Text(
//                                 selectedCountry != null
//                                     ? selectedCountry!.name
//                                     : 'Select Country',
//                                 style: const TextStyle(
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blueGrey,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             maximumSize: const Size(150.0, 70.0),
//                             elevation: 5,
//                           ),
//                           onPressed: () {
//                             // Perform registration logic here
//                             // Access the entered values using the respective variables
//                             // checkIfFilled();
//                             _register();
//                           },
//                           child: const Text('Register'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
