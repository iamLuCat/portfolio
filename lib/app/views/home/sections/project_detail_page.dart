import 'package:flutter/material.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/app/widgets/subscription_card.dart';
import 'package:portfolio/core/localization/app_resources.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;
  final String langCode;

  const ProjectDetailPage({super.key, required this.project, required this.langCode});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;

    final List<dynamic> technologies = project.localizedTechnologies(langCode);
    final List<dynamic> responsibilities = project.localizedResponsibilities(langCode);
    final List<dynamic> platforms = project.localizedPlatforms(langCode);
    final String date = project.date;
    final int teamSize = project.teamSize;
    final localizedDesc = project.localizedDescription(langCode);

    // Detect flutter-related presence
    final bool isFlutterProject = technologies.any(
      (t) => t.toString().toLowerCase().contains('flutter') || t.toString().toLowerCase().contains('dart'),
    );

    // Extract flutter-related responsibilities (simple keyword match)
    final flutterKeywords = [
      'flutter',
      'ui',
      'plugin',
      'state',
      'riverpod',
      'getx',
      'bloc',
      'sqlite',
      'fastlane',
      'fcm',
      'ci',
      'deployment',
      'chat',
      'webrtc',
    ];
    final flutterResponsibilities = responsibilities.where((r) {
      final s = r.toString().toLowerCase();
      return flutterKeywords.any((k) => s.contains(k));
    }).toList();

    // Flutter-related technologies present
    final flutterTech = technologies.where((t) {
      final s = t.toString().toLowerCase();
      return ['flutter', 'dart', 'riverpod', 'getx', 'bloc', 'sqlite', 'fastlane', 'fcm'].any((k) => s.contains(k));
    }).toList();

    Widget metadataChip(IconData icon, String label) => Chip(
      avatar: Icon(icon, size: 16, color: AppColor.primary),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      backgroundColor: AppColor.surface,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.black),
        title: Text(project.localizedTitle(langCode), style: const TextStyle(color: AppColor.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmall ? 16 : 80, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  project.image,
                  width: double.infinity,
                  height: isSmall ? 200 : 360,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Title & role
              Text(
                project.localizedTitle(langCode),
                style: TextStyle(fontSize: isSmall ? 20 : 28, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      project.localizedRole(langCode),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColor.primary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (date.isNotEmpty) metadataChip(Icons.calendar_today, date),
                  if (teamSize > 0) ...[const SizedBox(width: 8), metadataChip(Icons.group, '${AppResources.getString(langCode, 'team')}: $teamSize')],
                ],
              ),

              const SizedBox(height: 16),

              // Overview (localized description)
              if (localizedDesc.isNotEmpty) ...[
                Text(
                  AppResources.getString(langCode, 'overview') ?? 'Overview',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(localizedDesc, style: const TextStyle(fontSize: 14, height: 1.6, color: AppColor.grey)),
                const SizedBox(height: 16),
              ],

              // Platforms
              if (platforms.isNotEmpty) ...[
                Text(
                  AppResources.getString(langCode, 'platforms') ?? 'Platforms',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: platforms.map((p) {
                    final lower = p.toString().toLowerCase();
                    IconData icon = Icons.device_unknown;
                    if (lower.contains('android')) icon = Icons.android;
                    if (lower.contains('ios')) icon = Icons.apple;
                    if (lower.contains('web')) icon = Icons.public;
                    return Chip(
                      avatar: Icon(icon, size: 16, color: AppColor.primary),
                      label: Text(p.toString()),
                      backgroundColor: AppColor.surface,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],

              // Technologies
              if (technologies.isNotEmpty) ...[
                Text(
                  AppResources.getString(langCode, 'technologies') ?? 'Technologies',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: technologies
                      .map((t) => Chip(label: Text(t.toString()), backgroundColor: AppColor.surface))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],

              // Responsibilities
              Text(
                AppResources.getString(langCode, 'responsibilities') ?? 'Responsibilities',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: responsibilities.map<Widget>((r) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 6, right: 10),
                          decoration: BoxDecoration(color: AppColor.primary, shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Text(
                            r.toString(),
                            style: const TextStyle(fontSize: 14, height: 1.6, color: AppColor.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Flutter-specific section
              if (isFlutterProject) ...[
                Text(
                  AppResources.getString(langCode, 'flutter_highlights') ?? 'Flutter-specific highlights',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
                const SizedBox(height: 8),
                if (flutterResponsibilities.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: flutterResponsibilities
                        .map<Widget>(
                          (r) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: const EdgeInsets.only(top: 6, right: 10),
                                  decoration: BoxDecoration(color: AppColor.primary, shape: BoxShape.circle),
                                ),
                                Expanded(
                                  child: Text(
                                    r.toString(),
                                    style: const TextStyle(fontSize: 14, height: 1.6, color: AppColor.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 8),
                if (flutterTech.isNotEmpty) ...[
                  Text(
                    AppResources.getString(langCode, 'flutter_tech'),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: flutterTech
                        .map((t) => Chip(label: Text(t.toString()), backgroundColor: AppColor.surface))
                        .toList(),
                  ),
                ],
              ],

              const SizedBox(height: 30),

              // Subscription / In-App Purchase card
              SubscriptionCard(project: project, langCode: langCode),
            ],
          ),
        ),
      ),
    );
  }
}
