import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gui/Resources/prop.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gui/screen/ui/log_in_ui.dart';
import 'package:i18n_plus/i18n.dart';
import 'package:i18n_plus/i18nLanguageset.dart';
import 'package:i18n_plus/i18nMap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setI18N();
  runApp(const GUI());
}

class GUI extends StatelessWidget {
  const GUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale("de", "DE"), Locale("en", "EN")],
      debugShowCheckedModeBanner: false,
      theme: Prop().customTheme.data,
      title: 'GolangWebServer-GUI',
      home: const LogIn(),
    );
  }
}

Future<void> setI18N() async {
  I18N i18n = I18N();
  List<Langaugeset> languagesets = [
    Langaugeset.fromJsonString(const Locale("en", "EN"),
        await rootBundle.loadString("assets/languagesets/en.json")),
          Langaugeset.fromJsonString(const Locale("de", "DE"),
        await rootBundle.loadString("assets/languagesets/de.json"))
  ];
  i18n.seti18nMap(I18NMap(languagesets));
}
