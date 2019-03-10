import 'package:flutter/material.dart';
//importar la paqueteria para interactuar con KSON
import 'package:http/http.dart' as http;
import 'package:quincemagazine/home.dart';
import 'dart:convert';

import 'package:quincemagazine/revistadetail.dart';

void main() => runApp(MaterialApp(
  title: 'Quinceanera Magazine App',
  home: QuinceMagazineHome(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.pink,

  ),
));

class QuinceMagazineHome extends StatefulWidget {
  @override
  _QuinceMagazineHomeState createState() => _QuinceMagazineHomeState();
}

class _QuinceMagazineHomeState extends State<QuinceMagazineHome> {

  var url = "http://revistaquince.000webhostapp.com/api.php?latest";

  Home home;

  @override
  void initState() {
    super.initState();
    ObtenerDatos();
    //print("Segunda tarea");
  }

  ObtenerDatos() async {
    var res = await http.get(url);
    //print(res.body);
    var decodedJSON = jsonDecode(res.body);
    home = Home.fromJson(decodedJSON);
    print(home.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //return Container(color:Colors.deepPurple);
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Usuario"),
                accountEmail: new Text("email@domain.com"),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/login_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://facite.uas.edu.mx/alumnos/images/default.png")),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text('Inicio'),
                selected: true,
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: Text('Categorias'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.format_list_numbered),
                title: Text('Ediciones'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.local_library),
                title: Text('Revistas'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Perfil'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Acerca de'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },

              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.lightBlueAccent),
                title: Text('Salir'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          //Establecer el logo de la aplicacion
          title: Image.asset("assets/images/QuinceLogo.png", width: 280,),
          iconTheme: new IconThemeData(color: Colors.lightBlueAccent),
          backgroundColor: Colors.white,
        ),
        body: home == null ? Center(child: CircularProgressIndicator(),) :
            new Container(
            decoration: new BoxDecoration(
            image: new DecorationImage(
            image: new AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
            ),
            ),
          child:GridView.count(
          crossAxisCount: 2,

          children: home.eBOOKAPP.map((revista)=> Padding(
          padding: const EdgeInsets.all(5.0),
            child:InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RevistaDetail(
                    rev: revista,
                )));
              },
              child: Hero(
                tag: revista.bookBgImg,
                child: Card(
                  elevation: 3.0,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("http://revistaquince.000webhostapp.com/images/"+revista.bookBgImg))),
                    ),
                    Text(revista.bookTitle, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),)
                  ],
                )
          ),
              ),
            ))).toList(),
          ),
            ),
        floatingActionButton: FloatingActionButton(onPressed: (){},
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.refresh),
        ),
    );
  }
}




