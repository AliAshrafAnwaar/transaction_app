import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/features/application.dart';
// put the date parameter in the transaction
// put the conditions to check number and user in the register

void main() {
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
