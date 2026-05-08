import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApplySubsidy extends StatelessWidget {
  final controller = TextEditingController();

  void submit(BuildContext context) async {
    await ApiService.applySubsidy(controller.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Applied Successfully")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apply Subsidy")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  labelText: "Number of Cows",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => submit(context),
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}