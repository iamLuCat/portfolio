import 'package:flutter/material.dart';
import 'package:portfolio/app/widgets/hover_border_container.dart';
import 'package:portfolio/app/widgets/section_title.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:portfolio/data/datasources/static_data.dart';
import 'package:portfolio/app/config/app_color.dart';
import 'package:portfolio/data/models/experience.dart';

class SkillAndExpSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;

  const SkillAndExpSection({super.key, required this.isDesktop, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. SKILLS GRID
          Center(child: SectionTitle(title: AppResources.getString(langCode, 'section_skills'))),
          const SizedBox(height: 40),

          LayoutBuilder(
            builder: (context, constraints) {
              // Determine columns based on available width and the isDesktop flag.
              final maxWidth = constraints.maxWidth;
              final int crossAxisCount;
              if (isDesktop) {
                crossAxisCount = 3;
              } else if (maxWidth >= 900) {
                crossAxisCount = 3;
              } else if (maxWidth >= 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              // Grid spacing values (keep in sync with the GridView delegate)
              const double crossAxisSpacing = 20;
              const double mainAxisSpacing = 20;

              // Compute the approximate card width available for each column.
              final double totalSpacing = (crossAxisCount - 1) * crossAxisSpacing;
              final double cardWidth = (maxWidth - totalSpacing) / crossAxisCount;

              // Choose a target card height (can be tuned). We pick a height that
              // scales reasonably with the width so the card doesn't become too tall.
              final double targetCardHeight = isDesktop ? 200.0 : 180.0;

              // childAspectRatio is width / height
              final double childAspectRatio = cardWidth / targetCardHeight;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: mySkillGrid.length,
                itemBuilder: (context, index) {
                  final skill = mySkillGrid[index];
                  return _buildSkillCard(
                    AppResources.getString(langCode, skill.key),
                    skill.icon,
                    skill.skills,
                  );
                },
              );
            },
          ),

          const SizedBox(height: 80),

          // 2. EXPERIENCE TIMELINE
          Center(child: SectionTitle(title: AppResources.getString(langCode, 'section_exp'))),
          const SizedBox(height: 40),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myExperience.length,
                itemBuilder: (context, index) {
                  final item = myExperience[index];
                  return _buildTimelineItem(item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String title, IconData icon, String skills) {
    return HoverBorderContainer(
      borderRadius: 12,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: AppColor.primary, borderRadius: BorderRadius.circular(12)),
            child: Center(child: Icon(icon, color: AppColor.white, size: 24)),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
          ),
          const SizedBox(height: 10),
          // Use Flexible instead of Expanded inside a grid cell to avoid tight
          // constraints conflicts and allow the text to layout within the
          // card's available height determined by childAspectRatio.
          Flexible(
            child: Text(
              skills,
              style: const TextStyle(fontSize: 14, color: AppColor.muted, height: 1.5),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Experience item) {
    return _HoverTimelineItem(time: item.time, role: item.role, company: item.company, desc: item.desc);
  }
}

class _HoverTimelineItem extends StatefulWidget {
  final String time;
  final String role;
  final String company;
  final String desc;

  const _HoverTimelineItem({required this.time, required this.role, required this.company, required this.desc});

  @override
  State<_HoverTimelineItem> createState() => _HoverTimelineItemState();
}

class _HoverTimelineItemState extends State<_HoverTimelineItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final highlightColor = AppColor.primary;
    final normalTextColor = AppColor.grey;
    final titleColor = AppColor.textPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(color: AppColor.primary, shape: BoxShape.circle),
                  ),
                  Expanded(child: Container(width: 2, color: AppColor.grey200)),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.time,
                          style: TextStyle(color: highlightColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Animated role (bolder + brighter on hover)
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _isHovering ? FontWeight.w800 : FontWeight.w600,
                          color: _isHovering ? titleColor : titleColor.withOpacity(0.9),
                        ),
                        child: Text(widget.role),
                      ),
                      const SizedBox(height: 5),

                      // Company
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: _isHovering ? FontWeight.w600 : FontWeight.w400,
                          color: _isHovering ? titleColor : AppColor.black54,
                        ),
                        child: Text(widget.company),
                      ),

                      const SizedBox(height: 5),

                      // Description (slightly brighter on hover)
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 13,
                          color: _isHovering ? titleColor.withOpacity(0.9) : normalTextColor,
                        ),
                        child: Text(widget.desc),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
