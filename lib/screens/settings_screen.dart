import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await authService.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Change Password'),
              onTap: () {
                // Implement password change functionality
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Information'),
              onTap: () {
                // Navigate to personal information screen
              },
            ),
          ],
        ),
      ),
    );
  }
}