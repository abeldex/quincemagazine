
import 'package:flutter/material.dart';
import 'package:quincemagazine/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quincemagazine/globals.dart' as globals;
import 'package:quincemagazine/revistadetail.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();  
}

class _HomePage extends State<HomePage> {
  
  
  var url = "http://revistaquince.000webhostapp.com/api.php?latest";

  Home home;
  List<EBOOKAPP> book;

  @override
  void initState() {
    super.initState();
    obtenerDatos();
    //print("Segunda tarea");
  }

  obtenerDatos() async {
    var res = await http.get(url);
    //print(res.body);
    var decodedJSON = jsonDecode(res.body);
    home = Home.fromJson(decodedJSON);
    //print(home.toJson());
    setState(() {
      book = home.eBOOKAPP.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    //drawe
    final lefdrawer = Drawer(
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
        );

    //app bar
    final appBar =AppBar(
          //Establecer el logo de la aplicacion
          title: Image.asset("assets/images/QuinceLogo.png", width: 280,),
          iconTheme: new IconThemeData(color: Colors.lightBlueAccent),
          backgroundColor: Colors.white,
        );

    createTile(book) => Hero(
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
        );

    ///create book grid tiles
    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 50.0,
            crossAxisSpacing: 50.0,
            children: home.eBOOKAPP.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      drawer: lefdrawer,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      
      body: Container(
        decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/librero.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
        child: home == null ? Center(child: CircularProgressIndicator(),) : grid),
    );
  }
}