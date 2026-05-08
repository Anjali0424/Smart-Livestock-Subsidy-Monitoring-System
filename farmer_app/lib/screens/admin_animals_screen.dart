import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AdminAnimalsScreen extends StatefulWidget {
  @override
  _AdminAnimalsScreenState createState() => _AdminAnimalsScreenState();
}

class _AdminAnimalsScreenState extends State<AdminAnimalsScreen> {

  List animals = [];
  bool isLoading = true;
  Set duplicateRFIDs = {};

  @override
  void initState() {
    super.initState();
    fetchAnimals();
  }

  Future<void> fetchAnimals() async {
    try {
      final data = await ApiService.getAllAnimals();

      detectDuplicates(data); // 🔥 detect duplicate RFID

      setState(() {
        animals = data;
        isLoading = false;
      });

    } catch (e) {
      print("ERROR: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // 🔥 DUPLICATE DETECTION
  void detectDuplicates(List data) {
    Map<String, int> count = {};

    for (var a in data) {
      String rfid = a['rfid'] ?? "";

      if (count.containsKey(rfid)) {
        count[rfid] = count[rfid]! + 1;
      } else {
        count[rfid] = 1;
      }
    }

    duplicateRFIDs.clear();

    count.forEach((rfid, c) {
      if (c > 1) {
        duplicateRFIDs.add(rfid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animal Monitoring")),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final a = animals[index];
                bool isDuplicate = duplicateRFIDs.contains(a['rfid']);

                return Container(
  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
      colors: isDuplicate
          ? [Colors.red.shade100, Colors.red.shade50] // 🔥 duplicate highlight
          : [Colors.white, Colors.green.shade50],
    ),
    boxShadow: [
      BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
    ],
  ),
  child: ListTile(

    leading: CircleAvatar(
      backgroundColor: isDuplicate ? Colors.red : Colors.green,
      child: Icon(Icons.pets, color: Colors.white),
    ),

    title: Text(
      "RFID: ${a['rfid']}",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: isDuplicate ? Colors.red : Colors.black,
      ),
    ),

    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Breed: ${a['breed']}"),
        Text("Farmer ID: ${a['farmerId']}"),

        // 🔥 SHOW WARNING
        if (isDuplicate)
          Text(
            "⚠ Duplicate RFID Detected",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    ),

    trailing: Icon(Icons.arrow_forward_ios),

  ),
);
              },
            ),
    );
  }
}
