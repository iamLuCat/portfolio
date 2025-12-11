class Project {
  final String title;
  final String role;
  final String image;
  final List<String> tech;
  final Map<String, String> descriptions; // keyed by language code, e.g. 'en', 'vi'
  final List<String> platform;
  final int teamSize;
  final String date;
  final List<String> responsibilities;
  final List<String> technologies;

  // New optional fields for in-app purchase / subscriptions / integrations
  final bool inAppPurchase;
  final List<SubscriptionPlan> subscriptionPlans; // structured plans with localized names
  final List<String> billingProviders; // e.g. ['Google Play', 'App Store']
  final List<String> integrations; // e.g. ['Google Fit', 'HealthKit']

  // Localized variants
  final Map<String, String> titles; // e.g. {'en': 'Title', 'vi': 'Tiêu đề'}
  final Map<String, String> roles; // localized roles
  final Map<String, List<String>> responsibilitiesLocalized; // keyed by lang
  final Map<String, List<String>> technologiesLocalized; // keyed by lang
  final Map<String, List<String>> platformsLocalized; // keyed by lang

  Project({
    required this.title,
    required this.role,
    required this.image,
    required this.tech,
    required this.descriptions,
    required this.platform,
    required this.teamSize,
    required this.date,
    required this.responsibilities,
    required this.technologies,
    this.inAppPurchase = false,
    this.subscriptionPlans = const [],
    this.billingProviders = const [],
    this.integrations = const [],
    this.titles = const {},
    this.roles = const {},
    this.responsibilitiesLocalized = const {},
    this.technologiesLocalized = const {},
    this.platformsLocalized = const {},
  });

  factory Project.fromMap(Map<String, dynamic> m) {
    final dynamic descField = m['desc'] ?? '';
    Map<String, String> descs;
    if (descField is String) {
      descs = {'en': descField};
    } else if (descField is Map) {
      descs = Map<String, String>.from(descField.map((k, v) => MapEntry(k.toString(), v.toString())));
    } else {
      descs = {'en': ''};
    }

    // parse subscriptionPlans
    List<SubscriptionPlan> plans = [];
    if (m['subscriptionPlans'] is List) {
      try {
        plans = (m['subscriptionPlans'] as List).map((item) {
          if (item is Map) return SubscriptionPlan.fromMap(Map<String, dynamic>.from(item));
          return SubscriptionPlan(id: '', names: {}, price: '');
        }).toList();
      } catch (_) {
        plans = [];
      }
    }

    // billingProviders
    List<String> billing = [];
    try {
      billing = List<String>.from(m['billingProviders'] ?? m['billing_providers'] ?? []);
    } catch (_) {
      billing = [];
    }

    // integrations
    List<String> integrations = [];
    try {
      integrations = List<String>.from(m['integrations'] ?? []);
    } catch (_) {
      integrations = [];
    }

    // parse localized titles and roles
    Map<String, String> titles = {};
    if (m['title'] is Map) {
      titles = Map<String, String>.from((m['title'] as Map).map((k, v) => MapEntry(k.toString(), v.toString())));
    } else if (m['title'] is String) {
      titles = {'en': m['title'].toString()};
    }

    Map<String, String> roles = {};
    if (m['role'] is Map) {
      roles = Map<String, String>.from((m['role'] as Map).map((k, v) => MapEntry(k.toString(), v.toString())));
    } else if (m['role'] is String) {
      roles = {'en': m['role'].toString()};
    }

    // responsibilities localized
    Map<String, List<String>> responsibilitiesLocalized = {};
    if (m['responsibilitiesI18n'] is Map) {
      (m['responsibilitiesI18n'] as Map).forEach((k, v) {
        try {
          responsibilitiesLocalized[k.toString()] = List<String>.from(v as List);
        } catch (_) {}
      });
    } else if (m['responsibilities'] is Map) {
      (m['responsibilities'] as Map).forEach((k, v) {
        try {
          responsibilitiesLocalized[k.toString()] = List<String>.from(v as List);
        } catch (_) {}
      });
    } else if (m['responsibilities'] is List) {
      responsibilitiesLocalized['en'] = List<String>.from(m['responsibilities']);
    }

    // technologies localized
    Map<String, List<String>> technologiesLocalized = {};
    if (m['technologiesI18n'] is Map) {
      (m['technologiesI18n'] as Map).forEach((k, v) {
        try {
          technologiesLocalized[k.toString()] = List<String>.from(v as List);
        } catch (_) {}
      });
    } else if (m['technologies'] is Map) {
      (m['technologies'] as Map).forEach((k, v) {
        try {
          technologiesLocalized[k.toString()] = List<String>.from(v as List);
        } catch (_) {}
      });
    } else if (m['technologies'] is List) {
      technologiesLocalized['en'] = List<String>.from(m['technologies']);
    }

    // platforms localized
    Map<String, List<String>> platformsLocalized = {};
    if (m['platformsI18n'] is Map) {
      (m['platformsI18n'] as Map).forEach((k, v) {
        try {
          platformsLocalized[k.toString()] = List<String>.from(v as List);
        } catch (_) {}
      });
    } else if (m['platform'] is Map) {
      (m['platform'] as Map).forEach((k, v) {
        try {
          platformsLocalized[k.toString()] = List<String>.from(v as List);
        } catch (_) {}
      });
    } else if (m['platform'] is List) {
      platformsLocalized['en'] = List<String>.from(m['platform']);
    }

    return Project(
      title: m['title'] is String ? m['title'] ?? '' : (titles['en'] ?? ''),
      role: m['role'] is String ? m['role'] ?? '' : (roles['en'] ?? ''),
      image: m['image'] ?? '',
      tech: List<String>.from(m['tech'] ?? []),
      descriptions: descs,
      platform: List<String>.from(m['platform'] ?? m['platforms'] ?? []),
      teamSize: (m['teamSize'] is int) ? m['teamSize'] as int : int.tryParse((m['teamSize'] ?? '').toString()) ?? 0,
      date: (m['date'] ?? m['year'] ?? '').toString(),
      responsibilities: List<String>.from(m['responsibilities'] ?? []),
      technologies: List<String>.from(m['technologies'] ?? m['tech'] ?? []),
      inAppPurchase: (m['inAppPurchase'] == true || m['in_app_purchase'] == true) ? true : false,
      subscriptionPlans: plans,
      billingProviders: billing,
      integrations: integrations,
      titles: titles,
      roles: roles,
      responsibilitiesLocalized: responsibilitiesLocalized,
      technologiesLocalized: technologiesLocalized,
      platformsLocalized: platformsLocalized,
    );
  }

  // Localization helpers
  String localizedTitle(String langCode) {
    return titles[langCode] ?? titles['en'] ?? title;
  }

  String localizedRole(String langCode) {
    return roles[langCode] ?? roles['en'] ?? role;
  }

  List<String> localizedResponsibilities(String langCode) {
    if (responsibilitiesLocalized.containsKey(langCode)) return responsibilitiesLocalized[langCode]!;
    if (responsibilitiesLocalized.containsKey('en')) return responsibilitiesLocalized['en']!;
    return responsibilities;
  }

  List<String> localizedTechnologies(String langCode) {
    if (technologiesLocalized.containsKey(langCode)) return technologiesLocalized[langCode]!;
    if (technologiesLocalized.containsKey('en')) return technologiesLocalized['en']!;
    return technologies;
  }

  List<String> localizedPlatforms(String langCode) {
    if (platformsLocalized.containsKey(langCode)) return platformsLocalized[langCode]!;
    if (platformsLocalized.containsKey('en')) return platformsLocalized['en']!;
    return platform;
  }

  List<SubscriptionPlan> localizedSubscriptionPlans(String langCode) {
    return subscriptionPlans.map((p) => p.withLang(langCode)).toList();
  }

  String localizedDescription(String langCode) {
    if (descriptions.containsKey(langCode)) return descriptions[langCode]!;
    if (descriptions.containsKey('en')) return descriptions['en']!;
    return descriptions.values.isNotEmpty ? descriptions.values.first : '';
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'role': role,
        'image': image,
        'tech': tech,
        'desc': descriptions,
        'platform': platform,
        'teamSize': teamSize,
        'date': date,
        'responsibilities': responsibilities,
        'technologies': technologies,
        'inAppPurchase': inAppPurchase,
        'subscriptionPlans': subscriptionPlans.map((p) => p.toMap()).toList(),
        'billingProviders': billingProviders,
        'integrations': integrations,
        'titles': titles,
        'roles': roles,
        'responsibilitiesI18n': responsibilitiesLocalized,
        'technologiesI18n': technologiesLocalized,
        'platformsI18n': platformsLocalized,
      };
}

class SubscriptionPlan {
  final String id;
  final Map<String, String> names; // localized names
  final String price;

  SubscriptionPlan({required this.id, required this.names, required this.price});

  factory SubscriptionPlan.fromMap(Map<String, dynamic> m) {
    final id = (m['id'] ?? m['planId'] ?? '').toString();
    Map<String, String> names = {};
    if (m['name'] is Map) {
      names = Map<String, String>.from((m['name'] as Map).map((k, v) => MapEntry(k.toString(), v.toString())));
    } else if (m['name'] is String) {
      names = {'en': m['name'].toString()};
    }
    // support name_i18n
    if (m['name_i18n'] is Map) {
      names.addAll(Map<String, String>.from((m['name_i18n'] as Map).map((k, v) => MapEntry(k.toString(), v.toString()))));
    }
    final price = (m['price'] ?? m['cost'] ?? '').toString();
    return SubscriptionPlan(id: id, names: names, price: price);
  }

  String localizedName(String langCode) {
    return names[langCode] ?? names['en'] ?? '';
  }

  SubscriptionPlan withLang(String langCode) {
    return SubscriptionPlan(id: id, names: names, price: price);
  }

  Map<String, dynamic> toMap() => {'id': id, 'name_i18n': names, 'price': price};
}
