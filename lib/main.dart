import 'package:flutter/material.dart';

import 'package:flutter_application_18/login.dart';

import 'package:flutter_application_18/theme_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeManager.currentTheme,
      home: const LoginPage(),
    );
  }
}
