
import 'package:cinema_mobile_app/main.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pub',
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
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Flexible(
                child: Icon(
                  Icons.assignment_return,
                  color: Colors.green,
                  size: 37.0,
                ),
              ),
              label: Text(
                'Pub',
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.blue[200], fontWeight: FontWeight.bold),
              ),
            ),
            // TextButton.icon(
            //   onPressed: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => MyApp()));
            //   },
            //   icon: Icon(
            //     Icons.assignment_return,
            //     color: Colors.green,
            //     size: 37.0,
            //   ),
            //   label: Text(
            //     'Pub',
            //     style: Theme.of(context).textTheme.headline4.copyWith(
            //         color: Colors.blue[200], fontWeight: FontWeight.bold),
            //   ),
            // ),
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
                    "le meilleur est",
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
                              text: "Venez Chez\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " Nous Avec\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "des pop-corne Gratuit",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      Flexible(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('./images/pop.png'),
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
                            Text("24h/24",
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
                      Expanded(
                        child: Text("7/7 Que nous offrons nos service",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Divider(),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Au Cin?? Magic, le divertissement est notre priorit?? pour nos clients\n Nous offrons des pop-corns et plein d'autres surprises ?? chaque achat suppl??mentaire. Consulter l'application en permanence car les meilleur film son toujour projster afin de vous satistafaire si vous voulez d'autre information contacter nous notre contact telephonique ou mail car nous somme la pour vous satisfaire. Merci et passe un excellence journee\n",
                      style: TextStyle(height: 2.5, color: Colors.black),
                    ),
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
                                "Utilisez notre App sur vos Smart Phone  773187047"
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
}
