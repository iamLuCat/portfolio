import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_color.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Container(width: 50, height: 3, color: AppColor.primary, margin: const EdgeInsets.only(top: 5))
      ],
    );
  }
}
