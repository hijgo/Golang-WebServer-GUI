import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gui/Resources/StreamMap/home_stream_map.dart';
import 'package:gui/screen/bloC/home_bloc.dart';
import 'package:gui/screen/event/home_event.dart';
import 'package:gui/screen/ui/update_ui.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloC _homeBloC = HomeBloC();

  @override
  void initState() {
    super.initState();
    _homeBloC.shopEventSink.add(CheckAvaiability());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _homeBloC.streamMap,
        initialData: HomeStreamMap(false),
        builder: (BuildContext context, AsyncSnapshot<HomeStreamMap> snapshot) {
          return DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 30,
                      elevation: 15,
                      title: const TabBar(
                        tabs: [
                          Center(child: SizedBox(height: 30,child: Icon(Icons.dns),)),
                          Center(child: SizedBox(height: 30,child: Icon(Icons.insights),)),
                          Center(child: SizedBox(height: 30,child: Icon(Icons.published_with_changes),)),
                          Center(child: SizedBox(height: 30,child: Icon(Icons.launch),)),
                        ],
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        Icon(Icons.dns),
                        Icon(Icons.insights),
                        Update(),
                        Icon(Icons.launch),
                      ],
                    ),
                  ),
                );
        }
      );
  }
}
