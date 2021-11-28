import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gui/Resources/prop.dart';
import 'package:i18n_plus/i18n.dart';

class LangaugeMenu extends StatefulWidget {
  final void Function(Locale?) onChanged;
  const LangaugeMenu(this.onChanged,{Key? key}) : super(key: key);

  @override
  _LangaugeMenuState createState() => _LangaugeMenuState();
}

class _LangaugeMenuState extends State<LangaugeMenu> {
  @override
  Widget build(BuildContext context) {
    return Theme(
          data: Theme.of(context).copyWith(canvasColor: const Color(0xFFEEEEEE)),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: Prop().customTheme.data.colorScheme.primary,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: DropdownButton<Locale>(
                value: I18N().currentLocale.value,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Prop().customTheme.data.colorScheme.secondary,
                ),
                iconSize: 18,
                underline: const SizedBox(),
                onChanged: (Locale? newValue) {
                  widget.onChanged(newValue);
                },
                items: I18N().allLocale()!.map<DropdownMenuItem<Locale>>((Locale value) {
                  return DropdownMenuItem<Locale>(
                    value: value,
                    child: Text(
                      value.countryCode!,
                      style: TextStyle(
                      fontSize: 18,
                      color: Prop()
                          .customTheme
                          .data
                          .colorScheme
                          .secondary),
                    ),
                  );
                }).toList()),
          ));
    }
}