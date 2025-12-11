import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app/widgets/dashed_circle_painter.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;
  final VoidCallback scrollToContactSection;

  const HeroSection({super.key, required this.isDesktop, required this.langCode, required this.scrollToContactSection});

  @override
  Widget build(BuildContext context) {
    final padding = isDesktop ? 100.0 : 20.0;

    Widget profileImage = SizedBox(
      width: isDesktop ? 400 : 250,
      height: isDesktop ? 400 : 250,
      child: CustomPaint(
        painter: DashedCirclePainter(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/images/avatar.jpg'), fit: BoxFit.cover),
            ),
          ),
        ),
      ).animate().scale(delay: 500.ms, duration: 800.ms, curve: Curves.elasticOut));

    Widget textContent = Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          AppResources.getString(langCode, 'hello'),
          style: const TextStyle(color: AppColor.primary, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          "PHAM QUANG VU",
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.poppins(fontSize: isDesktop ? 48 : 32, fontWeight: FontWeight.bold, height: 1.1),
        ),
        Text(
          AppResources.getString(langCode, 'role').toUpperCase(),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: GoogleFonts.poppins(fontSize: isDesktop ? 24 : 16, fontWeight: FontWeight.w300, letterSpacing: 2),
        ),
        const SizedBox(height: 20),
        Text(
          AppResources.getString(langCode, 'intro'),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: const TextStyle(color: AppColor.grey, fontSize: 15, height: 1.6),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: scrollToContactSection,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              ),
              child: Text(AppResources.getString(langCode, 'contact_send')),
            ),
            const SizedBox(width: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _socialIcon(FontAwesomeIcons.github, "https://github.com/iamLuCat"),
                _socialIcon(FontAwesomeIcons.linkedinIn, "https://www.linkedin.com/in/vupq06/"),
              ],
            ),
          ],
        ),
      ],
    ).animate().fade(delay: 800.ms).slideX(begin: 0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileImage,
                const SizedBox(width: 50),
                Expanded(child: textContent),
              ],
            )
          : Column(children: [profileImage, const SizedBox(height: 30), textContent]),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);

    // Use webOnlyWindowName: '_blank' to open in a new tab on web
    // On other platforms, this parameter is ignored.
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    )) {
      throw Exception('Could not launch $url');
    }
  }


  MouseRegion _socialIcon(IconData icon, String s) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchURL(s),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(icon, color: AppColor.black87, size: 20),
        ),
      ),
    );
  }
}
