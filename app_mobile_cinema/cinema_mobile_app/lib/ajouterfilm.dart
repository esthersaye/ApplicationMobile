import 'dart:async';
import 'dart:io';

import 'package:cinema_mobile_app/page-admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class AjouterFilm extends StatefulWidget {
  @override
  _AjouterFilmState createState() => _AjouterFilmState();
}

class _AjouterFilmState extends State<AjouterFilm> {
  TextEditingController realisateur = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController titre = new TextEditingController();
  TextEditingController duree = new TextEditingController();
  TextEditingController photo = new TextEditingController();
  TextEditingController categorie = new TextEditingController();
  bool indique = false;
  File imageFile;
  File newFile;
  @override
  Widget build(BuildContext context) {
    showAlertDialog(context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Notification Ajouter"),
        content: Text("Ajout de Film sans succes."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter Film"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
                margin: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: titre,
                  decoration: InputDecoration(
                      hintText: 'Your Titre', labelText: 'Titre'),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
                margin: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                      hintText: 'Your Description', labelText: 'Description'),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
                margin: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: realisateur,
                  decoration: InputDecoration(
                      hintText: 'Your Realisateur', labelText: 'Realisateur'),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 3.0),
                margin: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: duree,
                  decoration: InputDecoration(
                      hintText: 'Your Duree', labelText: 'Duree'),
                ),
              ),
              Divider(),
              getImageWidget(),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: ElevatedButton(
                  child: Text(
                    'Ajouter Photo',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[400],
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: ElevatedButton(
                  child: Text(
                    'Validez',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[400],
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    bool d = ajoutefilm(
                      titre.text.toString(),
                      realisateur.text.toString(),
                      description.text.toString(),
                      duree.text.toString(),
                    );
                    titre.clear();
                    realisateur.clear();
                    description.clear();
                    duree.clear();
                    photo.clear();
                    categorie.clear();
                    if (d == true) {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Admin()));
                    } else {
                      showAlertDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) {
        indique = false;
        return;
      }
      final tempImage = photo;

      indique = true;
      print('dans get image ');
      print(tempImage);
      print('dans get image path');
      print(tempImage.path);
      print('nom');
      print('dans get image ');
      print(tempImage);
      print('dans get image path');
      print(tempImage.path);
      print(basename(tempImage.path));
      setState(() {
        imageFile = File(tempImage.path);
        save(imageFile);
        print(basename(imageFile.path));
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Widget getImageWidget() {
    // ignore: unnecessary_null_comparison
    if (indique) {
      print('affiche image');
      print(indique);
      return Image.file(
        imageFile,
        width: 350,
        height: 350,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "./images/logo1.png",
        width: 350,
        height: 350,
        fit: BoxFit.cover,
      );
    }
  }

  Future<void> save(File image) async {
    //final imageDirectory = await getApplicationDocumentsDirectory();
    Directory imageDirectory = await getApplicationDocumentsDirectory();
    String pathh = imageDirectory.path;
    String nomImage = basename(image.path);
    //print("name the image dans save");
    print(nomImage);

    // final newImage = await _imageFile.copy('${path}');

    newFile = await image.copy('$pathh/' + nomImage);
    //print("image dans res apres copy dans save");
    //print(basename(newFile.path));
    //print("path directory :");
    //print(newFile.path);

    // return newImage;
  }

  bool ajoutefilm(
    String string,
    String string2,
    String string3,
    String string4,
  ) {
    String url = "http://192.168.43.254:8080/ajouterfilm";
    http
        .post(Uri.parse(url),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "titre": string,
              "realisateur": string2,
              "description": string3,
              "duree": double.parse(string4),
              "photo": "fastandfarious",
            }),
            encoding: Encoding.getByName("utf-8"))
        .then((value) {
      if (!mounted) return;
      setState(() {
        print(value.statusCode);
        return true;
      });
    }).catchError((onError) {
      print(onError);
      return false;
    });
  }
}
