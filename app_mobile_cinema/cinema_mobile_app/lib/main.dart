import 'package:cinema_mobile_app/conteneur.dart';
import 'package:cinema_mobile_app/help=page.dart';
import 'package:cinema_mobile_app/login.dart';
import 'package:cinema_mobile_app/menuitem.dart';
import 'package:cinema_mobile_app/setting-page.dart';
import 'package:cinema_mobile_app/ville-list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blueAccent),
      ),
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final menus = [
    {'title': 'Home', 'icon': Icon(Icons.home), 'page': VilleList()},
    {'title': 'Pub', 'icon': Icon(Icons.help), 'page': HelpPage()},
    {'title': 'Setting', 'icon': Icon(Icons.settings), 'page': SettingPage()},
    {
      'title': 'Admin',
      'icon': Icon(Icons.admin_panel_settings),
      'page': Login()
    },
  ];
  @override
  Widget build(BuildContext context) {
    //scaffold est comme ecran si vous voulez mettre kelke chose il faut
    //utlise body le corp et appbar pour la barre d'ecran
    //var hauteur = MediaQuery.of(context).size.height;
    //var largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('App CinemaMagic',
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
      //dans body on utilise les widgets et chaque widget a un fils child
      //qui permet de contenir un autre widget
      body: SingleChildScrollView(child: Conteneur()),
      //drawer permet de spqcifier le menu principal a gauche en haut des bar d'outil
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
            ...this.menus.map((e) {
              return Column(
                children: [
                  Divider(
                    color: Colors.blue,
                  ),
                  MenuItem(e['title'], e['icon'], (context) {
                    //permet de ferme la page courante
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => e['page']));
                  }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
