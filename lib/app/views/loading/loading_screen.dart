import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app/config/app_color.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Vu Pham",
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0)
                .shimmer(duration: 1500.ms, color: AppColor.primary),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: AppColor.grey900,
                color: AppColor.primary,
                minHeight: 2,
              ),
            ).animate().scaleX(duration: 2000.ms, begin: 0, alignment: Alignment.centerLeft),
          ],
        ),
      ),
    );
  }
}
