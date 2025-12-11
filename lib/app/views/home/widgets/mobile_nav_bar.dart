import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String langCode;
  final VoidCallback onMenuTap;

  const MobileNavBar({super.key, required this.langCode, required this.onMenuTap});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        "Vu Pham",
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: onMenuTap,
        ),
      ],
    );
  }
}
