import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/app/widgets/hover_border_container.dart';
import 'package:portfolio/core/localization/app_resources.dart';
import 'package:portfolio/data/models/project.dart';
import 'package:portfolio/data/datasources/static_data.dart';
import 'package:portfolio/app/views/home/sections/project_detail_page.dart';

class RecentProjectSection extends StatefulWidget {
  final bool isDesktop;
  final String langCode;
  const RecentProjectSection({super.key, required this.isDesktop, required this.langCode});

  @override
  State<RecentProjectSection> createState() => _RecentProjectSectionState();
}

class _RecentProjectSectionState extends State<RecentProjectSection> {
  final ScrollController _scrollController = ScrollController();

  late double _cardWidth;
  final double _cardSpacing = 30.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollList(int direction) {
    if (_scrollController.hasClients) {
      final double currentOffset = _scrollController.offset;
      final double scrollAmount = (_cardWidth + _cardSpacing) * direction;
      final double targetOffset = currentOffset + scrollAmount;

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 600), // Animation duration
        curve: Curves.easeInOutCubic, // Smooth curve
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isSmall = screenWidth < 600; // phone
    final bool isMedium = screenWidth >= 600 && screenWidth < 900; // tablet
    final bool isLarge = screenWidth >= 900 || widget.isDesktop; // desktop

    // Responsive horizontal padding
    final double horizontalPadding = isLarge ? 100.0 : (isSmall ? 16.0 : 40.0);

    // Compute card width depending on breakpoint
    _cardWidth = isLarge
        ? (screenWidth - horizontalPadding * 2) * 0.4
        : (isMedium
            ? (screenWidth - horizontalPadding * 2) * 0.55
            : (screenWidth - horizontalPadding * 2) * 0.9);

    // Compute list height based on card width with sensible clamps
    double listHeight = _cardWidth * 0.95;
    if (listHeight < 320) listHeight = 320;
    if (listHeight > 520) listHeight = 520;

    final bool showNav = isLarge; // show nav buttons only on large screens

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
                AppResources.getString(widget.langCode, 'section_projects'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: isLarge ? 30 : 24,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          const SizedBox(height: 50),

          SizedBox(
            height: listHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
                  itemCount: projects.length,
                  separatorBuilder: (context, index) => SizedBox(width: _cardSpacing),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return _buildProjectCard(project, widget.langCode)
                        .animate()
                        .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                        .slideX(begin: 0.2, curve: Curves.easeOut);
                  },
                ),

                if (showNav)
                  Positioned(
                    left: 40,
                    child: _buildNavButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () => _scrollList(-1),
                    ),
                  ),

                if (showNav)
                  Positioned(
                    right: 40,
                    child: _buildNavButton(
                      icon: Icons.arrow_forward_ios,
                      onTap: () => _scrollList(1),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Round navigation button widget
  Widget _buildNavButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      elevation: 5,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: const Color(0xFF00BFA6), size: 24),
        ),
      ),
    ).animate().scale(duration: 300.ms); // Button appear scale animation
  }

  Widget _buildProjectCard(Project project, String langCode) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProjectDetailPage(project: project, langCode: langCode)),
        );
      },
      child: HoverBorderContainer(
        width: _cardWidth,
        padding: const EdgeInsets.all(0),
        borderRadius: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  image: DecorationImage(
                    image: AssetImage(project.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, const Color(0xFF000000).withValues(alpha: 0.5)],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            project.localizedTitle(langCode),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: const Color(0xFF00BFA6).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(
                          project.localizedRole(langCode),
                          style: const TextStyle(fontSize: 11, color: Color(0xFF00BFA6), fontWeight: FontWeight.w700)
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Tech Stack
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: project.localizedTechnologies(langCode).map((t) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Text(t, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}