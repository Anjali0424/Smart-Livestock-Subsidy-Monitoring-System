import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String farmerId = "";
  bool isLoaded = false;

  int totalAnimals = 0;
int totalSubsidy = 0;
int approved = 0;
int pending = 0;
int rejected = 0;
bool isLoading = true;

void loadStats() async {
  try {
    final animals = await ApiService.getAnimals(farmerId);
    final subsidy = await ApiService.getSubsidy(farmerId);

int approvedCount = 0;
int pendingCount = 0;
int rejectedCount = 0;

for (var s in subsidy) {
  if (s['status'] == "Approved") {
    approvedCount++;
  } 
  else if (s['status'] == "Pending") {
    pendingCount++;
  } 
  else if (s['status'] == "Rejected") {
    rejectedCount++;
  }
}

    setState(() {
      totalAnimals = animals.length;
      totalSubsidy = subsidy.length;
      approved = approvedCount;
      pending = pendingCount;
      rejected = rejectedCount; 
      isLoading = false;
    });

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

      print("FARMER ID (Dashboard): $farmerId");

      loadStats();

      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
         backgroundColor: Colors.blueGrey,
  elevation: 1,
  actions: [

  // 🔓 LOGOUT
  IconButton(
    icon: Icon(Icons.logout),
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No", style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text("Yes", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );
    },
  ),

  // 👤 PROFILE
  IconButton(
    icon: Icon(Icons.person),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(farmerId: farmerId),
        ),
      );
    },
  ),

  
 

],
      ),

body: isLoading
    ? Center(child: CircularProgressIndicator())
    : Container(
        color: Colors.grey.shade100, // ✅ light background
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
          children: [

            // 🔥 STATS CARDS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statCard("Animals", totalAnimals, Colors.green),
                statCard("Subsidy", totalSubsidy, Colors.blue),
              ],
            ),

            SizedBox(height: 15),

Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        statCard("Approved", approved, Colors.teal),
        statCard("Pending", pending, Colors.orange),
      ],
    ),

    SizedBox(height: 15),

    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        statCard("Rejected", rejected, Colors.red),
      ],
    ),
  ],
),

            SizedBox(height: 30),

            // 🔥 NAVIGATION (UNCHANGED)
            cardButton("Animals", Icons.pets, () async {
  await Navigator.pushNamed(context, '/animals', arguments: farmerId);

  loadStats(); // 🔥 refresh dashboard
}),

cardButton("Subsidy", Icons.currency_rupee, () async {
  await Navigator.pushNamed(context, '/subsidy', arguments: farmerId);

  loadStats(); // 🔥 refresh dashboard
}),
          ],
        ),
      ),
    )
    );
  }

 Widget statCard(String title, int value, Color color) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.42,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white, // ✅ white card
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300), // subtle border
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 4,
        )
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.bar_chart, color: Colors.blueGrey), // ✅ subtle icon

        SizedBox(height: 8),

        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),

        SizedBox(height: 8),

        Text(
          value.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget cardButton(String title, IconData icon, Function onTap) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade200, blurRadius: 4),
      ],
    ),
    child: ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blueGrey),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => onTap(),
    ),
  );
}
}



