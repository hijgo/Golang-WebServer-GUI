import 'package:flutter/material.dart';
import 'package:gui/Resources/StreamMap/update_stream_map.dart';
import 'package:gui/Resources/UI/bottom_bar.dart';
import 'package:gui/Resources/UI/custom_textfield.dart';
import 'package:gui/Resources/UI/main_page.dart';
import 'package:gui/Resources/prop.dart';
import 'package:gui/screen/bloC/update_bloc.dart';
import 'package:gui/screen/event/update_event.dart';
import 'package:i18n_plus/i18n.dart';
import 'package:i18n_plus/i18nText.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final UpdateBloC _updateBloC = UpdateBloC();
  final I18N _i18n = I18N();
  final TextEditingController _fSize = TextEditingController(),_fName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _updateBloC.streamMap,
        initialData: UpdateStreamMap(null, null, null, null, TextEditingController(), null),
        builder: (BuildContext context, AsyncSnapshot<UpdateStreamMap> snapshot) {
          _fName.text = snapshot.data!.fName != null ? snapshot.data!.fName! : "";
          _fSize.text = snapshot.data!.fSize.toString();
          return MainPage(
              error: snapshot.data!.error,
              content: Wrap(
                direction: Axis.horizontal,
                children: [
                  ValueListenableBuilder(
                      builder: (BuildContext context, Locale? value, Widget? child) {
                        return CustomTextField(
                          tall: true,
                          isChecked: true,
                          onTouch: null,
                          icon: Icons.link,
                          min: 250,
                          percentage: .15,
                          lable: _i18n.getI18nString("destination", null),
                          textEdit: snapshot.data!.destController,
                        );
                      },
                      valueListenable: _i18n.currentLocale,
                      child: null),
                  CustomTextField(
                    tall: true,
                    isChecked: true,
                    icon: Icons.description,
                    min: 250,
                    changeable: false,
                    onTouch: null,
                    percentage: .15,
                    lable: _i18n.getI18nString("fileName", null),
                    textEdit: _fName,
                  ),
                  CustomTextField(
                    tall: true,
                    isChecked: true,
                    icon: Icons.description,
                    min: 250,
                    changeable: false,
                    onTouch: null,
                    percentage: .15,
                    lable: _i18n.getI18nString("fileSize", null),
                    textEdit: _fSize,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: RawMaterialButton(
                      child: Icon(
                        Icons.folder_open,
                        color: Prop().customTheme.data.colorScheme.secondary,
                      ),
                      elevation: 2.0,
                      fillColor: Prop().customTheme.data.colorScheme.primary,
                      padding: const EdgeInsets.all(10.0),
                      onPressed: () => _updateBloC.shopEventSink.add(PickZip()),
                    ),
                  ),
                ],
              ),
              bottomBar: BottomBar(
                buttons: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: OutlinedButton(
                      child: I18NText(
                        i18nKey: "reqUpdate",
                        style: TextStyle(
                          color: Prop().customTheme.data.colorScheme.primary),
                      ),
                      onPressed: () =>_updateBloC.shopEventSink.add(UpdateRequest()),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        side: BorderSide(
                            color: Prop().customTheme.data.colorScheme.primary,
                            style: BorderStyle.solid,
                            width: 2.5),
                      ),
                    ),
                  ),
                ],
              ),
              title: "updateWA");
        });
  }
}
