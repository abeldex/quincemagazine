import 'package:flutter/material.dart';
import 'package:quincemagazine/home.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class RevistaDetail extends StatelessWidget {

  final EBOOKAPP rev;

  //constructor para obtener la informacion de la revista seleccionada
  RevistaDetail({this.rev});

  bodyWidget(BuildContext context)=>Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width-20.0,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 50.00,
              ),
              Text(rev.bookTitle, style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold, color: Colors.blue),),
              Html(
                  data: rev.bookDescription
              ),
              FilterChip(
                  label: Text("Visitas: ${rev.bookViews}")
              ),
            ],
          ),
        ),
      ),

      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: rev.bookBgImg, child: Container(
          height: 200,
          width: 170,
          decoration: BoxDecoration(

            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("http://revistaquince.000webhostapp.com/images/${rev.bookBgImg}"))
          ),
        ),

        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rev.bookTitle, style: TextStyle(color: Colors.pinkAccent,)),
        iconTheme: new IconThemeData(color: Colors.lightBlueAccent),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chrome_reader_mode),
            tooltip: 'Visualizar',
          )
        ],
      ),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: bodyWidget(context) /* add child content here */,
      ),
    );
  }
}
