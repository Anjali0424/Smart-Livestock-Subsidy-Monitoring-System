import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import 'full_image_screen.dart';

class AdminSubsidyScreen extends StatefulWidget {
  @override
  _AdminSubsidyScreenState createState() => _AdminSubsidyScreenState();
}

class _AdminSubsidyScreenState extends State<AdminSubsidyScreen> {

  List subsidies = [];
  bool isLoading = true;
  String filter = "All";
List filteredList = [];
TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSubsidies();
  }

  Future<void> fetchSubsidies() async {
  try {
    final data = await ApiService.getAllSubsidies();

   setState(() {
  subsidies = data;
  isLoading = false;
});

applyFilter(); // 🔥 IMPORTANT

  } catch (e) {
    print("ERROR: $e");
    setState(() {
      isLoading = false;
    });
  }
}

Future<void> updateStatus(String id, String status) async {

  int index = subsidies.indexWhere((s) => s['_id'] == id);

  if (index != -1) {
    setState(() {
      subsidies = List.from(subsidies);
      subsidies[index]['status'] = status;
    });
  }

  await ApiService.updateSubsidyStatus(id, status);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Subsidy $status successfully"),
      backgroundColor: status == "Approved" ? Colors.green : Colors.red,
    ),
  );

  await Future.delayed(Duration(milliseconds: 300));
  await fetchSubsidies();
}

void applyFilter() {
  List temp = List.from(subsidies);

  if (filter != "All") {
    temp = temp.where((s) => s['status'] == filter).toList();
  }

  if (search.text.isNotEmpty) {
    temp = temp.where((s) =>
        (s['farmerName'] ?? "").toLowerCase()
            .contains(search.text.toLowerCase())).toList();
  }

  setState(() {
    filteredList = temp;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subsidy Management")),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
         : Column(
        children: [

          // 🔍 SEARCH
// 🔍 SEARCH (CORRECT)
Padding(
  padding: EdgeInsets.all(10),
  child: TextField(
    controller: search,
    decoration: InputDecoration(
      labelText: "Search Farmer",
      border: OutlineInputBorder(),
    ),
    onChanged: (_) => applyFilter(),
  ),
),

SizedBox(height: 10),

          // 🔽 FILTER
          // 🔽 FILTER (FINAL)
Padding(
  padding: EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButton(
      isExpanded: true,
      value: filter,
      underline: SizedBox(),
      items: ["All", "Pending", "Approved", "Rejected"]
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (val) {
        filter = val.toString();
        applyFilter();
      },
    ),
  ),
),

          // 📋 LIST
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final s = filteredList[index];

               return Container(
  margin: EdgeInsets.all(10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    gradient: LinearGradient(
      colors: [Colors.white, Colors.grey.shade100],
    ),
    boxShadow: [
      BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
    ],
  ),
  child: Padding(
    padding: EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Farmer: ${s['farmerName'] ?? 'N/A'}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("Mobile: ${s['farmerMobile'] ?? 'N/A'}"),
        Text("Cows: ${s['cows']}"),
        Text("Location: ${s['location']}"),
        Text("Bank: ${s['bankAccount']}"),
        Text("IFSC: ${s['ifsc']}"),

        SizedBox(height: 10),

        // 🔥 DOCUMENT BUTTON
        if (s['document'] != null && s['document'] != "")
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullImageScreen(
                    imageUrl:
                        "${ApiService.baseUrl}/uploads/${s['document']}",
                  ),
                ),
              );
            },
            child: Text("View Document"),
          ),

        SizedBox(height: 10),

        // 🔥 STATUS BADGE
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: s['status'] == "Approved"
                ? Colors.green.shade100
                : s['status'] == "Rejected"
                    ? Colors.red.shade100
                    : Colors.orange.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            s['status'],
            style: TextStyle(
              color: s['status'] == "Approved"
                  ? Colors.green
                  : s['status'] == "Rejected"
                      ? Colors.red
                      : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(height: 10),

        // 🔥 BUTTONS
        if (s['status'] == "Pending")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ElevatedButton(
                onPressed: () {
                  updateStatus(s['_id'], "Approved");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green),
                child: Text("Approve"),
              ),

              ElevatedButton(
                onPressed: () {
                  updateStatus(s['_id'], "Rejected");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red),
                child: Text("Reject"),
              ),

            ],
          )
        else
          Text(
            "Final Status: ${s['status']}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
      ],
    ),
  ),
);
              },
            ),
          )
        ]
          )
    );
  }
}