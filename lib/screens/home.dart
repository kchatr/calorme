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
    setState(() {
      nutritionInfo;
    });
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Nutritional Information Updated'),
        content: const Text('Swipe up on the panel to view information.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK',
                style: TextStyle(color: Color(0xff7c064f), fontSize: 16.0)),
          ),
        ],
        titleTextStyle:
            const TextStyle(color: Color(0xff7c064f), fontSize: 20.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to CalorMe"),
        backgroundColor: const Color(0xff7c064f),
      ),
      body: SlidingUpPanel(
        color: Colors.pink.shade800,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22.0), topRight: Radius.circular(22.0)),
        minHeight: 30.0,
        panel: Column(
          children: [
            const Icon(Icons.arrow_drop_up, size: 30.0, color: Colors.white),
            Text("Nutritional Info",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontSize: 19.0,
                  color: Colors.white,
                )),
            const SizedBox(height: 30),
            Table(
              border: TableBorder.all(color: Colors.white),
              children: [
                TableRow(children: [
                  const Info("Calories"),
                  Info(nutritionInfo?['calories'].toString() ?? 'N/A'),
                ]),
                TableRow(children: [
                  const Info("Fat"),
                  Info((nutritionInfo?['totalNutrients']['FAT']['quantity']
                              .toString() ??
                          'N/A') +
                      "g"),
                ]),
                TableRow(children: [
                  const Info("Fiber"),
                  Info((nutritionInfo?['totalNutrients']['FIBTG']['quantity']
                              .toString() ??
                          'N/A') +
                      "g"),
                ]),
                TableRow(children: [
                  const Info("Protein"),
                  Info((nutritionInfo?['totalNutrients']['PROCNT']['quantity']
                              .toString() ??
                          'N/A') +
                      "g"),
                ]),
                TableRow(children: [
                  const Info("Carbs"),
                  Info((nutritionInfo?['totalNutrients']['CHOCDF']['quantity']
                              .toString() ??
                          'N/A') +
                      "g"),
                ]),
                TableRow(children: [
                  const Info("Cholesterol"),
                  Info((nutritionInfo?['totalNutrients']['CHOLE']['quantity']
                          .toString() ??
                      'N/A')),
                ]),
              ],
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            // color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.fill),
          ),
          child: ListView(
            children: [
              const SizedBox(height: 2),
              Center(
                child: Image.asset("assets/images/calorme.png"),
              ),
              Container(
                child: imageFile != null
                    ? Image.file(imageFile!)
                    : Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black]),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff7c064f),
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

class Info extends StatelessWidget {
  final String? text;
  const Info(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        textAlign: TextAlign.center,
        style: GoogleFonts.rubik(
          fontSize: 19.0,
          color: Colors.white,
        ));
  }
}
