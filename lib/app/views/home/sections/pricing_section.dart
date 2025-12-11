import 'package:flutter/material.dart';
import 'package:portfolio/app/widgets/hover_border_container.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:portfolio/app/config/app_color.dart';

class PricingSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;

  const PricingSection({super.key, required this.isDesktop, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            AppResources.getString(langCode, 'section_pricing'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: isDesktop ? 30 : 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _pricingCard(context, AppResources.getString(langCode, 'price_basic'), "\$25", "/Hour", [
                "Bug Fixing",
                "Consultation",
              ], false),
              _pricingCard(context, AppResources.getString(langCode, 'price_std'), "\$2k+", "/Project", [
                "Full App Dev",
                "Backend Setup",
              ], true),
              _pricingCard(context, AppResources.getString(langCode, 'price_pre'), "Neg.", "/Month", [
                "Dedicated Dev",
                "Maintenance",
              ], false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pricingCard(
    BuildContext context,
    String title,
    String price,
    String unit,
    List<String> features,
    bool isPopular,
  ) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 900 ? 300.0 : (width - 40);

    return HoverBorderContainer(
      width: cardWidth,
      padding: const EdgeInsets.all(30),
      isPopular: isPopular,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: isPopular ? AppColor.white : AppColor.black, fontSize: 16)),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: TextStyle(color: AppColor.primary, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: unit,
                  style: TextStyle(color: isPopular ? AppColor.grey300 : AppColor.black54, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColor.primary, size: 18),
                  const SizedBox(width: 10),
                  Text(f, style: TextStyle(color: isPopular ? AppColor.grey300 : AppColor.black54)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: isPopular ? AppColor.white : AppColor.black),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text("Order Now", style: TextStyle(color: isPopular ? AppColor.white : AppColor.black)),
            ),
          ),
        ],
      ),
    );
  }
}
