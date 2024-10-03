import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostelpedia/View/Screen/hosteldetails_screen.dart';
import '../../database/favoritesStore.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoriteHostels = [];
  final HostelDatabase hostelRefDB = HostelDatabase();

  void getFavoriteData() async {
    favoriteHostels = await hostelRefDB.getAllData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFavoriteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Hostels"),
      ),
      body: favoriteHostels.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: favoriteHostels.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    height: 160, // Adjust height based on need
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            favoriteHostels[index]
                                [HostelDatabase.COLUMN_HOSTEL_IMAGE],
                            height: 140,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                favoriteHostels[index][HostelDatabase
                                        .COLUMN_HOSTEL_HOSTELNAME] ??
                                    "Hostel Name",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 20),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${favoriteHostels[index][HostelDatabase.COLUMN_HOSTEL_RATING] ?? '---'} | Rating',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 20, color: Colors.red),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      favoriteHostels[index][HostelDatabase
                                              .COLUMN_HOSTEL_ADDRESS] ??
                                          'Location',
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.currency_rupee, size: 18),
                                  const SizedBox(width: 5),
                                  Text(
                                    favoriteHostels[index][HostelDatabase
                                            .COLUMN_HOSTEL_PRICE] ??
                                        'Price',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
