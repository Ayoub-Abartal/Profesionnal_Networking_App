import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/dependency_injection.dart' as di;

import 'core/routes.dart';
import 'core/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final router = AppRouter();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      supportedLocales: supportedLocals,
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      onGenerateRoute: router.onGenerateRoute,
      initialRoute: '/new',
      theme: theme(),
    ),
  );
}
