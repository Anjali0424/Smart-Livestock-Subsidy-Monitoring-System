import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  int farmers = 0;
  int animals = 0;
  int subsidy = 0;
  int approved = 0;
  int pending = 0;
  int rejected = 0;

  @override
  void initState() {
    super.initState();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    final response = await http.get(
      // Uri.parse("http://10.91.53.237:5000/api/dashboard/stats"),
      Uri.parse("${ApiService.baseUrl}/api/dashboard/stats")
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("PARSED: $data");

      setState(() {
        farmers = data['totalFarmers'];
        animals = data['totalAnimals'];
        subsidy = data['totalSubsidy'];
        approved = data['approved'];
        pending = data['pending'];
         rejected = data['rejected'];
      });
    } else {
      print("Failed to load data");
    }
  }

  Widget buildCard(String title, int value) {
  return Container(
    margin: EdgeInsets.all(6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white, // ✅ clean white
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Icon(Icons.analytics, color: Colors.blueGrey), // subtle icon

        SizedBox(height: 8),

        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),

        SizedBox(height: 8),

        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

 Widget buildDashboardButton({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white, // ✅ light background
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Row(
            children: [

              // 🔹 ICON BOX
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50, // light color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.blueGrey),
              ),

              SizedBox(width: 15),

              // 🔹 TITLE
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              // 🔹 ARROW
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),

            ],
          ),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: Text("Admin Dashboard"),
  backgroundColor: Colors.blueGrey,
  elevation: 1,
),

body: Container(
  color: Colors.grey.shade100, // light background
  child: Padding(
  padding: EdgeInsets.all(10),
  child: SingleChildScrollView(   // ✅ FIX 1
    child: Column(
      children: [

        // 🔥 DASHBOARD CARDS
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true, // ✅ FIX 2
          physics: NeverScrollableScrollPhysics(), // ✅ FIX 3
          children: [
           buildCard("Farmers", farmers),
buildCard("Animals", animals),
buildCard("Subsidy", subsidy),
buildCard("Approved", approved),
buildCard("Pending", pending),
buildCard("Rejected", rejected),
          ],
        ),

        SizedBox(height: 20),

        // 🔥 BUTTONS
        Column(
          children: [

            buildDashboardButton(
              title: "Manage Subsidy",
              icon: Icons.attach_money,
             
              onTap: () async {
                await Navigator.pushNamed(context, '/admin-subsidy');
                fetchDashboard();
              },
            ),

            buildDashboardButton(
              title: "Manage Farmers",
              icon: Icons.people,
             
              onTap: () {
                Navigator.pushNamed(context, '/admin-farmers');
              },
            ),

            buildDashboardButton(
              title: "Monitor Animals",
              icon: Icons.pets,
              
              onTap: () {
                Navigator.pushNamed(context, '/admin-animals');
              },
            ),

            buildDashboardButton(
              title: "Reports",
              icon: Icons.bar_chart,
             
              onTap: () {
                Navigator.pushNamed(context, '/admin-reports');
              },
            ),

          ],
        ),

      ],
    ),
  ),
),
     )
      );
  }

//   @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   fetchDashboard(); // 🔥 refresh when screen opens again
// }
}