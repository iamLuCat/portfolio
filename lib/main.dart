import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyPortfolioApp());
}

// ============================================================================
// 1. DATA & RESOURCES
// ============================================================================

class AppResources {
  static const Map<String, Map<String, String>> localizedValues = {
    'en': {
      'role': 'Senior Fullstack Developer',
      'hello': 'Hello There!',
      'intro': 'I am a Mobile & Backend Expert based in Vietnam. Specializing in high-performance apps with Flutter, SwiftUI & Spring Boot.',
      'btn_cv': 'Download CV',
      'section_skills': 'My Skills',
      'section_exp': 'Experience',
      'section_edu': 'Education',
      'section_pricing': 'Flexible Pricing',
      'section_services': 'Services I Provide',
      'contact_title': 'Get in Touch',
      'menu_home': 'Home',
      'menu_skills': 'Skills',
      'menu_services': 'Services',
      'menu_contact': 'Contact',
      'price_basic': 'Basic Plan',
      'price_std': 'Standard Plan',
      'price_premium': 'Custom Plan',
    },
    'vi': {
      'role': 'Senior Fullstack Developer',
      'hello': 'Xin chào!',
      'intro': 'Tôi là Chuyên gia Mobile & Backend tại Việt Nam. Chuyên xây dựng ứng dụng hiệu năng cao với Flutter, SwiftUI & Spring Boot.',
      'btn_cv': 'Tải CV',
      'section_skills': 'Kỹ Năng',
      'section_exp': 'Kinh Nghiệm',
      'section_edu': 'Học Vấn',
      'section_pricing': 'Bảng Giá Dịch Vụ',
      'section_services': 'Dịch Vụ Cung Cấp',
      'contact_title': 'Liên Hệ Ngay',
      'menu_home': 'Trang Chủ',
      'menu_skills': 'Kỹ Năng',
      'menu_services': 'Dịch Vụ',
      'menu_contact': 'Liên Hệ',
      'price_basic': 'Cơ Bản',
      'price_std': 'Tiêu Chuẩn',
      'price_pre': "Thỏa Thuận",
    }
  };

  static String getString(String langCode, String key) {
    return localizedValues[langCode]?[key] ?? key;
  }
}

final List<Map<String, dynamic>> mySkills = [
  {'name': 'Flutter & Dart', 'percent': 0.95},
  {'name': 'Backend (Java/Kotlin)', 'percent': 0.90},
  {'name': 'AWS Cloud & DevOps', 'percent': 0.85},
  {'name': 'SwiftUI & iOS Native', 'percent': 0.80},
  {'name': 'Web Frontend', 'percent': 0.75},
];

final List<Map<String, String>> myExperience = [
  {
    'time': 'Current',
    'role': 'Senior Developer',
    'company': 'Social Network App',
    'desc': 'Build Social App. Ktor Backend, AWS S3.'
  },
  {
    'time': '2023',
    'role': 'Mobile Developer',
    'company': 'Dating Application',
    'desc': 'Fastlane CI/CD, SQLite, Flutter.'
  },
  {
    'time': '2022',
    'role': 'Team Lead',
    'company': 'Retail Store System',
    'desc': 'Spring Boot BE + Angular/Flutter FE.'
  },
];

// ============================================================================
// 2. MAIN APP CONFIG
// ============================================================================

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pham Quang Vu Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF2D3748),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BFA6),
          primary: const Color(0xFF00BFA6),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MainLayout(),
    );
  }
}

// ============================================================================
// 3. MAIN LAYOUT
// ============================================================================

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isLoading = true;
  String _langCode = 'vi';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  void _toggleLanguage() {
    setState(() => _langCode = _langCode == 'vi' ? 'en' : 'vi');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _isLoading
          ? const LoadingScreen(key: ValueKey('loader'))
          : HomePage(
        key: const ValueKey('home'),
        langCode: _langCode,
        onLanguageToggle: _toggleLanguage,
      ),
    );
  }
}

// --- LOADING SCREEN ---
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "VuPham.",
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0)
                .shimmer(duration: 1500.ms, color: const Color(0xFF00BFA6)),

            const SizedBox(height: 20),

            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade900,
                color: const Color(0xFF00BFA6),
                minHeight: 2,
              ),
            ).animate().scaleX(duration: 2000.ms, begin: 0, alignment: Alignment.centerLeft),
          ],
        ),
      ),
    );
  }
}

