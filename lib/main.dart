import 'package:flutter/material.dart';
//importar la paqueteria para interactuar con KSON
import 'package:quincemagazine/login_page.dart';
import 'package:quincemagazine/member_page.dart';
import 'globals.dart' as globals;

/*void main() => runApp(MaterialApp(
  title: 'Quinceanera Magazine App',
  home: QuinceMagazineHome(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.pink,

  ),
));
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Quinceanera Magazine',
     theme: ThemeData(
        primaryColor: Colors.pink,
        
      ),
      home: new LoginPage(),
      routes: <String,WidgetBuilder>{
        '/MemberPage': (BuildContext context)=> new QuinceMagazineHome(),
        '/LoginPage': (BuildContext context)=> new LoginPage(),
      }
    );
  }
}





