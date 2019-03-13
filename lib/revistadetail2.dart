import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_pdf_renderer/flutter_pdf_renderer.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quincemagazine/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RevistaDetail2 extends StatefulWidget  {
  final EBOOKAPP rev;
   RevistaDetail2({this.rev});
@override
  _RevistaDetail2 createState() => new _RevistaDetail2( rev: rev);
 
}

class _RevistaDetail2 extends State<RevistaDetail2> {
  final EBOOKAPP rev;

  //constructor para obtener la informacion de la revista seleccionada
  _RevistaDetail2({this.rev});
  bool downloading = false;
  var progressString = "";
   String pathPDF = "";
  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      final url = "${rev.bookFileUrl}";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      pathPDF = "${dir.path}/${filename}";
      await dio.download(url, "${dir.path}/${filename}",
        onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        //print(total);
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
}

Widget _buildContent(BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              _buildAvatar(),
              _buildInfo(context),
              
              /*WebView(
                initialUrl: 'https://flutter.io',
              ),*/
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
    
      Widget _buildInfo(BuildContext context) {
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
              Card(
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                    height: 350.0,
                    child: downloading
            ? Container(
                height: 120.0,
                width: 200.0,
                child: Card(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Cargando Revista: $progressString",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
: PdfRenderer(pdfFile: pathPDF, width: 500.0),
                    /*child: WebView(
                        initialUrl: "${rev.bookFileUrl}",
                        javaScriptMode: JavaScriptMode.unrestricted,
                    ),*/
            ),
              ),
               //_buildBottomNavigationBar(context),
              /*MaterialButton(onPressed: () {
               
              },
               highlightColor: Colors.transparent,
                        splashColor: Colors.pinkAccent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "Subscribirse",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "Arial"),
                          ),
              )
              ),*/
            ],
          ),
          
        );
        
      }
    
      _buildBottomNavigationBar(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                onPressed: ()  => pathPDF == "" ?   Alert(
                      context: context,
                      //type: AlertType.info,
                      title: "Descargando demo...",
                      desc: "Espere unos segundos por favor",
                      image: Image.network("http://190.107.23.94:807/BPM_Conservatorio/App_Themes/AzulCielo/Imagenes/procesando.gif", width: 50,),
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Muy bien!",
                            style: TextStyle(color: Colors.white, fontSize: 20,),
                          ),
                           onPressed: () => Navigator.pop(context),
                          width: 140,
                        ),
                       
                      ],
                    ).show() 
                    : Navigator.push(context,MaterialPageRoute(builder: (context) => PDFScreen(pathPDF, rev.bookTitle)),),
                color: Colors.lightBlue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "DEMO",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                onPressed: () {
                   //Navigator.pushReplacementNamed(context, '/CreditcardPage');
                    Alert(
                      context: context,
                      title: "Suscribirse a la revista?",
                      desc: "Para acceder a todo el contenido de la revista es necesario contar con una subscripcion",
                      image: Image.network("http://revistaquince.000webhostapp.com/images/${rev.bookBgImg}"),
                      buttons: [
                         DialogButton(
                          color: Colors.redAccent,
                          child: Text(
                            "Cancelar!",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 140,
                        ),
                        DialogButton(
                          child: Text(
                            "Suscribirme!",
                            style: TextStyle(color: Colors.white, fontSize: 20,),
                          ),
                          onPressed: () => Navigator.pushReplacementNamed(context, '/CreditcardPage'),
                          width: 140,
                        ),
                       
                      ],
                    ).show();
                },
                color: Colors.pinkAccent,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.local_library,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "SUBSCRIBIRSE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
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
                  child: _buildContent(context),     
                ),
              ),     
            ],
            
          ),
          
          bottomNavigationBar: _buildBottomNavigationBar(context),
        );
      }

}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
 String name = "";
  PDFScreen(this.pathPDF, this.name);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Demo: ${name}"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.local_library),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}
