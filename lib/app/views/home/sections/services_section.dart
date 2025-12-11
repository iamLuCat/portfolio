import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:portfolio/app/widgets/hover_border_container.dart';
import 'package:portfolio/core/localization/app_resources.dart';

class ServicesSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;

  const ServicesSection({super.key, required this.isDesktop, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.surface,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Quality Services",
            style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            AppResources.getString(langCode, 'section_services'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: isDesktop ? 30 : 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _serviceCard(context, FontAwesomeIcons.mobile, "Mobile App Dev", "Flutter & SwiftUI Apps"),
              _serviceCard(context, FontAwesomeIcons.server, "Backend Systems", "Spring Boot & AWS"),
              _serviceCard(context, FontAwesomeIcons.code, "Web Development", "Responsive Flutter Web"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(BuildContext context, IconData icon, String title, String sub) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 900 ? 300.0 : (width > 600 ? width / 2.2 : width - 40);

    return HoverBorderContainer(
      width: cardWidth,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: AppColor.primary),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(sub, style: TextStyle(color: AppColor.grey)),
          const SizedBox(height: 20),
          Icon(Icons.arrow_forward, color: AppColor.black),
        ],
      ),
    );
  }
}
