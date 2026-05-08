import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/animals_screen.dart';
import 'screens/subsidy_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/admin_login_screen.dart';
import 'screens/subsidy_history.dart';
import 'screens/admin_dashboard.dart';
import 'screens/admin_subsidy_screen.dart';
import 'screens/admin_farmers_screen.dart';
import 'screens/admin_animals_screen.dart';
import 'screens/admin_reports_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/animals': (context) => AnimalsScreen(),
        '/subsidy': (context) => SubsidyScreen(),
        '/admin-login': (context) => AdminLoginScreen(),
       // '/admin': (context) => AdminScreen(),
        '/subsidy-history': (context) => SubsidyHistory(),
         '/admin-dashboard': (context) => AdminDashboard(), 
         '/admin-subsidy': (context) => AdminSubsidyScreen(),
         '/admin-farmers': (context) => AdminFarmersScreen(),
         '/admin-animals': (context) => AdminAnimalsScreen(),
         '/admin-reports': (context) => AdminReportsScreen(),
      },
    );
  }
}