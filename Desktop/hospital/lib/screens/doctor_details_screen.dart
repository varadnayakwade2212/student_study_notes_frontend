import 'package:flutter/material.dart';

import '../models/doctor.dart';
import 'book_appointment_screen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.indigo.shade100,
              child: const Icon(
                Icons.person,
                size: 65,
                color: Colors.indigo,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              doctor.name,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              doctor.specialization,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text(' ${doctor.rating}'),
                const SizedBox(width: 15),
                Text('${doctor.experience} Years Experience'),
              ],
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About Doctor',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '${doctor.name} is an experienced ${doctor.specialization} '
                  'with ${doctor.experience} years of professional experience. '
                  'The doctor provides quality healthcare and consultation.',
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Consultation Fee',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '₹${doctor.fee.toInt()}',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookAppointmentScreen(
                        doctor: doctor,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}