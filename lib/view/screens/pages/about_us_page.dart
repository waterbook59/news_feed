import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  bool _status =false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed:() {
            setState(() {
              _status =!_status;
            });
          },
        ),
        body: Center(
          child: AnimatedContainer(
            alignment: _status ? Alignment.center : Alignment.topCenter,
            width: _status ? 300 : 50,
            height: _status ? 400 : 25,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 1000),
            child: AutoSizeText(
              "News Feed App",
              style: TextStyle(fontSize: 40.0),
              minFontSize: 6.0,
              maxLines: 1,//見せる行は１行だけ
              overflow: TextOverflow.visible,//containerからハミ出しても見せるvisible
            )

//            _status ? Text("News Feed App", style: TextStyle(fontSize: 40.0))
//                           : Text("News Feed App", style: TextStyle(fontSize: 10.0)),
          ),
        ),
      ),
    );
  }
}
