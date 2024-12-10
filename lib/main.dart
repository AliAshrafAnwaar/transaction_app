import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:transaction_app/features/application.dart';
import 'package:transaction_app/test.dart';
import 'firebase_options.dart';
// add edit functionalites for both client details and for client transaction details
// Take a look about the responsive UI and how to use it

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Set Arabic as the default locale
  runApp(ProviderScope(
    child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: const [Locale('ar', 'AE')],
            home: Application())),
  ));
}

// void main() {
//   runApp(MaterialApp(home: MyApp()));
// }