// --- HOME PAGE ---
class HomePage extends StatelessWidget {
  final String langCode;
  final VoidCallback onLanguageToggle;

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  HomePage({super.key, required this.langCode, required this.onLanguageToggle});

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: isDesktop
          ? DesktopNavBar(
        langCode: langCode,
        onHomeTap: () => _scrollToSection(homeKey),
        onSkillsTap: () => _scrollToSection(skillsKey),
        onServicesTap: () => _scrollToSection(servicesKey),
        onContactTap: () => _scrollToSection(contactKey),
      )
          : MobileNavBar(langCode: langCode, onMenuTap: () => scaffoldKey.currentState?.openEndDrawer()),
      endDrawer: !isDesktop
          ? MobileDrawer(
        langCode: langCode,
        onHomeTap: () => _scrollToSection(homeKey),
        onSkillsTap: () => _scrollToSection(skillsKey),
        onServicesTap: () => _scrollToSection(servicesKey),
        onContactTap: () => _scrollToSection(contactKey),
      )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: onLanguageToggle,
        backgroundColor: const Color(0xFF00BFA6),
        mini: !isDesktop,
        child: Text(langCode.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: isDesktop ? 40 : 20),
            HeroSection(key: homeKey, isDesktop: isDesktop, langCode: langCode),
            SizedBox(height: isDesktop ? 80 : 50),
            SkillAndExpSection(key: skillsKey, isDesktop: isDesktop, langCode: langCode),
            SizedBox(height: isDesktop ? 80 : 50),
            ServicesSection(key: servicesKey, isDesktop: isDesktop, langCode: langCode),
            SizedBox(height: isDesktop ? 80 : 50),
            PricingSection(isDesktop: isDesktop, langCode: langCode),
            SizedBox(height: isDesktop ? 80 : 50),
            ContactSection(key: contactKey, isDesktop: isDesktop, langCode: langCode),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 4. NAVIGATION COMPONENTS
// ============================================================================

class DesktopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String langCode;
  final VoidCallback onHomeTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;

  const DesktopNavBar({
    super.key,
    required this.langCode,
    required this.onHomeTap,
    required this.onSkillsTap,
    required this.onServicesTap,
    required this.onContactTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("VuPham.", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            children: [
              _navItem(AppResources.getString(langCode, 'menu_home'), onHomeTap),
              _navItem(AppResources.getString(langCode, 'menu_skills'), onSkillsTap),
              _navItem(AppResources.getString(langCode, 'menu_services'), onServicesTap),
              _navItem(AppResources.getString(langCode, 'menu_contact'), onContactTap),
            ],
          ),
          ElevatedButton(
            onPressed: onContactTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15)
            ),
            child: const Text("Hire Me"),
          )
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    ),
  );
}

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
      title: Text("VuPham.", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: onMenuTap,
        )
      ],
    );
  }
}

class MobileDrawer extends StatelessWidget {
  final String langCode;
  final VoidCallback onHomeTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onServicesTap;
  final VoidCallback onContactTap;

  const MobileDrawer({
    super.key,
    required this.langCode,
    required this.onHomeTap,
    required this.onSkillsTap,
    required this.onServicesTap,
    required this.onContactTap,
  });

  void _handleTap(BuildContext context, VoidCallback scrollAction) {
    Navigator.pop(context);
    scrollAction();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF00BFA6)),
            child: Center(
              child: Text("Menu", style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(leading: const Icon(Icons.home), title: Text(AppResources.getString(langCode, 'menu_home')), onTap: () => _handleTap(context, onHomeTap)),
          ListTile(leading: const Icon(Icons.code), title: Text(AppResources.getString(langCode, 'menu_skills')), onTap: () => _handleTap(context, onSkillsTap)),
          ListTile(leading: const Icon(Icons.work), title: Text(AppResources.getString(langCode, 'menu_services')), onTap: () => _handleTap(context, onServicesTap)),
          ListTile(leading: const Icon(Icons.mail), title: Text(AppResources.getString(langCode, 'menu_contact')), onTap: () => _handleTap(context, onContactTap)),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. SECTIONS
// ============================================================================

class HeroSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;
  const HeroSection({super.key, required this.isDesktop, required this.langCode});

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
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/400"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ).animate().scale(delay: 500.ms, duration: 800.ms, curve: Curves.elasticOut);

    Widget textContent = Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(AppResources.getString(langCode, 'hello'),
            style: const TextStyle(color: Color(0xFF00BFA6), fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Text("PHAM QUANG VU",
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.poppins(fontSize: isDesktop ? 48 : 32, fontWeight: FontWeight.bold, height: 1.1)),
        Text(AppResources.getString(langCode, 'role').toUpperCase(),
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.poppins(fontSize: isDesktop ? 24 : 16, fontWeight: FontWeight.w300, letterSpacing: 2)),
        const SizedBox(height: 20),
        Text(AppResources.getString(langCode, 'intro'),
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 15, height: 1.6)),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BFA6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              ),
              child: Text(AppResources.getString(langCode, 'btn_cv')),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _socialIcon(FontAwesomeIcons.github),
                _socialIcon(FontAwesomeIcons.linkedinIn),
                _socialIcon(FontAwesomeIcons.facebookF),
              ],
            )
          ],
        )
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
          : Column(
        children: [
          profileImage,
          const SizedBox(height: 30),
          textContent,
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(icon, color: Colors.black87, size: 20),
    );
  }
}

class SkillAndExpSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;
  const SkillAndExpSection({super.key, required this.isDesktop, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: AppResources.getString(langCode, 'section_skills')),
                const SizedBox(height: 30),
                ...mySkills.map((skill) => _buildSkillBar(skill['name'], skill['percent'])),
              ],
            ),
          ),
          SizedBox(width: isDesktop ? 80 : 0, height: isDesktop ? 0 : 50),
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: AppResources.getString(langCode, 'section_exp')),
                const SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: myExperience.length,
                  itemBuilder: (context, index) {
                    final item = myExperience[index];
                    return _buildTimelineItem(item['time']!, item['role']!, item['company']!, item['desc']!);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSkillBar(String name, double percent) {
    // UPDATED: Bọc trong HoverBorderContainer để có hiệu ứng hover
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: HoverBorderContainer(
        borderRadius: 8,
        isTransparent: false,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("${(percent * 100).toInt()}%", style: const TextStyle(color: Colors.grey)),
            ]),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF00BFA6),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ).animate().slideX(duration: 1.seconds, begin: -1, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String time, String role, String company, String desc) {
    // UPDATED: Bọc trong HoverBorderContainer
    return HoverBorderContainer(
      borderRadius: 8,
      isTransparent: false,
      padding: const EdgeInsets.all(12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFF00BFA6), shape: BoxShape.circle)),
                Expanded(child: Container(width: 2, color: Colors.grey.shade200)),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF00BFA6).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(time, style: const TextStyle(color: Color(0xFF00BFA6), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Text(role, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(company, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 5),
                    Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 13)),
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

class ServicesSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;
  const ServicesSection({super.key, required this.isDesktop, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text("Quality Services", style: TextStyle(color: const Color(0xFF00BFA6), fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(AppResources.getString(langCode, 'section_services'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isDesktop ? 30 : 24, fontWeight: FontWeight.bold)),
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
          )
        ],
      ),
    );
  }

  Widget _serviceCard(BuildContext context, IconData icon, String title, String sub) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 900 ? 300.0 : (width > 600 ? width / 2.2 : width - 40);

    // UPDATED: Sử dụng HoverBorderContainer
    return HoverBorderContainer(
      width: cardWidth,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: const Color(0xFF00BFA6)),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(sub, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          const Icon(Icons.arrow_forward, color: Colors.black)
        ],
      ),
    );
  }
}

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
          Text(AppResources.getString(langCode, 'section_pricing'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isDesktop ? 30 : 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _pricingCard(context, AppResources.getString(langCode, 'price_basic'), "\$25", "/Hour", ["Bug Fixing", "Consultation"], false),
              _pricingCard(context, AppResources.getString(langCode, 'price_std'), "\$2k+", "/Project", ["Full App Dev", "Backend Setup"], true),
              _pricingCard(context, AppResources.getString(langCode, 'price_pre'), "Neg.", "/Month", ["Dedicated Dev", "Maintenance"], false),
            ],
          )
        ],
      ),
    );
  }

  Widget _pricingCard(BuildContext context, String title, String price, String unit, List<String> features, bool isPopular) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 900 ? 300.0 : (width - 40);

    // UPDATED: Sử dụng HoverBorderContainer với tham số isPopular
    return HoverBorderContainer(
      width: cardWidth,
      padding: const EdgeInsets.all(30),
      isPopular: isPopular, // Xử lý nền đen cho Popular card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: isPopular ? Colors.white : Colors.black, fontSize: 16)),
          const SizedBox(height: 20),
          RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: price, style: TextStyle(color: const Color(0xFF00BFA6), fontSize: 32, fontWeight: FontWeight.bold)),
                    TextSpan(text: unit, style: TextStyle(color: isPopular ? Colors.grey : Colors.black54, fontSize: 14)),
                  ]
              )
          ),
          const SizedBox(height: 30),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Color(0xFF00BFA6), size: 18),
                const SizedBox(width: 10),
                Text(f, style: TextStyle(color: isPopular ? Colors.grey.shade300 : Colors.black54))
              ],
            ),
          )),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: (){},
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isPopular ? Colors.white : Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 15)
              ),
              child: Text("Order Now", style: TextStyle(color: isPopular ? Colors.white : Colors.black)),
            ),
          )
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final bool isDesktop;
  final String langCode;
  const ContactSection({super.key, required this.isDesktop, required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2D3748),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(AppResources.getString(langCode, 'contact_title'), style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              children: [
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _contactRow(Icons.phone, "+84 90 123 4567"),
                      _contactRow(Icons.email, "vu.pham@example.com"),
                      _contactRow(Icons.location_on, "Ho Chi Minh City"),
                    ],
                  ),
                ),
                SizedBox(height: isDesktop ? 0 : 40, width: 50),
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    children: [
                      _inputField("Name"),
                      const SizedBox(height: 15),
                      _inputField("Email"),
                      const SizedBox(height: 15),
                      _inputField("Message", maxLines: 4),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BFA6), padding: const EdgeInsets.symmetric(vertical: 15)),
                          child: const Text("Send Message", style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Text("Copyright @2025 Pham Quang Vu. All Rights Reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey))
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF00BFA6)),
          ),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16))
        ],
      ),
    );
  }

  Widget _inputField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}

