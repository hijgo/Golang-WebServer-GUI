import 'package:gui/Resources/UI/progress_indicator.dart' as custom;
import 'package:gui/Resources/layout.dart';
import 'package:gui/Resources/prop.dart';
import 'package:i18n_plus/i18nText.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String title;
  final List<Widget>? btn;
  final Widget content;
  final Widget? bottomBar;
  final Color? bgColor;
  final String? error;
  final bool showProgressIndicator;
  final List<custom.ProgressStep>? progressSteps; 
  final int? currentProgressSteps;
  const MainPage({
      required this.content,
      required this.title,
      this.showProgressIndicator = false,
      this.btn,
      this.bottomBar,
      this.bgColor,
      this.error, this.progressSteps, this.currentProgressSteps,GlobalKey? key}): super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> widgetsBtn = [];
  Color? bgColor;

  createWidgets() {
    widget.bgColor == null
        ? bgColor = Colors.transparent
        : bgColor = widget.bgColor;
    if (widget.btn != null) {
      for (var widget in widget.btn!) {
        widgetsBtn.add(widget);
      }
    } else {
      widgetsBtn = [];
    }
  }

  @override
  void initState() {
    super.initState();
    createWidgets();
  }

  @override
  Widget build(BuildContext context) {
    var _const = Layout(context: context).customTileWidth(.05, 15);
    return Container(
        color: Colors.transparent,
        width: Layout(context: context).customTileWidth(1, 500),
        child: Stack(children: [
          Positioned.fill(
              top: 5,
              child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(_const, 20, _const, 75),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300]!,
                                blurRadius: 20.0,
                                spreadRadius: 8.0,
                                offset: const Offset(0, 10))
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [!widget.showProgressIndicator?Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: I18NText(
                                                i18nKey: widget.title,
                                                style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                  color: Prop().customTheme.data.colorScheme.primary,
                                                ),
                                              ),
                                      ):Container(),Expanded(
                                        child: widget.showProgressIndicator? custom.ProgressIndicator(widget.progressSteps!,widget.currentProgressSteps!):Container(),
                                      )]
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: I18NText(
                                              i18nKey: widget.error == null || widget.error == ""? "empty":widget.error!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Prop().customTheme.data.colorScheme.primary,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    padding: const EdgeInsets.all(35),
                                    child: widget.content),
                              ),
                            ]),
                      ),
                    ),
                  ])))),
          Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      height: 73,
                      child: widget.bottomBar)))
        ]));
  }
}
