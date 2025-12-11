import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:portfolio/app/config/app_color.dart';

class DesktopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String langCode;
  final VoidCallback onHomeTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;

  const DesktopNavBar({
    super.key,
    required this.langCode,
    required this.onHomeTap,
    required this.onSkillsTap,
    required this.onServicesTap,
    required this.onContactTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      height: 80,
      color: AppColor.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Vu Pham", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            children: [
              _navItem(AppResources.getString(langCode, 'menu_home'), onHomeTap),
              _navItem(AppResources.getString(langCode, 'menu_skills'), onSkillsTap),
              _navItem(AppResources.getString(langCode, 'section_projects'), onServicesTap),
              _navItem(AppResources.getString(langCode, 'menu_contact'), onContactTap),
            ],
          ),
          ElevatedButton(
            onPressed: onContactTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.black,
              foregroundColor: AppColor.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            ),
            child: const Text("Hire Me"),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    ),
  );
}
