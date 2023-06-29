import 'package:flutter/material.dart';

class AppConstants {
  // static String googleApiKey = "AIzaSyBiazur8ggWqC3105W8ciuc-jwYbU9sJUM";
  // static String legalUrl = "https://aston-network.org/legal-notice/";
  static String englishFont = "Poppins";
  // static String oldbaseUrl = "https://api.onekomplex.com/api/";
  static String baseUrl = "https://157.245.81.104:8000/";
  // static String baseUrl = "http://142.93.138.50/";
  // static String baseUrl = "http://10.0.2.2:8000/";
  // static String baseUrl ="https://dmmp.kcca.go.ug/";
  // static String sendSMSMUrl = "http://apidocs.speedamobile.com/SendSMS";
  // static String getOtpUrl = "http://apidocs.speedamobile.com/api/Verify";
  // static String verifyOtpUrl =
  //     "http://apidocs.speedamobile.com/api/VerifyStatus";
  static Color primaryColor = const Color.fromRGBO(34, 112, 59, 1);
}

ValueNotifier<int> backtohome = ValueNotifier<int>(6);
ValueNotifier<bool> tripStatus = ValueNotifier<bool>(false);
ValueNotifier<String> tripString = ValueNotifier<String>("");
ValueNotifier<String> ticketString = ValueNotifier<String>("all");
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
const defaultPadding = 16.0;
const primaryColor = Color.fromRGBO(34, 112, 59, 1);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

// const creamColor = Color(0xFFFFFFFF);
const creamColor = Color.fromRGBO(228, 250, 239, 1);
const snowColor = Color(0xFFFFFAFA);
const kccaYellow = Color.fromRGBO(248, 221, 7, 1);
