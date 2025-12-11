import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:portfolio/app/views/home/sections/recent_project_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/services_section.dart';
import 'sections/skill_and_exp_section.dart';
import 'widgets/desktop_nav_bar.dart';
import 'widgets/mobile_drawer.dart';
import 'widgets/mobile_nav_bar.dart';

class HomePage extends StatelessWidget {
  final String langCode;
  final VoidCallback onLanguageToggle;

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  HomePage({super.key, required this.langCode, required this.onLanguageToggle});

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.white,
      appBar: isDesktop
          ? DesktopNavBar(
              langCode: langCode,
              onHomeTap: () => _scrollToSection(homeKey),
              onSkillsTap: () => _scrollToSection(skillsKey),
              onServicesTap: () => _scrollToSection(servicesKey),
              onContactTap: () => _scrollToSection(contactKey),
            )
          : MobileNavBar(langCode: langCode, onMenuTap: () => scaffoldKey.currentState?.openEndDrawer()),
      endDrawer: !isDesktop
          ? MobileDrawer(
              langCode: langCode,
              onHomeTap: () => _scrollToSection(homeKey),
              onSkillsTap: () => _scrollToSection(skillsKey),
              onServicesTap: () => _scrollToSection(servicesKey),
              onContactTap: () => _scrollToSection(contactKey),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: onLanguageToggle,
        backgroundColor: AppColor.primary,
        mini: !isDesktop,
        child: Text(
          langCode.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: isDesktop ? 40 : 20),
            HeroSection(
              key: homeKey,
              isDesktop: isDesktop,
              langCode: langCode,
              scrollToContactSection: () => _scrollToSection(contactKey),
            ),
            SizedBox(height: isDesktop ? 80 : 50),
            SkillAndExpSection(key: skillsKey, isDesktop: isDesktop, langCode: langCode),
            SizedBox(height: isDesktop ? 80 : 50),
            RecentProjectSection(key: servicesKey, isDesktop: isDesktop, langCode: langCode),
            SizedBox(height: isDesktop ? 80 : 50),
            ContactSection(key: contactKey, isDesktop: isDesktop, langCode: langCode),
          ],
        ),
      ),
    );
  }
}
