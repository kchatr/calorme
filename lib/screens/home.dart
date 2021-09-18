import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  Map<String, dynamic>? nutritionInfo;

  Future<dynamic> getInfo(String url) async {
    var uri = Uri.parse(url);

    var response = await http.get(uri);

    final body = json.decode(response.body);

    return body;
  }

  Future<void> pickImage(ImageSource source) async {
    XFile? selFile = await picker.pickImage(source: source);
    File selected = File(selFile!.path);

    setState(() {
      imageFile = selected;
    });

    nutritionInfo = await getInfo(
        "https://api.edamam.com/api/nutrition-data?app_id=e45357af&app_key=b93730855e301e7ba5518d4b4c707e9a&nutrition_type=logging&ingr=1%20slice%20chocolate%20cake");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calorie Counter"),
        backgroundColor: Colors.purple[300],
      ),
      body: SlidingUpPanel(
        color: Colors.teal.shade300,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22.0), topRight: Radius.circular(22.0)),
        minHeight: 30.0,
        panel: Column(
          children: [
            Text("Nutritional Info",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontSize: 19.0,
                  color: Colors.white,
                )),
            const SizedBox(height: 30),
            Text(
              "Calories: ${nutritionInfo?['calories'] ?? 'N/A'}",
              style: GoogleFonts.quicksand(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Fat: ${nutritionInfo?['totalNutrients']['FAT']['quantity'] ?? 'N/A'} g",
              style: GoogleFonts.quicksand(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Fiber: ${nutritionInfo?['totalNutrients']['FIBTG']['quantity'] ?? 'N/A'} g",
              style: GoogleFonts.quicksand(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Protein: ${nutritionInfo?['totalNutrients']['PROCNT']['quantity'] ?? 'N/A'} g",
              style: GoogleFonts.quicksand(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Carbs: ${nutritionInfo?['totalNutrients']['CHOCDF']['quantity'] ?? 'N/A'} g",
              style: GoogleFonts.quicksand(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Cholesterol: ${nutritionInfo?['totalNutrients']['CHOLE']['quantity'] ?? 'N/A'}",
              style: GoogleFonts.quicksand(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: 240.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/home_bg.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Center(
                child: Text(
                  "Welcome to CalorMe!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.questrial(
                    textStyle: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (imageFile != null) ...[Image.file(imageFile!)],
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              color: Colors.purple[100],
              icon: const Icon(Icons.add_a_photo, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              color: Colors.purple[100],
              icon: const Icon(Icons.photo_library, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
