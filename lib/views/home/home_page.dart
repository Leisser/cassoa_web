import 'package:cassoa_web/views/home/country.dart';
import 'package:cassoa_web/views/home/defaultPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

import '../../resources/flutter_svg_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId, token, countryCode;
  String country = '', codeSet = '', _headline = '', username = '';
  bool? isFirstTime, isLoading;
  int homeIndex = 0;
  int indexcheck = 0;
  ImageProvider<Object>? iconImages;
  final _colapisble = GlobalKey();

  checkIfSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userid') ?? '';
      token = prefs.getString('authToken') ?? '';
      isFirstTime = prefs.getBool('isFirstTime') ?? true;
      country = prefs.getString('country') ?? '';
      username = prefs.getString('username') ?? "";
      List allWords = [];
      allWords.addAll(country.split(" "));
      countryCode = country
          .split(" ")
          .elementAt(allWords.length - 2)
          .replaceAll('(', '')
          .replaceAll(')', '');
      codeSet = countryCode != null ? "1" : '';
    });
  }

  // String getCountryNameFromPhoneCode(String phoneCode) {
  //   return country?.name ?? 'Unknown';
  // }
  // Output: Uganda

  @override
  void initState() {
    super.initState();
    checkIfSignedIn();
  }

  List pages = const [
    DefaultPage(),
    RegisterCountry(),
  ];

  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
          text: 'Dashboard',
          iconImage: const AssetImage(
              "assets/images/earth.jpeg"), //`iconImage` has priority over `icon` property
          icon: Icons.ac_unit,
          onPressed: () => setState(() => _headline = 'Home'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Shop"))),
          isSelected: true,
          subItems: [
            CollapsibleItem(
              text: 'Home',
              icon: Icons.maps_home_work,
              onPressed: () => setState(() {
                _headline = 'Home';
                homeIndex = 0;
              }),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Cart"))),
              isSelected: true,
            )
          ]),
      CollapsibleItem(
        text: 'Add Disease',
        icon: Icons.assessment,
        onPressed: () => setState(() {
          _headline = 'Add Disease';
          homeIndex = 1;
        }),
        onHold: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("DashBoard"),
          ),
        ),
      ),
      CollapsibleItem(
        text: 'Ice-Cream',
        icon: Icons.icecream,
        onPressed: () => setState(() => _headline = 'Ice-Cream'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Ice-Cream"))),
      ),
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'Search'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Search"))),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CollapsibleSidebar(
          collapseOnBodyTap: false,
          isCollapsed: MediaQuery.of(context).size.width <= 800,
          showToggleButton: false,
          items: _items,
          avatarImg: codeSet == '1'
              ? Svg(
                  'assets/images/svg/${(countryCode)!.toLowerCase().toString()}.svg')
              : Container(),
          title: username.toString(),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff2B3138),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      spreadRadius: 0.01,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(5, 4, 5, 4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width <= 800
                    ? MediaQuery.of(context).size.width - 80
                    : MediaQuery.of(context).size.width - 285,
                child: pages[homeIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
