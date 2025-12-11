import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_theme.dart' show AppTheme;
import 'main_layout.dart';

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pham Quang Vu Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainLayout(),
    );
  }
}
