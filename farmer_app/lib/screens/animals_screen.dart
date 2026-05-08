import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import 'animal_detail_screen.dart';


class AnimalsScreen extends StatefulWidget {
  @override
  _AnimalsScreenState createState() => _AnimalsScreenState();
  
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  List animals = [];
  File? selectedImage;

  List allAnimals = [];   // original data
List filteredAnimals = []; // search result
TextEditingController search = TextEditingController();

   String farmerId = "";
   bool isLoaded = false; // 🔥 ADD THIS

  @override
  void initState() {
    super.initState();
    //loadAnimals();
  }

  void loadAnimals() async {
    final data = await ApiService.getAnimals(farmerId);
    setState(() {
      allAnimals = data;
filteredAnimals = data;
    });
  }

  void searchAnimals(String query) {
  final result = allAnimals.where((animal) {
   final rfid = (animal['rfid'] ?? "").toString().toLowerCase();
final breed = (animal['breed'] ?? "").toString().toLowerCase();
    return rfid.contains(query.toLowerCase()) ||
           breed.contains(query.toLowerCase());
  }).toList();

  setState(() {
    filteredAnimals = result;
  });
}

  void showAddDialog() {
    TextEditingController breed = TextEditingController();
    TextEditingController age = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Add Animal"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    

                    TextField(
                      controller: breed,
                      decoration: InputDecoration(labelText: "Breed"),
                    ),
                    TextField(
                      controller: age,
                      decoration: InputDecoration(labelText: "Age"),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () async {
                        final picked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (picked != null) {
                          setStateDialog(() {
                            selectedImage = File(picked.path);
                          });
                        }
                      },
                      child: Text("Select Image"),
                    ),

                    SizedBox(height: 10),

                    // ✅ PREVIEW
                    selectedImage != null
                        ? Image.file(selectedImage!, height: 120)
                        : Text("No image selected"),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    print("SAVE CLICKED 🔥");

                    if (selectedImage != null) {
                      await ApiService.addAnimalWithImage(
  "RFID${DateTime.now().millisecondsSinceEpoch}",
  breed.text,
  age.text,
  selectedImage!,
  farmerId,   // 🔥 ADD THIS
);
                    } else {
                     await ApiService.addAnimal(
  "RFID${DateTime.now().millisecondsSinceEpoch}",
  breed.text,
  age.text,
  farmerId,   // 🔥 ADD THIS
);
                    }

                   Navigator.pop(context, true); // 🔥 IMPORTANT

setState(() {
  selectedImage = null;
});

                    loadAnimals();
                  },
                  child: Text("Save"),
                )
              ],
            );
          },
        );
      },
    );
  }

 @override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (!isLoaded) {
    farmerId =
        ModalRoute.of(context)!.settings.arguments as String;

    print("FARMER ID (Animals): $farmerId"); // 🔥 ADD

    loadAnimals();

    isLoaded = true;
  }
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     appBar: AppBar(
  title: Text("Animals"),
  backgroundColor: Colors.blueGrey,
  elevation: 1,
),
      floatingActionButton: FloatingActionButton.extended(
  onPressed: showAddDialog,
  icon: Icon(Icons.add),
  label: Text("Add Animal"),
  backgroundColor: Colors.blueGrey,
),
body: Container(
  color: Colors.grey.shade100,
  child: Column(
  children: [

    // 🔍 SEARCH BAR
    Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
  controller: search,
  decoration: InputDecoration(
    hintText: "Search by RFID or Breed",
    prefixIcon: Icon(Icons.search),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  onChanged: searchAnimals,
),
    ),

    // 📋 LIST
    Expanded(
      child: filteredAnimals.isEmpty
          ? Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.pets, size: 50, color: Colors.grey),
      SizedBox(height: 10),
      Text("No animals found"),
    ],
  ),
)
          : ListView.builder(
              itemCount: filteredAnimals.length,
              itemBuilder: (_, i) {
                var animal = filteredAnimals[i];

                return Container(
  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: 4,
      )
    ],
  ),
  child: ListTile(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AnimalDetailScreen(animal: animal),
                        ),
                      );

                      if (result == true) {
                        loadAnimals();
                      }
                    },
                    leading: (animal['image'] != null && animal['image'] != "")
                        ? ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.network(
    "${ApiService.baseUrl}/uploads/${animal['image']}",
    width: 50,
    height: 50,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => Icon(Icons.pets),
  ),
)
                        : CircleAvatar(
    backgroundColor: Colors.blueGrey.shade100,
    child: Icon(Icons.pets, color: Colors.blueGrey),
  ),
                    title: Text(
  animal['breed'] ?? "Unknown",
  style: TextStyle(fontWeight: FontWeight.w600),
),

subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Age: ${animal['age'] ?? 'N/A'}"),
    Text(
      "RFID: ${animal['rfid'] ?? 'N/A'}",
      style: TextStyle(fontSize: 12),
    ),
  ],
),
                  ),
                );
              },
            ),
    ),
  ],
),
     )
      );
  }
}