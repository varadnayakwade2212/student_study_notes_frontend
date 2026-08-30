import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _appointmentCard(
            doctor: 'Dr. Rahul Sharma',
            specialization: 'General Physician',
            date: '26 Aug 2026',
            time: '11:00 AM',
            status: 'Confirmed',
          ),

          _appointmentCard(
            doctor: 'Dr. Priya Patel',
            specialization: 'Cardiologist',
            date: '30 Aug 2026',
            time: '04:00 PM',
            status: 'Confirmed',
          ),

          _appointmentCard(
            doctor: 'Dr. Amit Verma',
            specialization: 'Neurologist',
            date: '05 Sep 2026',
            time: '10:30 AM',
            status: 'Pending',
          ),
        ],
      ),
    );
  }

  Widget _appointmentCard({
    required String doctor,
    required String specialization,
    required String date,
    required String time,
    required String status,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.indigo,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(specialization),
                    ],
                  ),
                ),

                Text(
                  status,
                  style: TextStyle(
                    color: status == 'Confirmed'
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 20,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 8),
                Text(date),

                const Spacer(),

                const Icon(
                  Icons.access_time,
                  size: 20,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}