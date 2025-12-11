import 'package:flutter/material.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:portfolio/app/config/app_color.dart';

class MobileDrawer extends StatelessWidget {
  final String langCode;
  final VoidCallback onHomeTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;

  const MobileDrawer({
    super.key,
    required this.langCode,
    required this.onHomeTap,
    required this.onSkillsTap,
    required this.onServicesTap,
    required this.onContactTap,
  });

  void _handleTap(BuildContext context, VoidCallback scrollAction) {
    Navigator.pop(context);
    scrollAction();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColor.primary),
            child: Center(
              child: Text(
                "Menu",
                style: TextStyle(color: AppColor.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppResources.getString(langCode, 'menu_home')),
            onTap: () => _handleTap(context, onHomeTap),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(AppResources.getString(langCode, 'menu_skills')),
            onTap: () => _handleTap(context, onSkillsTap),
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: Text(AppResources.getString(langCode, 'section_projects')),
            onTap: () => _handleTap(context, onServicesTap),
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: Text(AppResources.getString(langCode, 'menu_contact')),
            onTap: () => _handleTap(context, onContactTap),
          ),
        ],
      ),
    );
  }
}
