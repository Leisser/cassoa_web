import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../config/base.dart';
import '../../config/constants.dart';
import '../../models/user_login_model.dart';
import '../home/home_page.dart';
import '../reusable_widgets/tille.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends Base<SignInPage> {
  var passportNumberController = TextEditingController();
  var passwordController = TextEditingController();
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;
  StateMachineController? stateMachineController;
  bool _responseLoading = false;
  String? password = '';
  String? pasportNumber = '';

  _login(String username, String password) async {
    var url = Uri.parse("${AppConstants.baseUrl}user/login");
    bool responseStatus = false;
    String authToken = "";
    print("++++++LOGIN FUNCTION+++++++");
    // Navigator.pushNamed(context, AppRouter.home);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _responseLoading = true;
    });
    var bodyString = {"password": password, "passport_number": pasportNumber};

    var body = jsonEncode(bodyString);

    var response = await http.post(url,
        headers: {
          "Content-Type": "Application/json",
        },
        body: body);
    print("++++++${response.body}+++++++");
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      UserLogin user = UserLogin.fromJson(item);
      authToken = user.token!;
      prefs.setString("authToken", authToken);
      prefs.setString("username", "${user.firstName} ${user.lastName}");
      prefs.setString("firstName", user.firstName);
      prefs.setString("lastName", user.lastName);
      prefs.setString("email", user.email);
      prefs.setString("passportNumber", user.passportNumber);
      prefs.setString("phone", user.passportNumber);
      prefs.setString("password", password);
      prefs.setString(
          "nationalIdentificationNumber", user.nationalIdentificationNumber);
      prefs.setString("userid", user.userId.toString());
      // prefs.setString("dateJoined", user.datecreated.toIso8601String());
      prefs.setBool("isAdmin", user.isAdmin);
      prefs.setBool("isclerk", user.isClerk);
      prefs.setString("country", user.country);
      prefs.setBool("issuperadmin", user.isSuperAdmin);
      setState(() {
        _responseLoading = false;
      });
      goToHome();
    } else if (response.statusCode == 409) {
      setState(() {
        _responseLoading = false;
      });
      showSnackBar("User account not activated.");
    } else {
      setState(() {
        _responseLoading = false;
      });
      showSnackBar("Authentication Failure: Invalid credentials.");
    }
  }

  checkfilled() {
    if (pasportNumber!.isNotEmpty && password!.isNotEmpty) {
      _login(pasportNumber!, password!);
    } else {
      print(pasportNumber);
      print(password);
      showSnackBar("Fill both password and passport number");
    }
  }

  @override
  void initState() {
    super.initState();
    print('Hey');
    // httpOverrides();
    animationURL = 'assets/rive/login.riv';
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }

          for (var element in stateMachineController!.inputs) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          }
        }

        setState(() => _teddyArtboard = artboard);
      },
    );
    // recordFistVisit();
  }

  // recordFistVisit() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.clear();
  // }

  // Future<StateMachineController?> getArtboard(ByteData data) async {
  //   final file = RiveFile.import(data);
  //   print(file.header.fileId);
  //   print(data.lengthInBytes);

  //   setState(() {
  //     art = file.mainArtboard;
  //   });
  //   print(art!.height);
  //   print(art!.name);
  //   var controllers = StateMachineController.fromArtboard(art!, 'idle');

  //   return controllers;
  // }

  // initArtboard() {
  //   return rootBundle.load('assets/rive/login_screen.riv').then(
  //     (data) async {
  //       StateMachineController? stateMachineControllers =
  //           await getArtboard(data);
  //       setState(() {
  //         stateMachineController = stateMachineControllers;
  //       });
  //       if (stateMachineController != null) {
  //         art!.addController(stateMachineController!);
  //         for (var element in stateMachineController!.inputs) {
  //           if (element.name == "isChecking") {
  //             isChecking = element as SMIBool;
  //           } else if (element.name == "isHandsUp") {
  //             isHandsUp = element as SMIBool;
  //           } else if (element.name == "trigSuccess") {
  //             successTriger = element as SMITrigger;
  //           } else if (element.name == "trigFail") {
  //             failTrigger = element as SMITrigger;
  //           } else if (element.name == "numLook") {
  //             lookNum = element as SMINumber;
  //           }
  //         }
  //       } else {
  //         print('null null');
  //       }
  //       // art.addController(stateMachineController!);
  //       setState(() {
  //         artboard = art;
  //       });
  //     },
  //   );
  // }

  // checking() {
  //   isHandsUp.change(false);
  //   isChecking.change(true);
  //   lookNum.change(0);
  // }

  // moveEyes(value) {
  //   lookNum.change(value.length.toDouble());
  // }

  // handsUp() {
  //   isHandsUp.change(true);
  //   isChecking.change(false);
  // }

  // login() {
  //   isHandsUp.change(false);
  //   isChecking.change(false);
  //   if (passportNumberController.text == "admin" &&
  //       passwordController.text == 'aye') {
  //     successTriger.fire();
  //   } else {
  //     failTrigger.fire();
  //   }
  // }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  goToHome() {
    context.go('/home');
  }

  void lookOnTheTextField() {
    print('object');
    print('object');
    print('object');
    print('object');
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  // void login() {
  //   isChecking?.change(false);
  //   isHandsUp?.change(false);
  //   if (passportNumberController.text == "admin" &&
  //       passwordController.text == "admin") {
  //     successTrigger?.fire();
  //   } else {
  //     failTrigger?.fire();
  //   }
  // }

  // void toSignUpPage() {
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) => const SignUpPage(),
  //   //   ),
  //   // );
  //   context.go('/signup');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Title1(
                color: Color(0xFF432a72),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_teddyArtboard != null)
                      SizedBox(
                        width: 400,
                        height: MediaQuery.of(context).size.height * .3,
                        child: Rive(
                          artboard: _teddyArtboard!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xFF432a72),
                          borderRadius: BorderRadius.circular(5)),
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width < 600
                          ? double.infinity
                          : 700,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              onSubmitted: (value) {
                                handsOnTheEyes();
                              },
                              decoration: InputDecoration(
                                hintText: 'Passport Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 2,
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Color(0xFF432a72),
                                  ),
                                ),
                              ),
                              onTap: lookOnTheTextField,
                              obscureText: false,
                              controller: passportNumberController,
                              onChanged: (value) {
                                setState(() {
                                  moveEyeBalls(value);
                                  pasportNumber = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: TextField(
                              textInputAction: TextInputAction.send,
                              onSubmitted: (value) {
                                checkfilled();
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  gapPadding: 2,
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Color(0xFF432a72),
                                  ),
                                ),
                              ),
                              onTap: handsOnTheEyes,
                              obscureText: true,
                              controller: passwordController,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              // MouseRegion(
                              //   cursor: MaterialStateMouseCursor.clickable,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       toSignUpPage();
                              //     },
                              //     child: const Text(
                              //       'Create new account',
                              //       style: TextStyle(
                              //         color: Colors.green,
                              //         fontStyle: FontStyle.italic,
                              //         fontWeight: FontWeight.w700,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              ElevatedButton(
                                onPressed: () {
                                  checkfilled();
                                },
                                style: ButtonStyle(
                                  mouseCursor:
                                      MaterialStateMouseCursor.clickable,
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(100, 35)),
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // FlatButton(
                    //   onPressed: () {
                    //     // Navigate to sign-up page
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => SignUpPage()),
                    //     );
                    //   },
                    //   child: Text('Sign Up'),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
