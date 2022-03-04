import 'package:cinema_mobile_app/ajouterfilm.dart';
import 'package:cinema_mobile_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<dynamic> listefilms;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Admin film',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              print('recherche');
            },
          ),
          IconButton(
            icon: Icon(Icons.facebook_sharp),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              print('facebook');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('./images/logo1.png'),
                  radius: 80.0,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.lightBlueAccent],
                ),
              ),
            ),
            // Text("Setting",
            //     style: Theme.of(context).textTheme.headline4.copyWith(
            //         color: Colors.blue[200], fontWeight: FontWeight.bold))
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(
                Icons.assignment_return,
                color: Colors.green,
                size: 37.0,
              ),
              label: Text(
                'Admin',
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.blue[200], fontWeight: FontWeight.bold),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AjouterFilm()));
              },
              icon: Icon(
                Icons.assignment_return,
                color: Colors.green,
                size: 37.0,
              ),
              label: Text(
                'Ajout',
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.blue[200], fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.white],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Application",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text("CineMagic",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Mis en jour de vos\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Champ\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      VerticalDivider(),
                      Flexible(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('./images/logo1.png'),
                          radius: 90.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.all(40.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Films",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 5.0, right: 5.0),
                                  height: 24.0,
                                  width: 24.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.white10)),
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 5.0, right: 5.0),
                                  height: 24.0,
                                  width: 24.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.white10)),
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.purpleAccent,
                                          shape: BoxShape.circle)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 5.0, right: 5.0),
                                  height: 24.0,
                                  width: 24.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.white10)),
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  if (this.listefilms != null)
                    Container(
                        width: size.width,
                        height: 1000.0,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: ListView.builder(
                            itemCount: this.listefilms == null
                                ? 0
                                : this.listefilms.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Card(
                                        child: Text(
                                          'Titre : ${this.listefilms[index]['titre']} Duree: ${this.listefilms[index]['duree']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        color: Colors.pink[200],
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 280.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                "http://192.168.43.254:8080/imagesfilm/${this.listefilms[index]['id']}"),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          'Description:${this.listefilms[index]['description']}')
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          print('Appel video');
                                        },
                                        icon: Icon(
                                          Icons.videocam,
                                          color: Colors.red,
                                          size: 37.0,
                                        ),
                                        label: Text(
                                          'Live',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 8.0,
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          print('Photo');
                                        },
                                        icon: Icon(
                                          Icons.photo_library,
                                          color: Colors.green,
                                          size: 37.0,
                                        ),
                                        label: Text(
                                          'Photo',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 8.0,
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          print('Appel video');
                                        },
                                        icon: Icon(
                                          Icons.video_call,
                                          color: Colors.purpleAccent,
                                          size: 37.0,
                                        ),
                                        label: Text(
                                          'Room',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 8.0,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          size: 37.0,
                                        ),
                                        onPressed: () {},
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            })),
                  Divider(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 50.0,
                        width: 58.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(color: Colors.white10)),
                        child: IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                            height: 50.0,
                            child: TextButton(
                              child: Text(
                                "Cette Page est Accessible juste au Admin"
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // qui s'execute au momment de l'initialisation de widget
    super.initState();
    loadfilm();
  }

  void loadfilm() {
    String url = "http://192.168.43.254:8080/films";
    http.get(Uri.parse(url)).then((value) {
      //https://cinemasaye.herokuapp.com
      //qui permet que un widget change d'etat au cours de sa vie (interaction)
      setState(() {
        listefilms = json.decode(value.body)['_embedded']['films'];
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
