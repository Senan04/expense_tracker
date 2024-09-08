import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter/services.dart';

/*var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(206, 12, 192, 162));*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de_DE', null);
  // Um Rotation zu sperren:
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(
    MaterialApp(
      supportedLocales: const [
        Locale('de', 'DE'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: const Expenses(),
    ),
  );
}

//TODO
// - Anpassen, sodass Layout auf jedem Gerät stimmt !!!
// - Wenn auf Button geklickt, dann Liste filtern und Pie größer machen
// - IOS Style Widgets 
// - Farben anpassen
// - Neben dem Chart Kategorien Liste anzeigen 
// - Speichern 
// - ggf. nach Monaten sortiert und Chart Optionen geben nach Monaten zu filtern 
// - Einstellungen: DarkTheme/LightTheme/SystemTheme
// - Möglichkeit Kategorie nachtärglich zu ändern durch klick auf IconButton