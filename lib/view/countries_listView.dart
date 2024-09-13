import 'package:covidapp/view/detailsScreen.dart';
import 'package:covidapp/viewModel/countriesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListView extends StatefulWidget {
  const CountriesListView({super.key});

  @override
  State<CountriesListView> createState() => _CountriesListViewState();
}

class _CountriesListViewState extends State<CountriesListView>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    Provider.of<CountryProvider>(context, listen: false).countryVm();
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
        title: const Text("Search Place"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: searchController,
              onChanged: (val) {
                setState(() {}); // Trigger rebuild on text change
              },
              decoration: InputDecoration(
                hintText: "Search with country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<CountryProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                          ),
                          title: Container(
                            color: Colors.grey[300],
                            height: 16,
                            width: double.infinity,
                          ),
                          subtitle: Container(
                            color: Colors.grey[300],
                            height: 14,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // Filter countries based on the search text
                  final filteredCountries =
                      value.countryModelVM.data!.where((country) {
                    final countryName = country.country!.toLowerCase();
                    final searchQuery = searchController.text.toLowerCase();
                    return countryName.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final data = filteredCountries[index];
                      return InkWell(
                        onTap: () {
                          Get.to(DetailsScreen(
                              name: filteredCountries[index].country.toString(),
                              image: filteredCountries[index]
                                  .countryInfo!
                                  .flag
                                  .toString(),
                              totalCases: filteredCountries[index].cases ?? 0,
                              totalRecovery:
                                  filteredCountries[index].recovered ?? 0,
                              totalDeaths: filteredCountries[index].deaths ?? 0,
                              active: filteredCountries[index].active ?? 0,
                              todayRecovered:
                                  filteredCountries[index].todayRecovered ?? 0,
                              test: filteredCountries[index].tests ?? 0));
                        },
                        child: ListTile(
                          leading: Image(
                            height: 50,
                            width: 50,
                            image:
                                NetworkImage(data.countryInfo!.flag.toString()),
                          ),
                          title: Text(data.country.toString()),
                          subtitle: Text(data.cases.toString()),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
