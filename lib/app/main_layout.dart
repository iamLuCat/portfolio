import 'package:flutter/material.dart';
import 'views/home/home_page.dart';
import 'views/loading/loading_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isLoading = true;
  String _langCode = 'vi';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  void _toggleLanguage() {
    setState(() => _langCode = _langCode == 'vi' ? 'en' : 'vi');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _isLoading
          ? const LoadingScreen(key: ValueKey('loader'))
          : HomePage(
        key: const ValueKey('home'),
        langCode: _langCode,
        onLanguageToggle: _toggleLanguage,
      ),
    );
  }
}

