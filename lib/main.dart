import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/features/application.dart';
import 'package:transaction_app/test.dart';

// put the date parameter in the transaction
// put the conditions to check number and user in the register

void main() {
<<<<<<< HEAD
  // Set Arabic as the default locale
=======
>>>>>>> e180a4a2becf3ae03585083cede5fad5ec347ca9
  runApp(ProviderScope(
    child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: [Locale('ar', 'AE')],
            home: Application())),
  ));
}

// void main() {
<<<<<<< HEAD
//   runApp(MaterialApp(home: MyApp()));
=======
//   runApp(MaterialApp(home: FilePickerDemo()));
>>>>>>> e180a4a2becf3ae03585083cede5fad5ec347ca9
// }
