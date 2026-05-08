import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AnimalDetailScreen extends StatefulWidget {
  final Map animal;

  AnimalDetailScreen({required this.animal});

  @override
  _AnimalDetailScreenState createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {

  // ✏️ EDIT FUNCTION
  void showEditDialog(BuildContext context) {
    TextEditingController breed =
        TextEditingController(text: widget.animal['breed']);
    TextEditingController age =
        TextEditingController(text: widget.animal['age']);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit Animal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: breed,
                decoration: InputDecoration(labelText: "Breed"),
              ),
              TextField(
                controller: age,
                decoration: InputDecoration(labelText: "Age"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
  await ApiService.updateAnimal(
  widget.animal['_id'],   // ✅ FIXED
  breed.text,             // ✅ FIXED
  age.text,
);

  Navigator.pop(context);       // close dialog
  Navigator.pop(context, true); // 🔥 send signal back
},
              child: Text("Save"),
            )
          ],
        );
      },
    );
  }

  // 🗑 DELETE FUNCTION
void deleteAnimal(BuildContext context) async {
  try {
    await ApiService.deleteAnimal(widget.animal['_id']);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Deleted Successfully ✅")),
    );

    // 🔥 VERY IMPORTANT
    Navigator.pop(context, true);

  } catch (e) {
    print("DELETE ERROR: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animal Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🖼 IMAGE
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (widget.animal['image'] != null &&
                        widget.animal['image'] != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullImageView(
                            imageUrl:
                                "${ApiService.baseUrl}/uploads/${widget.animal['image']}",
                          ),
                        ),
                      );
                    }
                  },
                  child: (widget.animal['image'] != null &&
                          widget.animal['image'] != "")
                      ? Image.network(
                          "${ApiService.baseUrl}/uploads/${widget.animal['image']}",
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.pets, size: 100),
                        )
                      : Icon(Icons.pets, size: 100),
                ),
              ),

              SizedBox(height: 20),

              // 📋 DETAILS
              Text("Breed: ${widget.animal['breed']}",
                  style: TextStyle(fontSize: 16)),
              Text("Age: ${widget.animal['age']}",
                  style: TextStyle(fontSize: 16)),

              SizedBox(height: 10),

              Text("RFID: ${widget.animal['rfid'] ?? 'N/A'}"),
              Text("Farmer ID: ${widget.animal['farmerId'] ?? 'N/A'}"),

              SizedBox(height: 10),

              Text(
                "Created At: ${widget.animal['createdAt'] ?? 'N/A'}",
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 20),

              // 🔘 BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      showEditDialog(context);
                    },
                    child: Text("Edit"),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red),
                    onPressed: () {
                      deleteAnimal(context);
                    },
                    child: Text("Delete"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ FULL IMAGE VIEW (DO NOT REMOVE)
class FullImageView extends StatelessWidget {
  final String imageUrl;

  FullImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}