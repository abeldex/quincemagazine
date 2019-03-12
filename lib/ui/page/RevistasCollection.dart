import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quincemagazine/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quincemagazine/globals.dart' as globals;


class RevistasPage  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _StampCollectionPageState();

}


class _StampCollectionPageState extends StampCollectionPageAbstractState<RevistasPage> {

  @override
  Widget build(BuildContext context) {

    Matrix4 transform = new Matrix4.skewX(10.0);
    transform.translate(-100.0);
    return new Scaffold(
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
      body: new ListView.builder(itemBuilder: (BuildContext context, int index){
        return new BookCardCompact(items[index], onClick: (){},);
      },
      itemCount: items.length,
      ),
    );
  }


}

abstract class StampCollectionPageAbstractState<T extends StatefulWidget> extends State<T> {

  var url = "http://revistaquince.000webhostapp.com/api.php?latest";

  Home home;

  List<EBOOKAPP> items = new List();
  
  @override
  void initState() {
    super.initState();
    ObtenerDatos();
    //print("Segunda tarea");
  }

  ObtenerDatos() async {
    var res = await http.get(url);
    var decodedJSON = jsonDecode(res.body);
    home = Home.fromJson(decodedJSON);
    //print(home.toJson());
    setState(() {
       items = home.eBOOKAPP;
    });
  }



}

class BookCardCompact extends StatelessWidget {


  BookCardCompact(this.book, {@required this.onClick});

  final EBOOKAPP book;

  final VoidCallback onClick;


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap : onClick,
      child: new Container(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Hero(child: new Image.network("http://revistaquince.000webhostapp.com/images/${book.bookBgImg}", height: 150.0, width: 100.0,), tag: book.id,),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(top : 8.0, left: 24.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(book.bookTitle, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0), overflow: TextOverflow.ellipsis, maxLines: 2,),
                          new SizedBox(height: 4.0,),
                          new Text(book.categoryName),
                       //   new SizedBox(height: 8.0,),
                      //    new Text(_short(book.subtitle, 30)),
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(width: 16.0,)
                ],
              ),
              new Divider(color: Colors.black38, indent: 128.0,),
            ],
          ),
        ),
      ),
    );
  }



  String _short(String title, int targetLength) {
    var list = title.split(" ");
    int buffer = 0;
    String result = "";
    bool showedAll = true;
    for(String item in list) {
      if(buffer + item.length <= targetLength) {
        buffer += item.length;
        result += item += " ";
      } else {
        showedAll = false;
        break;
      }
    }
    //Handle case of one very long word
    if(result == "" && title.length > 18) {
      result = title.substring(0, 18);
      showedAll = false;
    }

    if(!showedAll) result += "...";
    return result;
  }
}