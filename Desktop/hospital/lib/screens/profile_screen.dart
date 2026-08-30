import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.indigo,
            child: Icon(
              Icons.person,
              size: 65,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              'Vaishnavi Nikam',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 5),

          const Center(
            child: Text(
              'vaishnavi@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 30),

          _profileItem(
            Icons.person_outline,
            'Personal Information',
          ),

          _profileItem(
            Icons.calendar_month_outlined,
            'My Appointments',
          ),

          _profileItem(
            Icons.medication_outlined,
            'My Prescriptions',
          ),

          _profileItem(
            Icons.settings_outlined,
            'Settings',
          ),

          _profileItem(
            Icons.help_outline,
            'Help & Support',
          ),

          _profileItem(
            Icons.logout,
            'Logout',
          ),
        ],
      ),
    );
  }

  Widget _profileItem(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: Colors.indigo,
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: () {},
    );
  }
}