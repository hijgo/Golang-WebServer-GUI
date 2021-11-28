import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gui/Resources/StreamMap/login_stream_map.dart';
import 'package:gui/Resources/UI/langauge_menu.dart';
import 'package:gui/Resources/layout.dart';
import 'package:gui/Resources/prop.dart';
import 'package:gui/screen/bloC/login_bloc.dart';
import 'package:gui/screen/event/login_event.dart';
import 'package:gui/screen/ui/home_ui.dart';
import 'package:i18n_plus/i18n.dart';
import 'package:i18n_plus/i18nText.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final LoginBloC _bloC = LoginBloC();
  final I18N _i18n = I18N();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _getInputWidget(String helperText) {
    return Center(
      child: SizedBox(
        width: Layout(context: context).customTileWidth(.45, 250),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 30.0,
                spreadRadius: 3.0,
                offset: const Offset(
                  10.0,
                  10.0,
                ),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                    child: I18NText(
                      i18nKey: "enterCred",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: SizedBox(height: 1,child: Container(color: Prop().customTheme.data.colorScheme.primary,),),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                  child: SizedBox(
                    width: Layout(context: context).customTileWidth(.35, 200),
                    height: 100,
                    child: TextField(
                      obscureText: true,
                      controller: _textEditingController,
                      onSubmitted: (String value) => {_bloC.shopEventSink.add(TryToLogin(value))},
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(width: 1.0),
                        ),
                        suffixIcon: const Icon(Icons.password),
                        labelText: _i18n.getI18nString("cred", null),
                        helperText: _i18n.getI18nString(helperText, null),
                        helperStyle: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,0,0,0),
                  child: TextButton(
                    style: ElevatedButton.styleFrom(elevation: 5,primary: Prop().customTheme.data.colorScheme.primary,shadowColor: Colors.black),
                    child: const SizedBox(height: 50,child: Center(child: I18NText(i18nKey: "enter",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),))),
                    onPressed: () {
                      _bloC.shopEventSink.add(TryToLogin(_textEditingController.text));
                    },
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Prop().customTheme.data.colorScheme.primary,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text(""),
              const Text("Admin-Panel",style: TextStyle(fontWeight: FontWeight.bold)),
              LangaugeMenu((Locale? language)=>{_bloC.shopEventSink.add(SetLanguage(language!))})]
            ),
          ),
      ),
      body: StreamBuilder(
          stream: _bloC.streamMap,
          initialData: LogInStreamMap(LogInState.noChallenge),
          builder:(BuildContext context, AsyncSnapshot<LogInStreamMap> snapshot) {
            switch (snapshot.data!.logInState) {
              case LogInState.noChallenge:
                return _getInputWidget("empty");
              case LogInState.notAvailable:
                return _getInputWidget("serverN/A");
              case LogInState.unSuccesfullChallenge:
                return _getInputWidget("falseCred");
              case LogInState.succesfulChallenge:
                return const Home();
            }
          }),
    );
  }
}
