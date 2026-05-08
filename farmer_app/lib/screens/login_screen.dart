import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    print("LOGIN CLICKED 🔥");

    try {
      final res = await ApiService.login(mobile.text, password.text);

      print("RESPONSE: $res");

      if (res != null && res['mobile'] != null) {
        Navigator.pushReplacementNamed(
  context,
  '/dashboard',
  arguments: res['_id'],   // 🔥 IMPORTANT
);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid login ❌")),
        );
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  // 🔥 TEST BUTTON FUNCTION (for debugging API)
  void testApi() async {
    try {
      final res = await http.get(Uri.parse("http://localhost:5000"));
      print("TEST SUCCESS: ${res.body}");
    } catch (e) {
      print("TEST ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

      // 🔹 LEFT: LOGIN TEXT
      Text("Login"),

      // 🔹 RIGHT: ADMIN LOGIN BUTTON
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/admin-login');
        },
        child: Row(
          children: [
            Icon(Icons.admin_panel_settings, size: 18),
            SizedBox(width: 5),
            Text(
              "Admin",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),

    ],
  ),
),
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
                Icon(Icons.person, size: 70, color: Colors.blueGrey),

                SizedBox(height: 10),

                // 🔹 TITLE
                Text(
                  "Farmer Login",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // 🔹 MOBILE FIELD
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

                // 🔹 PASSWORD FIELD
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                // 🔹 LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
  onPressed: () {
    login();
  },
  icon: Icon(Icons.login, color: Colors.white),   // ✅ icon color
  label: Text(
    "Login",
    style: TextStyle(color: Colors.white),        // ✅ text color
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    padding: EdgeInsets.symmetric(vertical: 12),
  ),
),
                ),

                SizedBox(height: 10),

                // 🔹 REGISTER
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text("Don't have account? Register"),
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