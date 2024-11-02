import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transaction_app/features/home/home.dart';

void main() {
  runApp(Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: [Locale('ar', 'AE')],
          home: HomeScreen())));
}
