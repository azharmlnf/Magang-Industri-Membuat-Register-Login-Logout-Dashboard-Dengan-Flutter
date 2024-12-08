import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_drawer.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String token;

  DashboardScreen({required this.token});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  void _fetchProfile() async {
    final response = await apiService.getProfile(widget.token);
    if (response != null) {
      setState(() {
        user = response['data']['user'];
      });
    }
  }

  void _logout() async {
    final response = await apiService.logout(widget.token);

    // Cek apakah layar masih aktif sebelum menggunakan BuildContext
    if (!mounted) return;

    if (response != null && response['status'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      drawer: CustomDrawer(
        onLogout: _logout,
        user: user, // Kirim data user ke drawer
      ),
      body: Center(
        child: Text(
          'Selamat Datang!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
