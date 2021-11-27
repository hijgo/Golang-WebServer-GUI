import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gui/screen/bloC/home_bloc.dart';
import 'package:gui/screen/event/home_event.dart';

class Home extends StatefulWidget {
  const Home(this.title,{ Key? key }) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloC _homeBloC = HomeBloC();
  final _defaultUrl = "http://127.0.0.1:4545";
  
  @override
  void initState() {
    super.initState();
    _homeBloC.shopEventSink.add(CheckAvaiability(_defaultUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(widget.title),
      ),
      body: Container(),
    );
  }
}