// ============================================================================
// 6. HELPER CLASSES & NEW HOVER WIDGET
// ============================================================================

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 10, dashSpace = 8, startX = 0;
    final paint = Paint()
      ..color = const Color(0xFF00BFA6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    Path dashPath = Path();
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (startX < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(startX, startX + dashWidth),
          Offset.zero,
        );
        startX += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Container(width: 50, height: 3, color: const Color(0xFF00BFA6), margin: const EdgeInsets.only(top: 5))
      ],
    );
  }
}

// --- NEW WIDGET: HOVER BORDER EFFECT ---
class HoverBorderContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool isPopular;
  final bool isTransparent; // Dùng cho Skill Bar (nền trong suốt)
  final double borderRadius;

  const HoverBorderContainer({
    super.key,
    required this.child,
    this.width,
    this.padding,
    this.isPopular = false,
    this.isTransparent = false,
    this.borderRadius = 10,
  });

  @override
  State<HoverBorderContainer> createState() => _HoverBorderContainerState();
}

class _HoverBorderContainerState extends State<HoverBorderContainer> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Xác định màu nền
    Color bgColor;
    if (widget.isTransparent) {
      bgColor = _isHovering ? Colors.white : Colors.transparent;
    } else {
      bgColor = widget.isPopular ? Colors.black : Colors.white;
    }

    // Xác định màu viền
    Color borderColor;
    if (_isHovering) {
      borderColor = const Color(0xFF00BFA6); // Màu sáng khi hover
    } else {
      borderColor = widget.isPopular || widget.isTransparent ? Colors.transparent : Colors.grey.shade200;
    }

    // Shadow
    List<BoxShadow>? boxShadow;
    if (!widget.isTransparent && !widget.isPopular) {
      boxShadow = [
        BoxShadow(
            color: _isHovering ? const Color(0xFF00BFA6).withOpacity(0.2) : Colors.grey.shade100,
            blurRadius: 15,
            offset: const Offset(0, 5)
        )
      ];
    } else if (widget.isPopular) {
      boxShadow = [const BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))];
    } else if (widget.isTransparent && _isHovering) {
      boxShadow = [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5))];
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: boxShadow,
        ),
        transform: _isHovering ? (Matrix4.identity()..translate(0, -5)) : Matrix4.identity(), // Nổi lên nhẹ khi hover
        child: widget.child,
      ),
    );
  }
}