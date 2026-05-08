import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AdminFarmersScreen extends StatefulWidget {
  @override
  _AdminFarmersScreenState createState() => _AdminFarmersScreenState();
}

class _AdminFarmersScreenState extends State<AdminFarmersScreen> {

  List farmers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFarmers();
  }

  Future<void> fetchFarmers() async {
    try {
      final data = await ApiService.getAllFarmers();

      setState(() {
        farmers = data;
        isLoading = false;
      });

    } catch (e) {
      print("ERROR: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void showFarmerDetails(Map f) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(f['name'] ?? "No Name"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Mobile: ${f['mobile']}"),
            Text("Aadhaar: ${f['aadhaar']}"),
            Text("Address: ${f['address']}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Farmer Management")),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: farmers.length,
              itemBuilder: (context, index) {
                final f = farmers[index];

return Container(
  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  child: Material(
    elevation: 4,
    borderRadius: BorderRadius.circular(15),
    child: ListTile(
      contentPadding: EdgeInsets.all(12),

      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue,
        child: Icon(Icons.person, color: Colors.white),
      ),

      title: Text(
        f['name'] ?? "",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      subtitle: Text("Mobile: ${f['mobile']}"),

      trailing: Icon(Icons.arrow_forward_ios),

      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Center(
              child: Text(
                f['name'] ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("📞 Mobile: ${f['mobile']}"),
                SizedBox(height: 5),
                Text("🆔 Aadhaar: ${f['aadhaar'] ?? 'N/A'}"),
                SizedBox(height: 5),
                Text("📍 Address: ${f['location'] ?? 'N/A'}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              )
            ],
          ),
        );
      },
    ),
  ),
);
              },
            ),
    );
  }
}