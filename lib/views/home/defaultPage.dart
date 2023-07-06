import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:country_picker/country_picker.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  Country? selectedCountry;
  List diseaseList = [];
  String? disease;
  TextEditingController? diseaseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: -20 + MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                flagSize: 25,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.blueGrey),
                                bottomSheetHeight:
                                    500, // Optional. Country list modal height
                                //Optional. Sets the border radius for the bottomsheet.
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                //Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                              onSelect: (Country country) => setState(() {
                                selectedCountry = country;
                              }),
                            );
                          },
                          child: MouseRegion(
                            cursor: MaterialStateMouseCursor.clickable,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 55,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  selectedCountry != null
                                      ? Text(selectedCountry!.flagEmoji)
                                      : const SizedBox.shrink(),
                                  selectedCountry != null
                                      ? const SizedBox(width: 8.0)
                                      : const SizedBox.shrink(),
                                  Text(
                                    selectedCountry != null
                                        ? selectedCountry!.name
                                        : 'Select Country',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 45,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: diseaseController,
                          onChanged: (value) {
                            setState(() {
                              disease = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Passport Number',
                            hintText: "Passport Number",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              gapPadding: 5,
                              borderSide: const BorderSide(
                                  color: Color(0xFF432a72), width: 3.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 4.0),
                              borderRadius: BorderRadius.circular(15),
                              gapPadding: 5,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(150.0, 70.0),
                                elevation: 5,
                              ),
                              onPressed: () {
                                // Perform registration logic here
                                // Access the entered values using the respective variables
                                // checkIfFilled();
                                // _register();
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: -20 + MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2.8,
                    color: Colors.blue,
                    child: PieChartPage(),
                  ),
                ],
              ),
            ),
            // const CountryPicker(),

            const DiseaseTextField(),
            Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              child: const BarGraph(),
            ),
          ],
        ),
      ),
    );
  }
}

class BarGraph extends StatelessWidget {
  const BarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      MonthData('Jan', 5),
      MonthData('Feb', 10),
      MonthData('Mar', 7),
      MonthData('Apr', 3),
      MonthData('May', 8),
      MonthData('Jun', 12),
      MonthData('Jul', 6),
      MonthData('Aug', 9),
      MonthData('Sep', 11),
      MonthData('Oct', 4),
      MonthData('Nov', 8),
      MonthData('Dec', 6),
    ];

    final series = [
      charts.Series(
        domainFn: (MonthData data, _) => data.month,
        measureFn: (MonthData data, _) => data.value,
        id: 'Graph Data',
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 16,
            fontWeight: 'bold',
            color: charts.MaterialPalette.white,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 16,
            color: charts.MaterialPalette.white,
            fontWeight: 'bold',
          ),
          labelAnchor: charts.TickLabelAnchor.before,
        ),
      ),
    );
  }
}

class MonthData {
  final String month;
  final int value;

  MonthData(this.month, this.value);
}

class DiseaseTextField extends StatelessWidget {
  const DiseaseTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(enabled: false),
    );
  }
}

class PieChartPage extends StatelessWidget {
  const PieChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ChartData('Category 1', 30),
      ChartData('Category 2', 20),
      ChartData('Category 3', 15),
      ChartData('Category 4', 35),
    ];

    final series = [
      charts.Series(
        domainFn: (ChartData data, _) => data.category,
        measureFn: (ChartData data, _) => data.value,
        id: 'Chart Data',
        data: data,
        labelAccessorFn: (ChartData data, _) =>
            '${data.category}: ${data.value}%',
      ),
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: charts.PieChart(
          series,
          animate: true,
          defaultRenderer: charts.ArcRendererConfig(
            arcRendererDecorators: [charts.ArcLabelDecorator()],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
