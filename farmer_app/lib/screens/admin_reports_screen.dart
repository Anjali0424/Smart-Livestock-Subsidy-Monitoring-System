import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AdminReportsScreen extends StatefulWidget {
  @override
  _AdminReportsScreenState createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {

  int total = 0;
  int approved = 0;
  int pending = 0;
  int rejected = 0;

  @override
  void initState() {
    super.initState();
    loadReport();
  }

  Future<void> loadReport() async {
    final data = await ApiService.getAllSubsidies();

    int a = 0, p = 0, r = 0;

    for (var s in data) {
      if (s['status'] == "Approved") a++;
      else if (s['status'] == "Pending") p++;
      else if (s['status'] == "Rejected") r++;
    }

    setState(() {
      total = data.length;
      approved = a;
      pending = p;
      rejected = r;
    });
  }

Widget card(String title, int value, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 4,
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        // 🔥 ICON
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 28),
        ),

        SizedBox(height: 10),

        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "$value",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text("Reports"),
  backgroundColor: Colors.blueGrey,
  elevation: 1,
),

     body: Container(
  color: Colors.grey.shade100,
  child:Padding(
  padding: EdgeInsets.all(10),
  child: GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 1,
    children: [
      card("Total", total, Icons.bar_chart, Colors.blueGrey),
      card("Approved", approved, Icons.check_circle, Colors.green),
      card("Pending", pending, Icons.pending_actions, Colors.orange),
      card("Rejected", rejected, Icons.cancel, Colors.red),
    ],
  ),
)
     )
      );
  }
}