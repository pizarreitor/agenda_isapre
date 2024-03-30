import 'dart:ffi';

import 'package:agenda_isapre/locator.dart';
import 'package:agenda_isapre/main_page/main_state.dart';
import 'package:agenda_isapre/view/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:agenda_isapre/theme/color_schemes.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await setupLocator();
  runApp(Provider(create: (_) => MainState(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(      
          debugShowCheckedModeBanner: false,    
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('es'),
            ],
            title: 'TODO APP',
            theme: ThemeData(
              colorScheme: lightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            home: child, //const MainScreen(),
            );
      },
      child: const MainScreen(),
    );
  }
}
