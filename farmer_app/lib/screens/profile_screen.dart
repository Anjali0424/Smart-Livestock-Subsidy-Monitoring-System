import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String farmerId;

  ProfileScreen({required this.farmerId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController aadhaar = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  void fetchProfile() async {
    final res = await http.get(
      Uri.parse("http://10.91.53.237:5000/api/farmer/profile-id/${widget.farmerId}")
    );

    final data = jsonDecode(res.body);

    setState(() {
      name.text = data['name'] ?? "";
      address.text = data['address'] ?? "";
      aadhaar.text = data['aadhaar'] ?? "";
    });
  }

  void updateProfile() async {
  print("UPDATE CLICKED 🔥");

  try {
    final res = await http.put(
      Uri.parse("http://10.91.53.237:5000/api/farmer/update/${widget.farmerId}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name.text,
        "address": address.text,
        "aadhaar": aadhaar.text
      }),
    );

    print("STATUS: ${res.statusCode}");
    print("BODY: ${res.body}");

    final data = jsonDecode(res.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Updated ✅")),
    );

  } catch (e) {
    print("ERROR: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Server not reachable ❌")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: address, decoration: InputDecoration(labelText: "Address")),
            TextField(controller: aadhaar, decoration: InputDecoration(labelText: "Aadhaar")),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateProfile,
              child: Text("Update Profile"),
            )
          ],
        ),
      ),
    );
  }
}