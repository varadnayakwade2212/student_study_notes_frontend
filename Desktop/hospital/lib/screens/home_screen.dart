import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../services/api_service.dart';
import '../widgets/doctor_card.dart';
import 'doctors_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  late Future<List<Doctor>> doctorsFuture;

  @override
  void initState() {
    super.initState();

    doctorsFuture =
        ApiService.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        title: const Text(
          'Hospital Appointment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding:
            EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications_none,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            const Text(
              'Hello, Vaishnavi 👋',

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Take care of your health and book your appointment.',

              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText:
                'Search doctors, specialties...',
                prefixIcon:
                const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),

                filled: true,
                fillColor:
                Colors.grey.shade100,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient:
                const LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.deepPurple,
                  ],
                ),

                borderRadius:
                BorderRadius.circular(18),
              ),

              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    'Your Health',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  Text(
                    'is Our Priority ❤️',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Book your doctor appointment easily.',

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Categories',

                  style: TextStyle(
                    fontSize: 19,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DoctorsScreen(),
                      ),
                    );
                  },

                  child:
                  const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,

              children: [
                _category(
                  Icons.medical_services,
                  'General',
                ),

                _category(
                  Icons.favorite,
                  'Cardiology',
                ),

                _category(
                  Icons.psychology,
                  'Neurology',
                ),

                _category(
                  Icons.child_care,
                  'Pediatrics',
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Top Doctors',

                  style: TextStyle(
                    fontSize: 19,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DoctorsScreen(),
                      ),
                    );
                  },

                  child:
                  const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            FutureBuilder<List<Doctor>>(
              future: doctorsFuture,

              builder:
                  (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'Unable to load doctors.',
                  );
                }

                final doctors =
                    snapshot.data ?? [];

                if (doctors.isEmpty) {
                  return const Text(
                    'No doctors available.',
                  );
                }

                final topDoctors =
                doctors.take(3).toList();

                return Column(
                  children:
                  topDoctors.map(
                        (doctor) {
                      return DoctorCard(
                        doctor: doctor,
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _category(
      IconData icon,
      String title,
      ) {
    return Column(
      children: [
        Container(
          padding:
          const EdgeInsets.all(15),

          decoration: BoxDecoration(
            color:
            Colors.indigo.shade50,

            borderRadius:
            BorderRadius.circular(15),
          ),

          child: Icon(
            icon,
            color: Colors.indigo,
            size: 28,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,

          style: const TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}