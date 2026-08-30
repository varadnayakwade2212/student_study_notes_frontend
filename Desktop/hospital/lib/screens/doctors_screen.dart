import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../services/api_service.dart';
import '../widgets/doctor_card.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() =>
      _DoctorsScreenState();
}

class _DoctorsScreenState
    extends State<DoctorsScreen> {
  late Future<List<Doctor>> doctorsFuture;

  String searchText = '';

  @override
  void initState() {
    super.initState();
    doctorsFuture = ApiService.getDoctors();
  }

  void loadDoctors() {
    setState(() {
      doctorsFuture = ApiService.getDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: FutureBuilder<List<Doctor>>(
        future: doctorsFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 55,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Unable to load doctors',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: loadDoctors,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final doctors = snapshot.data ?? [];

          final filteredDoctors = doctors.where(
                (doctor) {
              final search =
              searchText.toLowerCase();

              return doctor.name
                  .toLowerCase()
                  .contains(search) ||
                  doctor.specialization
                      .toLowerCase()
                      .contains(search);
            },
          ).toList();

          return RefreshIndicator(
            onRefresh: () async {
              loadDoctors();
              await doctorsFuture;
            },

            child: ListView(
              padding: const EdgeInsets.all(16),

              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },

                  decoration: InputDecoration(
                    hintText: 'Search doctors...',
                    prefixIcon:
                    const Icon(Icons.search),
                    suffixIcon:
                    const Icon(Icons.filter_list),
                    filled: true,
                    fillColor:
                    Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (filteredDoctors.isEmpty)
                  const Padding(
                    padding:
                    EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(
                        'No doctors found',
                        style:
                        TextStyle(fontSize: 17),
                      ),
                    ),
                  ),

                ...filteredDoctors.map(
                      (doctor) => DoctorCard(
                    doctor: doctor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}