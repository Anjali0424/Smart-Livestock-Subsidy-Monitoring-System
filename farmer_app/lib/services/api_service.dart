import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.91.53.237:5000";

  // 🔐 LOGIN
  static Future login(String mobile, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/api/farmer/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mobile": mobile,
        "password": password
      }),
    );


    return jsonDecode(res.body);
  }

  // 🆕 REGISTER
  static Future register(
      String name, String mobile, String password, String location) async {
    final res = await http.post(
      Uri.parse("$baseUrl/api/farmer/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "mobile": mobile,
        "password": password,
        "location": location
      }),
    );

    return jsonDecode(res.body);
  }

  // 🐄 ADD ANIMAL
  static Future addAnimal(
  String rfid,
  String breed,
  String age,
  String farmerId,
) async {
  await http.post(
    Uri.parse("$baseUrl/api/animal/add"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "rfid": rfid,
      "breed": breed,
      "age": age,
      "farmerId": farmerId   // 🔥 IMPORTANT
    }),
  );
}

static Future addAnimalWithImage(
  String rfid,
  String breed,
  String age,
  File image,
  String farmerId,
) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("$baseUrl/api/animal/add-with-image"),
  );

  request.fields['rfid'] = rfid;
  request.fields['breed'] = breed;
  request.fields['age'] = age;
  request.fields['farmerId'] = farmerId; // 🔥 IMPORTANT

  request.files.add(
    await http.MultipartFile.fromPath('image', image.path),
  );

  var response = await request.send();

  print("UPLOAD STATUS: ${response.statusCode}");
}

  // 📋 GET ANIMALS
  static Future<List> getAnimals(String farmerId) async {
  final res = await http.get(
    Uri.parse("$baseUrl/api/animal/$farmerId"),
  );

  return jsonDecode(res.body);
}

 static Future applySubsidy(
  String farmerId,
  int cows,
  String location,
  String bank,
  String ifsc,
  File? document,
) async {

  var request = http.MultipartRequest(
    'POST',
    Uri.parse("$baseUrl/api/subsidy/apply"),
  );

  request.fields['farmerId'] = farmerId;
  request.fields['cows'] = cows.toString();
  request.fields['location'] = location;
  request.fields['bankAccount'] = bank;
  request.fields['ifsc'] = ifsc;

  if (document != null) {
    request.files.add(
      await http.MultipartFile.fromPath('document', document.path),
    );
  }

  var res = await request.send();

  print("SUBSIDY STATUS: ${res.statusCode}");
}

  // 📊 GET SUBSIDY
  static Future<List> getSubsidy(String farmerId) async {
  final res = await http.get(
    Uri.parse("$baseUrl/api/subsidy/$farmerId"),
  );

  return jsonDecode(res.body);
}

  // 📋 GET ALL SUBSIDIES (ADMIN)
static Future<List> getAllSubsidies() async {
  final res = await http.get(
    Uri.parse("$baseUrl/api/subsidy/all"),
  );
  return jsonDecode(res.body);
}

// 🐄 GET ALL ANIMALS (ADMIN)
static Future<List> getAllAnimals() async {
  final res = await http.get(
    Uri.parse("$baseUrl/api/animal/all"),
  );

  return jsonDecode(res.body);
}

// 🔄 UPDATE STATUS
static Future updateSubsidyStatus(String id, String status) async {
  final res = await http.put(
    Uri.parse("$baseUrl/api/subsidy/update/$id"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"status": status}),
  );

  return jsonDecode(res.body);
}

static Future updateProfile(
  String farmerId,
  String name,
  String mobile,
  String password,
) async {
  final res = await http.put(
    Uri.parse("$baseUrl/api/farmer/update/$farmerId"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "name": name,
      "mobile": mobile,
      "password": password
    }),
  );

  return jsonDecode(res.body);
}

static Future updateAnimal(String id, String breed, String age) async {
  await http.put(
    Uri.parse("$baseUrl/api/animal/update/$id"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "breed": breed,
      "age": age
    }),
  );
}

static Future deleteAnimal(String id) async {
  await http.delete(
    Uri.parse("$baseUrl/api/animal/delete/$id"),
  );
}

// 👨‍🌾 GET ALL FARMERS (ADMIN)
static Future<List> getAllFarmers() async {
  final res = await http.get(
    Uri.parse("$baseUrl/api/farmer/all"),
  );

  return jsonDecode(res.body);
}

}