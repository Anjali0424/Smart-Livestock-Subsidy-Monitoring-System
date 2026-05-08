import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SubsidyHistoryScreen extends StatefulWidget {
  @override
  _SubsidyHistoryScreenState createState() =>
      _SubsidyHistoryScreenState();
}

class _SubsidyHistoryScreenState extends State<SubsidyHistoryScreen> {
  List data = [];
  String farmerId = "";
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isLoaded) {
      farmerId =
          ModalRoute.of(context)!.settings.arguments as String;

      loadHistory();

      isLoaded = true;
    }
  }

  void loadHistory() async {
    final res = await ApiService.getSubsidy(farmerId);

    setState(() {
      data = res;
    });
  }

  Color getStatusColor(String status) {
    if (status == "Approved") return Colors.green;
    if (status == "Rejected") return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subsidy History"),
      ),
      body: data.isEmpty
          ? Center(child: Text("No history found"))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, i) {
                var sub = data[i];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Cows: ${sub['cows']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location: ${sub['location'] ?? ''}"),
                        Text("Bank: ${sub['bankAccount'] ?? ''}"),
                        Text("IFSC: ${sub['ifsc'] ?? ''}"),
                        Text(
                          "Status: ${sub['status']}",
                          style: TextStyle(
                            color: getStatusColor(sub['status']),
                            fontWeight: FontWeight.bold,
                          ),
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