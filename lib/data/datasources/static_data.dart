import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';
import '../models/skill_grid_item.dart';

final List<Skill> mySkills = [
  Skill(name: 'Flutter & Dart', percent: 0.95),
  Skill(name: 'Backend (Java/Kotlin)', percent: 0.90),
  Skill(name: 'AWS Cloud & DevOps', percent: 0.85),
  Skill(name: 'SwiftUI & iOS Native', percent: 0.80),
  Skill(name: 'Web Frontend', percent: 0.75),
];

final List<Experience> myExperience = [
  Experience(
    time: '09/2022 - Current',
    role: 'Mobile Developer',
    company: 'HOPEE Soulution',
    desc: 'Flutter Mobile App',
  ),
  Experience(
    time: '2022',
    role: 'Intern Developer',
    company: 'Tien Phong',
    desc: 'Flutter Internship at Tech Company.',
  ),
  Experience(
    time: '09/2019 - 09/2022',
    role: 'Education: FPT Polytechnic HCM',
    company: 'Tien Phong',
    desc: 'Major: Business Information Technology\nGPA: 8.4/10',
  ),
];

final List<SkillGridItem> mySkillGrid = [
  SkillGridItem(
    key: 'skill_fe',
    icon: FontAwesomeIcons.laptopCode,
    skills: 'Flutter, SwiftUI, Kotlin, Swift, Vue.js, Angular, HTML/CSS',
  ),
  SkillGridItem(
    key: 'skill_be',
    icon: FontAwesomeIcons.server,
    skills: 'Java, Kotlin, Ktor, Spring Boot, RESTful APIs',
  ),
  SkillGridItem(
    key: 'skill_fw',
    icon: FontAwesomeIcons.layerGroup,
    skills: 'Spring Boot, Hibernate, JPA...',
  ),
  SkillGridItem(
    key: 'skill_db',
    icon: FontAwesomeIcons.database,
    skills: 'MySQL, SQL Server, PostgreSQL, Firebase Firestore, SQLite',
  ),
  SkillGridItem(
    key: 'skill_tools',
    icon: FontAwesomeIcons.toolbox,
    skills: 'AWS (S3, Lambda), Docker, Fastlane, CircleCI, Android Studio, XCode',
  ),
  SkillGridItem(
    key: 'skill_vc',
    icon: FontAwesomeIcons.codeBranch,
    skills: 'Git, GitHub, GitLab',
  ),
];


