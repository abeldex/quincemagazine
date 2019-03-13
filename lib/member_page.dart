import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quincemagazine/home.dart';
import 'package:quincemagazine/revistadetail.dart';
import 'package:quincemagazine/revistadetail2.dart';
import 'globals.dart' as globals;


class QuinceMagazineHome extends StatefulWidget {
  @override
  _QuinceMagazineHomeState createState() => _QuinceMagazineHomeState();
}

class _QuinceMagazineHomeState extends State<QuinceMagazineHome> {
  
  _QuinceMagazineHomeState({this.username});

  final String username;
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
    //print(home.toJson());
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
                accountName: new Text("${globals.username.toUpperCase()}"),
                accountEmail: new Text("${globals.email.toLowerCase()}"),
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
                  Navigator.pushReplacementNamed(context, '/RevistasPage');
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
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/LoginPage');
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
                    image: new ExactAssetImage('assets/images/librero.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                 child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(10.0),
                      
                      sliver: SliverGrid.count(
                        childAspectRatio: 2 / 3,
                        crossAxisCount: 4,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 12.0,
                        children: home.eBOOKAPP.map((book) => Hero(
                            tag: book.bookTitle,
                            
                            child: Material(
                              
                              elevation: 10.0,
                              shadowColor: Colors.pink.shade900,
                              
                              child: InkWell(
                                
                                onTap: () {
                                  //Navigator.pushNamed(context, 'detail/${book.id}');
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RevistaDetail(
                                      rev: book,
                                  )));
                                },
                                child: Image(
                                  image: NetworkImage("http://revistaquince.000webhostapp.com/images/${book.bookBgImg}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )).toList(),
                      ),
                    )
                  ],
                ),     
            ),
        floatingActionButton: FloatingActionButton(onPressed: (){},
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.refresh),
        ),
    );
  }
}

