import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List subsidies = [];

  @override
  void initState() {
    super.initState();
    loadSubsidies();
  }

  void loadSubsidies() async {
  final data = await ApiService.getAllSubsidies();

  print("ADMIN DATA UI: $data");   // 🔥 ADD THIS

  setState(() {
    subsidies = data;
  });
}

  void updateStatus(String id, String status) async {
    await ApiService.updateSubsidyStatus(id, status);
    loadSubsidies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: subsidies.isEmpty
          ? Center(child: Text("No Applications"))
          : ListView.builder(
              itemCount: subsidies.length,
              itemBuilder: (_, i) {
                var sub = subsidies[i];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                     title: Text("Farmer: ${sub['farmerName']}"),   // 🔥 HERE
    subtitle: Text(
      "Mobile: ${sub['farmerMobile']}\n"
      "Cows: ${sub['cows']}\n"
      "Status: ${sub['status']}"
    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () =>
                              updateStatus(sub['_id'], "Approved"),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () =>
                              updateStatus(sub['_id'], "Rejected"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}