final List<Project> projects = [
  Project.fromMap({
    'title': {'en': 'Social Network for Elderly', 'vi': 'Mạng Xã Hội Cho Người Cao Tuổi'},
    'role': {'en': 'Senior Fullstack Dev', 'vi': 'Kỹ sư Fullstack cao cấp'},
    'image': 'assets/images/projects/elderly.png',
    'tech': ['Flutter', 'Ktor', 'AWS S3', 'WebRTC'],
    'desc': {
      'en': 'Comprehensive social network tailored for elderly users with chat, video call, and feed features.',
      'vi': 'Mạng xã hội toàn diện cho người cao tuổi tích hợp chat, gọi video và bản tin.'
    },
    'platform': ['Android', 'iOS'],
    'platformsI18n': {
      'en': ['Android', 'iOS'],
      'vi': ['Android', 'iOS']
    },
    'teamSize': 2,
    'date': 'Current',
    'subscriptionPlans': [
      {'id': 'premium_monthly', 'name_i18n': {'en': 'Premium Monthly', 'vi': 'Gói Cao Cấp (Hàng Tháng)'}, 'price': '87.0'},
      {'id': 'basic_monthly', 'name_i18n': {'en': 'Basic Monthly', 'vi': 'Gói Cơ Bản (Hàng Tháng)'}, 'price': '45.0'},
    ],
    'billingProviders': ['Google Play', 'App Store'],
    'integrations': ['Google Fit', 'HealthKit', 'Health Connect'],
    'responsibilitiesI18n': {
      'en': [
        'Develop features for chat, commenting, posting and liking',
        'Integrate real-time communication (WebRTC / WebSockets)',
        'Implement backend services with Ktor and AWS S3 for file storage',
        'Implement In-App Purchase and Subscription flows (Play Billing / StoreKit)',
        'Integrate health platforms (Google Fit, HealthKit, Health Connect) for activity/safety features',
        'Handle permissions, data sync, privacy and secure health data transfer',
        'Setup CI/CD and deployment pipelines',
      ],
      'vi': [
        'Phát triển tính năng chat, bình luận, đăng bài và thích',
        'Tích hợp liên lạc thời gian thực (WebRTC / WebSockets)',
        'Triển khai backend với Ktor và AWS S3 để lưu trữ file',
        'Thực hiện luồng Mua trong ứng dụng và Đăng ký (Play Billing / StoreKit)',
        'Tích hợp nền tảng sức khỏe (Google Fit, HealthKit, Health Connect) cho tính năng an toàn/hoạt động',
        'Xử lý quyền, đồng bộ dữ liệu, quyền riêng tư và truyền dữ liệu y tế an toàn',
        'Thiết lập CI/CD và pipeline triển khai',
      ],
    },
    'technologiesI18n': {
      'en': ['Flutter', 'Ktor', 'WebRTC', 'Firebase', 'AWS S3', 'CircleCI', 'InAppPurchase (play_store/storekit)', 'Google Fit', 'HealthKit', 'Health Connect', 'Riverpod'],
      'vi': ['Flutter', 'Ktor', 'WebRTC', 'Firebase', 'AWS S3', 'CircleCI', 'InAppPurchase (play_store/storekit)', 'Google Fit', 'HealthKit', 'Health Connect', 'Riverpod'],
    },
    'technologies': ['Flutter', 'Ktor', 'WebRTC', 'Firebase', 'AWS S3', 'CircleCI', 'InAppPurchase (play_store/storekit)', 'Google Fit', 'HealthKit', 'Health Connect', 'Riverpod'],
  }),
  Project.fromMap({
    'title': {'en': 'Dating Application', 'vi': 'Ứng Dụng Hẹn Hò'},
    'role': {'en': 'Mobile Lead', 'vi': 'Trưởng nhóm Mobile'},
    'image': 'assets/images/projects/dating.png',
    'tech': ['Flutter', 'SQLite', 'Fastlane', 'FCM'],
    'desc': {
      'en': 'Dating app with a "Love Count" feature, memory storage and real-time chat.',
      'vi': 'Ứng dụng hẹn hò với tính năng đếm ngày yêu, lưu giữ kỷ niệm và chat theo thời gian thực.'
    },
    'platform': ['Android', 'iOS'],
    'platformsI18n': {
      'en': ['Android', 'iOS'],
      'vi': ['Android', 'iOS']
    },
    'teamSize': 1,
    'date': '11/2023',
    'responsibilitiesI18n': {
      'en': [
        'Implement mobile UI/UX and local storage with SQLite',
        'Set up Fastlane for automated deployment',
        'Develop chat and persistence features',
      ],
      'vi': [
        'Triển khai UI/UX mobile và lưu trữ cục bộ với SQLite',
        'Cấu hình Fastlane để tự động hoá deploy',
        'Phát triển tính năng chat và lưu trữ',
      ]
    },
    'technologiesI18n': {
      'en': ['Flutter', 'SQLite', 'Fastlane', 'FCM'],
      'vi': ['Flutter', 'SQLite', 'Fastlane', 'FCM']
    },
    'technologies': ['Flutter', 'SQLite', 'Fastlane', 'FCM'],
  }),
  Project.fromMap({
    'title': {'en': 'Retail Store System', 'vi': 'Hệ Thống Bán Lẻ'},
    'role': {'en': 'Team Lead', 'vi': 'Trưởng nhóm'},
    'image': 'assets/images/projects/retail_store.png',
    'tech': ['Spring Boot', 'Angular', 'Flutter', 'Docker'],
    'desc': {
      'en': 'Multi-platform retail management system (Web Admin + POS App) for store chains.',
      'vi': 'Hệ thống quản lý bán lẻ đa nền tảng (Web Admin + App POS) cho chuỗi cửa hàng.'
    },
    'platform': ['Web', 'Android', 'iOS'],
    'platformsI18n': {
      'en': ['Web', 'Android', 'iOS'],
      'vi': ['Web', 'Android', 'iOS']
    },
    'teamSize': 5,
    'date': '2022',
    'responsibilitiesI18n': {
      'en': [
        'Lead development of backend and frontend features',
        'Coordinate deployment and Dockerization',
        'Integrate payment and membership features',
      ],
      'vi': [
        'Dẫn dắt phát triển backend và frontend',
        'Phối hợp triển khai và Dockerization',
        'Tích hợp thanh toán và tính năng thành viên',
      ]
    },
    'technologiesI18n': {
      'en': ['Spring Boot', 'Angular', 'Flutter', 'Docker', 'MySQL'],
      'vi': ['Spring Boot', 'Angular', 'Flutter', 'Docker', 'MySQL']
    },
    'technologies': ['Spring Boot', 'Angular', 'Flutter', 'Docker', 'MySQL'],
  }),
  Project.fromMap({
    'title': {'en': 'Resort Booking App', 'vi': 'Ứng Dụng Đặt Resort'},
    'role': {'en': 'Mobile Developer', 'vi': 'Lập trình viên Mobile'},
    'image': 'assets/images/projects/booking.png',
    'tech': ['SwiftUI', 'iOS Native', 'MapKit'],
    'desc': {
      'en': 'Luxury resort booking app with elegant UI and interactive maps.',
      'vi': 'Ứng dụng đặt phòng resort cao cấp với giao diện sang trọng và bản đồ tương tác.'
    },
    'platform': ['iOS'],
    'platformsI18n': {
      'en': ['iOS'],
      'vi': ['iOS']
    },
    'teamSize': 2,
    'date': 'Current',
    'responsibilitiesI18n': {
      'en': [
        'Implement UI/UX and map interactions',
        'Collaborate on booking flow and reservation management',
      ],
      'vi': [
        'Triển khai UI/UX và tương tác bản đồ',
        'Phối hợp về luồng đặt phòng và quản lý đặt chỗ',
      ]
    },
    'technologiesI18n': {
      'en': ['SwiftUI', 'MapKit', 'Firebase'],
      'vi': ['SwiftUI', 'MapKit', 'Firebase']
    },
    'technologies': ['SwiftUI', 'MapKit', 'Firebase'],
  }),
  Project.fromMap({
    'title': {'en': 'Japanese Learning App', 'vi': 'Ứng Dụng Học Tiếng Nhật'},
    'role': {'en': 'Lead Mobile Developer', 'vi': 'Lập trình viên Mobile chính'},
    'image': 'assets/images/projects/japanese.png',
    'tech': ['Flutter', 'Firebase', 'Video Player', 'SQLite'],
    'desc': {
      'en': 'A comprehensive app to learn Japanese: video lessons, course purchases, quizzes, flashcards (SRS), progress tracking and offline downloads.',
      'vi': 'Ứng dụng học tiếng Nhật toàn diện: bài giảng video, mua khóa học, bài kiểm tra, flashcard (SRS), theo dõi tiến độ và tải về để học offline.'
    },
    'platform': ['Android', 'iOS', 'Web'],
    'platformsI18n': {
      'en': ['Android', 'iOS', 'Web'],
      'vi': ['Android', 'iOS', 'Web']
    },
    'teamSize': 3,
    'date': '2024',
    'inAppPurchase': true,
    'subscriptionPlans': [
      {'id': 'jp_premium_monthly', 'name_i18n': {'en': 'Premium Monthly', 'vi': 'Cao Cấp (Hàng Tháng)'}, 'price': '9.99'},
      {'id': 'jp_premium_yearly', 'name_i18n': {'en': 'Premium Yearly', 'vi': 'Cao Cấp (Hàng Năm)'}, 'price': '79.99'},
    ],
    'billingProviders': ['Google Play', 'App Store'],
    'responsibilitiesI18n': {
      'en': [
        'Design and implement video lesson player with offline download support',
        'Implement in-app purchases and subscription flows (Play Billing / StoreKit)',
        'Build quiz and test engine with progress tracking and analytics',
        'Create SRS flashcards and spaced repetition algorithm',
        'Implement local database sync (SQLite) and cloud backup (Firebase)',
        'Provide UI/UX optimized for learning (progress, streaks, reminders)',
        'Support course management (lessons, sections, downloadable assets) and localization',
      ],
      'vi': [
        'Thiết kế và triển khai trình phát bài giảng video có hỗ trợ tải xuống để học offline',
        'Triển khai mua hàng trong ứng dụng và luồng đăng ký (Play Billing / StoreKit)',
        'Xây dựng engine bài kiểm tra và quiz với theo dõi tiến trình và phân tích',
        'Tạo flashcard theo SRS và thuật toán lặp khoảng cách',
        'Đồng bộ cơ sở dữ liệu cục bộ (SQLite) và sao lưu trên đám mây (Firebase)',
        'Cung cấp UI/UX tối ưu cho việc học (tiến độ, chuỗi học, nhắc nhở)',
        'Hỗ trợ quản lý khóa học (bài học, chương, tài nguyên tải về) và đa ngôn ngữ',
      ],
    },
    'technologiesI18n': {
      'en': ['Flutter', 'Firebase', 'video_player', 'sqflite', 'in_app_purchase', 'cloud_functions', 'analytics', 'cached_network_image'],
      'vi': ['Flutter', 'Firebase', 'video_player', 'sqflite', 'in_app_purchase', 'cloud_functions', 'analytics', 'cached_network_image'],
    },
    'technologies': ['Flutter', 'Firebase', 'video_player', 'sqflite', 'in_app_purchase', 'cached_network_image'],
  }),
];
