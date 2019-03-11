import 'package:flutter/material.dart';
import 'package:quincemagazine/home.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:ui' as ui;

class RevistaDetail extends StatelessWidget {

  final EBOOKAPP rev;

  //constructor para obtener la informacion de la revista seleccionada
  RevistaDetail({this.rev});

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          //_buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30),
      ),
      margin: const EdgeInsets.only(top: 32.0, left: 16.0),
      padding: const EdgeInsets.all(3.0),
      child: ClipOval(
        child: Image.network("http://revistaquince.000webhostapp.com/images/${rev.bookBgImg}"),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            rev.bookTitle ,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Text(
            rev.categoryName,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: 225.0,
            height: 1.0,
          ),
          Html(
                  data: rev.bookDescription,
                  defaultTextStyle: TextStyle( color: Colors.white.withOpacity(0.85),
              height: 1.4, fontSize: 16),
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network("http://revistaquince.000webhostapp.com/images/${rev.bookBgImg}", fit: BoxFit.cover),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }
  /*bodyWidget(BuildContext context)=>Stack(
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
  );*/

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rev.bookTitle, style: TextStyle(color: Colors.pinkAccent,)),
        iconTheme: new IconThemeData(color: Colors.lightBlueAccent),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: bodyWidget(context),
      ),
    );
}*/



}
