import 'package:flutter/material.dart';
import 'package:quincemagazine/login_page.dart';
import 'package:quincemagazine/member_page.dart';
import 'package:quincemagazine/ui/page/HomePage.dart';
import 'package:quincemagazine/ui/page/RevistasCollection.dart';
import 'package:quincemagazine/ui/page/credit_card_page.dart';
import 'package:quincemagazine/ui/page/payment_success_page.dart';

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
      //home: new StampCollectionPage(),
      routes: <String,WidgetBuilder>{
        '/MemberPage': (BuildContext context)=> new QuinceMagazineHome(),
        '/LoginPage': (BuildContext context)=> new LoginPage(),
        '/CreditcardPage': (BuildContext context)=> new CreditCardPage(),
        '/PaymentSuccessPage': (BuildContext context)=> new PaymentSuccessPage(),
        '/RevistasPage': (BuildContext context)=> new RevistasPage(),
      }
    );
  }
}





