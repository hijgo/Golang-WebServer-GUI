import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gui/Resources/layout.dart';

class BottomBar extends StatefulWidget {
  final List<Widget>? buttons;
  const BottomBar({Key? key, this.buttons}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var constant = Layout(context: context).customTileWidth(.05, 15);
    return Padding(
        padding: EdgeInsets.fromLTRB(constant, 0, constant, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 18.0,
                spreadRadius: 3.0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:EdgeInsets.fromLTRB(constant, 0, 0, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Made by hijgo <3"),
                    ]),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.buttons!,
                  ),
                ),
            )
          ],
        ),
      )
    );
  }
}
