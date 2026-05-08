import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class SubsidyScreen extends StatefulWidget {
  @override
  _SubsidyScreenState createState() => _SubsidyScreenState();
}

class _SubsidyScreenState extends State<SubsidyScreen> {
  List subsidies = [];
  TextEditingController cows = TextEditingController();
  TextEditingController location = TextEditingController();
TextEditingController bank = TextEditingController();
TextEditingController ifsc = TextEditingController();
File? selectedDoc;

  bool showHistory = false;
  String farmerId = "";   // ✅ HERE
  bool isLoaded = false;  // ✅ HERE

  @override
  void initState() {
    super.initState();
    //loadSubsidy();
  }

  void loadSubsidy() async {
    final data = await ApiService.getSubsidy(farmerId);
    setState(() {
      subsidies = data;
    });
  }

void applySubsidy() async {
  print("APPLY BUTTON CLICKED 🔥");

  if (cows.text.isEmpty ||
    location.text.isEmpty ||
    bank.text.isEmpty ||
    ifsc.text.isEmpty) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Fill all fields ❌")),
  );
  return;
}

  try {
    final res = await ApiService.applySubsidy(
  farmerId,
  int.parse(cows.text),
  location.text,
  bank.text,
  ifsc.text,
  selectedDoc,
);

    print("SUBSIDY RESPONSE: $res");

    // ✅ ADD THIS
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Subsidy Applied Successfully ✅")),
    );

    cows.clear();
location.clear();
bank.clear();
ifsc.clear();
selectedDoc = null;
   Navigator.pop(context, true); // 🔥 IMPORTANT

  } catch (e) {
    print("ERROR: $e");
  }
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (!isLoaded) {
    farmerId =
        ModalRoute.of(context)!.settings.arguments as String;

    print("FARMER ID (Subsidy): $farmerId"); // 🔥 ADD

    loadSubsidy();

    isLoaded = true;
  }
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
  title: Text("Subsidy"),
  backgroundColor: Colors.blueGrey,
  elevation: 1,
),
    body: Container(
  color: Colors.grey.shade100,
  child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
  controller: cows,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    labelText: "Number of Cows",
    prefixIcon: Icon(Icons.pets),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),

            SizedBox(height: 10),

TextField(
  controller: location,
  decoration: InputDecoration(
    labelText: "Location",
    prefixIcon: Icon(Icons.location_on),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),

            SizedBox(height: 10),

            TextField(
  controller: bank,
  decoration: InputDecoration(
    labelText: "Bank Account",
    prefixIcon: Icon(Icons.account_balance),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),

            SizedBox(height: 10),

            TextField(
  controller: ifsc,
  decoration: InputDecoration(
    labelText: "IFSC Code",
    prefixIcon: Icon(Icons.code),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
),

            SizedBox(height: 10),

            // ElevatedButton(
            //   onPressed: () async {
            //     final picked = await ImagePicker()
            //         .pickImage(source: ImageSource.gallery);

            //     if (picked != null) {
            //       setState(() {
            //         selectedDoc = File(picked.path);
            //       });
            //     }
            //   },
            //   child: Text("Upload Document"),
            // ),

SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () async {
      final picked = await ImagePicker()
          .pickImage(source: ImageSource.gallery);

      if (picked != null) {
        setState(() {
          selectedDoc = File(picked.path);
        });
      }
    },
    icon: Icon(Icons.upload_file),
    label: Text("Upload Document"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      padding: EdgeInsets.symmetric(vertical: 12),
    ),
  ),
),

            SizedBox(height: 10),

            selectedDoc != null
    ? Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          SizedBox(width: 5),
          Text("Document Selected"),
        ],
      )
                : Text("No document selected"),

            SizedBox(height: 10),

            SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: applySubsidy,
    icon: Icon(Icons.send),
    label: Text("Apply Subsidy"),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      padding: EdgeInsets.symmetric(vertical: 14),
    ),
  ),
),

            SizedBox(height: 10),

            SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    onPressed: () {
      setState(() {
        showHistory = !showHistory;
      });
    },
    icon: Icon(Icons.history),
    label: Text(showHistory ? "Hide History" : "View History"),
  ),
),

            SizedBox(height: 20),

            if (showHistory)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: subsidies.length,
                itemBuilder: (_, i) {
                  var sub = subsidies[i];

                 return Container(
  margin: EdgeInsets.symmetric(vertical: 6),
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(color: Colors.grey.shade200, blurRadius: 4)
    ],
  ),
  child: ListTile(
                      title: Text("Cows: ${sub['cows']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
  "Status: ${sub['status'] ?? 'Pending'}",
  style: TextStyle(
    fontWeight: FontWeight.bold,
    color: sub['status'] == "Approved"
        ? Colors.green
        : sub['status'] == "Rejected"
            ? Colors.red
            : Colors.orange,
  ),
),
                          Text("Location: ${sub['location'] ?? ''}"),
                          Text("Bank: ${sub['bankAccount'] ?? ''}"),
                          Text("IFSC: ${sub['ifsc'] ?? ''}"),
                          sub['document'] != null && sub['document'] != ""
                              ? Text("Doc: ${sub['document']}")
                              : Text("No document"),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    ),
   )
    );
}
}