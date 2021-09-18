import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    final body = json.decode(response.body);

    return body;
  }

  Future<void> pickImage(ImageSource source) async {
    XFile? selFile = await picker.pickImage(source: source);
    File selected = File(selFile!.path);

    setState(() {
      imageFile = selected;
    });

    // var url = Uri.parse("https://api.edamam.com/api/nutrition-data");
    // var url = Uri.parse(
    //     "https://api.edamam.com/api/nutrition-data?app_id=e45357af&app_key=b93730855e301e7ba5518d4b4c707e9a&nutrition_type=logging&ingr=1%20slice%20chocolate%20cake");
    // var response = await http.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    // final body = json.decode(response.body);

    nutritionInfo = await getInfo(
        "https://api.edamam.com/api/nutrition-data?app_id=e45357af&app_key=b93730855e301e7ba5518d4b4c707e9a&nutrition_type=logging&ingr=1%20slice%20chocolate%20cake");

    print(nutritionInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calorie Counter"),
        backgroundColor: Colors.purple[300],
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //TODO: Allow users to choose from gallery too
      //     _picker.pickImage(source: ImageSource.camera);
      //   },
      //   tooltip: "Take or Select an Image",
      //   backgroundColor: Colors.purple,
      //   child: const Icon(Icons.add_a_photo, color: Colors.white),
      // ),
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
