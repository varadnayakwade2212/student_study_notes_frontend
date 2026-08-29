import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;

  const ProfileScreen({
    super.key,
    this.onThemeChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = '';
  String password = '';

  bool darkMode = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  // Load Profile Data
  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      email = prefs.getString('userEmail') ?? '';
      password = prefs.getString('userPassword') ?? '';
      darkMode = prefs.getBool('isDarkMode') ?? true;
    });
  }

  // Edit Profile
  Future<void> editProfile() async {
    final emailController =
    TextEditingController(text: email);

    final passwordController =
    TextEditingController(text: password);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email
              TextField(
                controller: emailController,
                keyboardType:
                TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon:
                  Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon:
                  Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

          actions: [
            // Cancel
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
              ),
            ),

            // Save
            ElevatedButton(
              onPressed: () async {
                if (emailController.text
                    .trim()
                    .isEmpty ||
                    passwordController.text
                        .trim()
                        .isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please fill all fields',
                      ),
                    ),
                  );
                  return;
                }

                final prefs =
                await SharedPreferences
                    .getInstance();

                await prefs.setString(
                  'userEmail',
                  emailController.text.trim(),
                );

                await prefs.setString(
                  'userPassword',
                  passwordController.text.trim(),
                );

                if (!mounted) return;

                setState(() {
                  email =
                      emailController.text.trim();

                  password =
                      passwordController.text.trim();
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile updated successfully',
                    ),
                  ),
                );
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );

    emailController.dispose();
    passwordController.dispose();
  }

  // Change Dark / Light Mode
  Future<void> changeTheme(bool value) async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      'isDarkMode',
      value,
    );

    setState(() {
      darkMode = value;
    });

    // Send theme change to main.dart
    widget.onThemeChanged?.call(value);
  }

  // Logout
  Future<void> logout() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      'isLoggedIn',
      false,
    );

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const LoginScreen(),
      ),
          (route) => false,
    );
  }

  // Logout Confirmation
  void showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Logout',
          ),

          content: const Text(
            'Are you sure you want to logout?',
          ),

          actions: [
            // Cancel
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
              ),
            ),

            // Logout
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                logout();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            const CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),

            const SizedBox(height: 25),

            // Email Card
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),

                title: const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  email.isEmpty
                      ? 'No email'
                      : email,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Dark / Light Mode
            Card(
              child: ListTile(
                leading: Icon(
                  darkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Colors.orange,
                ),

                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  darkMode
                      ? 'Dark mode is ON'
                      : 'Light mode is ON',
                ),

                trailing: Switch(
                  value: darkMode,

                  onChanged: changeTheme,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Edit Profile
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),

                title: const Text(
                  'Edit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Edit email and password',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),

                onTap: editProfile,
              ),
            ),

            const SizedBox(height: 15),

            // Logout
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),

                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Logout from your account',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red,
                  size: 18,
                ),

                onTap:
                showLogoutConfirmation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}