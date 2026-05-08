import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController location = TextEditingController();

  void register() async {
    final res = await ApiService.register(
      name.text,
      mobile.text,
      password.text,
      location.text,
    );

    print("REGISTER RESPONSE: $res");

    Navigator.pop(context); // back to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blueGrey.shade200, Colors.blueGrey.shade700],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  child: Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // 🔹 ICON
                Icon(Icons.app_registration,
                    size: 70, color: Colors.blueGrey),

                SizedBox(height: 10),

                // 🔹 TITLE
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // 🔹 NAME
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                // 🔹 MOBILE
                TextField(
                  controller: mobile,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Mobile",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                // 🔹 PASSWORD
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                // 🔹 LOCATION
                TextField(
                  controller: location,
                  decoration: InputDecoration(
                    labelText: "Location",
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                // 🔹 REGISTER BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
  onPressed: () {
    register();
  },
  icon: Icon(Icons.check, color: Colors.white),   // ✅ icon color
  label: Text(
    "Register",
    style: TextStyle(color: Colors.white),        // ✅ text color
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    padding: EdgeInsets.symmetric(vertical: 12),
  ),
),
                ),

                SizedBox(height: 10),

                // 🔹 BACK TO LOGIN
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Already have account? Login"),
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  ),
),
    );
  }
}