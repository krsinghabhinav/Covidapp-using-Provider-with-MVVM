import 'package:covidapp/view/countries_listView.dart';
import 'package:covidapp/viewModel/worldStateVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  final List<Color> colorList = [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<WorldStateProvider>(context, listen: false).getworldVM();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: colorList[0],
      end: colorList[1],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Consumer<WorldStateProvider>(
              builder: (context, value, child) {
                if (value.WorldListVM == null ||
                    value.WorldListVM.data == null) {
                  // Show a CircularProgressIndicator while loading
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .01),
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  value.WorldListVM.data!.cases.toString()),
                              "Recovered": double.parse(
                                  value.WorldListVM.data!.recovered.toString()),
                              "Death": double.parse(
                                  value.WorldListVM.data!.deaths.toString()),
                            },
                            chartRadius:
                                MediaQuery.of(context).size.width / 2.3,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartValuesOptions: const ChartValuesOptions(
                                // showChartValuesInPercentage: true,
                                ),
                            ringStrokeWidth: 32,
                            chartType: ChartType.ring,
                            colorList: colorList, // Apply your colorList
                          ),
                          const SizedBox(height: 20),
                          Card(
                            color: const Color.fromARGB(255, 58, 58, 58),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02),
                                ReusableRows(
                                    title: "Total Cases",
                                    value: value.WorldListVM.data!.cases
                                        .toString()),
                                ReusableRows(
                                    title: "Total Deaths",
                                    value: value.WorldListVM.data!.deaths
                                        .toString()),
                                ReusableRows(
                                    title: "Total Recovery",
                                    value: value.WorldListVM.data!.recovered
                                        .toString()),
                                ReusableRows(
                                    title: "Total Active Cases",
                                    value: value.WorldListVM.data!.active
                                        .toString()),
                                ReusableRows(
                                    title: "Critical Cases",
                                    value: value.WorldListVM.data!.critical
                                        .toString()),
                                ReusableRows(
                                    title: "Today Deaths Cases",
                                    value: value.WorldListVM.data!.todayDeaths
                                        .toString()),
                                ReusableRows(
                                    title: "Today Recovery",
                                    value: value
                                        .WorldListVM.data!.todayRecovered
                                        .toString()),
                                ReusableRows(
                                    title: "Today Cases",
                                    value: value.WorldListVM.data!.todayCases
                                        .toString()),
                                ReusableRows(
                                    title: "Total Tests Cases",
                                    value: value.WorldListVM.data!.tests
                                        .toString()),
                                ReusableRows(
                                    title: "Total Population",
                                    value: value.WorldListVM.data!.population
                                        .toString()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 0),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CountriesListView());
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:
                                  const Center(child: Text("Track Countries")),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRows extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRows({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
