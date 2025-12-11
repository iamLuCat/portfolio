import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/core/localization/app_resources.dart';

class SubscriptionCard extends StatelessWidget {
  final Project project;
  final String langCode;
  const SubscriptionCard({super.key, required this.project, this.langCode = 'en'});

  @override
  Widget build(BuildContext context) {
    final hasPlans = project.subscriptionPlans.isNotEmpty;
    final hasBilling = project.billingProviders.isNotEmpty;

    if (!project.inAppPurchase && !hasPlans && !hasBilling) {
      return const SizedBox.shrink();
    }

    return Card(
      color: AppColor.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_bag, color: AppColor.primary),
                const SizedBox(width: 8),
                Text(AppResources.getString(langCode, 'in_app_purchases_title'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.textPrimary)),
              ],
            ),
            const SizedBox(height: 12),
            if (hasPlans) ...[
              Text(AppResources.getString(langCode, 'available_plans'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
              const SizedBox(height: 8),
              Column(
                children: project.localizedSubscriptionPlans(langCode).map((plan) {
                   final name = plan.localizedName(langCode).isNotEmpty ? plan.localizedName(langCode) : AppResources.getString(langCode, 'available_plans');
                   final price = plan.price;
                   return ListTile(
                     contentPadding: EdgeInsets.zero,
                     title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                     subtitle: price.isNotEmpty ? Text('\$${price.toString()}') : null,
                   );
                 }).toList(),
               ),
              const SizedBox(height: 12),
            ],

            if (hasBilling) ...[
              Text(AppResources.getString(langCode, 'billing_providers'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: project.billingProviders.map((b) => Chip(label: Text(b), backgroundColor: AppColor.white)).toList(),
              ),
              const SizedBox(height: 12),
            ],

            if (project.integrations.isNotEmpty) ...[
              Text(AppResources.getString(langCode, 'health_integrations'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: project.integrations.map((i) => Chip(label: Text(i), backgroundColor: AppColor.white)).toList()),
            ],
          ],
        ),
      ),
    );
  }
}
