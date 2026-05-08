import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SubsidyHistory extends StatefulWidget {
  @override
  _SubsidyHistoryState createState() => _SubsidyHistoryState();
}

class _SubsidyHistoryState extends State<SubsidyHistory> {
  List data = [];
  Map<String, String> previousStatus = {};
  bool firstLoadDone = false; // 🔥 ADD THIS

  // @override
  // void initState() {
  //   super.initState();
  //   load();
  // }

  

void load() async {
  final farmerId =
      ModalRoute.of(context)?.settings.arguments as String?;

  if (farmerId == null) return;

  final res = await ApiService.getSubsidy(farmerId);

  if (firstLoadDone) {
    for (var item in res) {
      String id = item['_id'];
      String newStatus = item['status'];

      if (previousStatus.containsKey(id)) {
        String oldStatus = previousStatus[id]!;

        if (oldStatus != newStatus) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Update"),
              content: Text(
                newStatus == "Approved"
                    ? "Your subsidy has been Approved 🎉"
                    : "Your subsidy has been Rejected ❌",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                )
              ],
            ),
          );
        }
      }

      previousStatus[id] = newStatus;
    }
  } else {
    // 🔥 FIRST LOAD (NO POPUP)
    for (var item in res) {
      previousStatus[item['_id']] = item['status'];
    }
    firstLoadDone = true;
  }

  setState(() {
    data = res;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subsidy History")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) {
          return Card(
            child: ListTile(
              title: Text("${data[i]['cows']} cows"),
              subtitle: Text(
  "Status: ${data[i]['status']}",
  style: TextStyle(
    color: data[i]['status'] == "Approved"
        ? Colors.green
        : data[i]['status'] == "Rejected"
            ? Colors.red
            : Colors.orange,
  ),
),
            ),
          );
        },
      ),
    );
  }

@override
void initState() {
  super.initState();

  Future.doWhile(() async {
    await Future.delayed(Duration(seconds: 3));
    if (!mounted) return false;
    load(); // 🔄 refresh
    return true;
  });
}

  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  load(); // ✅ context safe here
}
}