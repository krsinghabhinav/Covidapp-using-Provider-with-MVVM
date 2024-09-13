import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String image, name;
  final int totalCases,
      totalDeaths,
      totalRecovery,
      active,
      todayRecovered,
      test;

  DetailsScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovery,
    required this.active,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Specify a duration
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'Total Cases',
                              value: widget.totalCases.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'totalRecovery Cases',
                              value: widget.totalRecovery.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'totalDeaths Cases',
                              value: widget.totalDeaths.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'active Cases',
                              value: widget.active.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'todayRecovered Cases',
                              value: widget.todayRecovered.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'test Cases',
                              value: widget.test.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'Total Cases',
                              value: widget.totalCases.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ReusableRows(
                              title: 'Total Cases',
                              value: widget.totalCases.toString(),
                            ),
                          ),
                          // Add more ReusableRows or widgets here if needed
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50, // Adjust the size as needed
                    backgroundImage: NetworkImage(widget.image),
                    // Optionally, you can provide an error handling widget
                    onBackgroundImageError: (error, stackTrace) {
                      // Handle image load errors here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy definition for ReusableRows, make sure to replace it with your actual implementation
class ReusableRows extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRows({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
