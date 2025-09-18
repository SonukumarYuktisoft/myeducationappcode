class CourseModel {
  final String id;
  final String title;
  final String shortDescription;
  final String description;
  final String category;
  final String examType;
  final String language;
  final List<String> tags;
  final Instructor instructor;
  final bool isPaid;
  final bool isEnrolled;
  final double price;
  final double discountPrice;
  final bool emiOptions;
  final int validity;
  final String refundPolicy;
  final DateTime startDate;
  final String type;
  final String duration;
  final int totalClasses;
  final int demoClasses;
  final bool recordingsAvailable;
  final List<String> syllabus;
  final Materials materials;
  final List<CurriculumSection> curriculum;
  final Target target;
  final String targetExam;
  final int examYear;
  final String difficultyLevel;
  final String eligibility;
  final Engagement engagement;
  final Offers offers;
  final String bannerUrl;
  final String board;

  CourseModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.category,
    required this.examType,
    required this.language,
    required this.tags,
    required this.instructor,
    required this.isPaid,
    required this.isEnrolled,
    required this.price,
    required this.discountPrice,
    required this.emiOptions,
    required this.validity,
    required this.refundPolicy,
    required this.startDate,
    required this.type,
    required this.duration,
    required this.totalClasses,
    required this.demoClasses,
    required this.recordingsAvailable,
    required this.syllabus,
    required this.materials,
    required this.curriculum,
    required this.target,
    required this.targetExam,
    required this.examYear,
    required this.difficultyLevel,
    required this.eligibility,
    required this.engagement,
    required this.offers,
    required this.bannerUrl,
    required this.board,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      examType: json['examType'] ?? '',
      language: json['language'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      instructor: Instructor.fromJson(json['instructor'] ?? {}),
      isPaid: json['isPaid'] ?? false,
      isEnrolled: json['isEnrolled'] ?? false,
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: (json['discountPrice'] ?? 0).toDouble(),
      emiOptions: json['emiOptions'] ?? false,
      validity: json['validity'] ?? 0,
      refundPolicy: json['refundPolicy'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? '2025-01-01T00:00:00Z'),
      type: json['type'] ?? '',
      duration: json['duration'] ?? '',
      totalClasses: json['totalClasses'] ?? 0,
      demoClasses: json['demoClasses'] ?? 0,
      recordingsAvailable: json['recordingsAvailable'] ?? false,
      syllabus: List<String>.from(json['syllabus'] ?? []),
      materials: Materials.fromJson(json['materials'] ?? {}),
      curriculum: List<CurriculumSection>.from(
          (json['curriculum'] ?? []).map((x) => CurriculumSection.fromJson(x))),
      target: Target.fromJson(json['target'] ?? {}),
      targetExam: json['targetExam'] ?? '',
      examYear: json['examYear'] ?? 0,
      difficultyLevel: json['difficultyLevel'] ?? '',
      eligibility: json['eligibility'] ?? '',
      engagement: Engagement.fromJson(json['engagement'] ?? {}),
      offers: Offers.fromJson(json['offers'] ?? {}),
      bannerUrl: json['bannerUrl'] ?? '',
      board: json['board'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'shortDescription': shortDescription,
      'description': description,
      'category': category,
      'examType': examType,
      'language': language,
      'tags': tags,
      'instructor': instructor.toJson(),
      'isPaid': isPaid,
      'isEnrolled': isEnrolled,
      'price': price,
      'discountPrice': discountPrice,
      'emiOptions': emiOptions,
      'validity': validity,
      'refundPolicy': refundPolicy,
      'startDate': startDate.toIso8601String(),
      'type': type,
      'duration': duration,
      'totalClasses': totalClasses,
      'demoClasses': demoClasses,
      'recordingsAvailable': recordingsAvailable,
      'syllabus': syllabus,
      'materials': materials.toJson(),
      'curriculum': curriculum.map((x) => x.toJson()).toList(),
      'target': target.toJson(),
      'targetExam': targetExam,
      'examYear': examYear,
      'difficultyLevel': difficultyLevel,
      'eligibility': eligibility,
      'engagement': engagement.toJson(),
      'offers': offers.toJson(),
      'bannerUrl': bannerUrl,
      'board': board,
    };
  }
}

class Instructor {
  final String id;
  final String name;
  final String photoUrl;
  final String bio;
  final List<String> subjectExpertise;

  Instructor({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.bio,
    required this.subjectExpertise,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      bio: json['bio'] ?? '',
      subjectExpertise: List<String>.from(json['subjectExpertise'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'bio': bio,
      'subjectExpertise': subjectExpertise,
    };
  }
}

class Materials {
  final bool pdfNotes;
  final bool ebooks;
  final bool previousYearPapers;
  final int mcqPracticeSets;
  final int testSeries;

  Materials({
    required this.pdfNotes,
    required this.ebooks,
    required this.previousYearPapers,
    required this.mcqPracticeSets,
    required this.testSeries,
  });

  factory Materials.fromJson(Map<String, dynamic> json) {
    return Materials(
      pdfNotes: json['pdfNotes'] ?? false,
      ebooks: json['ebooks'] ?? false,
      previousYearPapers: json['previousYearPapers'] ?? false,
      mcqPracticeSets: json['mcqPracticeSets'] ?? 0,
      testSeries: json['testSeries'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pdfNotes': pdfNotes,
      'ebooks': ebooks,
      'previousYearPapers': previousYearPapers,
      'mcqPracticeSets': mcqPracticeSets,
      'testSeries': testSeries,
    };
  }
}

class CurriculumSection {
  final String sectionTitle;
  final List<Class> classes;

  CurriculumSection({
    required this.sectionTitle,
    required this.classes,
  });

  factory CurriculumSection.fromJson(Map<String, dynamic> json) {
    return CurriculumSection(
      sectionTitle: json['sectionTitle'] ?? '',
      classes: List<Class>.from(
          (json['classes'] ?? []).map((x) => Class.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sectionTitle': sectionTitle,
      'classes': classes.map((x) => x.toJson()).toList(),
    };
  }
}

class Class {
  final String classId;
  final String title;
  final bool isDemo;
  final bool isLocked;
  final String videoUrl;

  Class({
    required this.classId,
    required this.title,
    required this.isDemo,
    required this.isLocked,
    required this.videoUrl,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      classId: json['classId'] ?? '',
      title: json['title'] ?? '',
      isDemo: json['isDemo'] ?? false,
      isLocked: json['isLocked'] ?? false,
      videoUrl: json['videoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'title': title,
      'isDemo': isDemo,
      'isLocked': isLocked,
      'videoUrl': videoUrl,
    };
  }
}

class Target {
  final String exam;
  final List<String> related;

  Target({
    required this.exam,
    required this.related,
  });

  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      exam: json['exam'] ?? '',
      related: List<String>.from(json['related'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam': exam,
      'related': related,
    };
  }
}

class Engagement {
  final int enrollmentCount;
  final double rating;
  final int reviews;

  Engagement({
    required this.enrollmentCount,
    required this.rating,
    required this.reviews,
  });

  factory Engagement.fromJson(Map<String, dynamic> json) {
    return Engagement(
      enrollmentCount: json['enrollmentCount'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enrollmentCount': enrollmentCount,
      'rating': rating,
      'reviews': reviews,
    };
  }
}

class Offers {
  final bool featured;
  final String offerBanner;

  Offers({
    required this.featured,
    required this.offerBanner,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      featured: json['featured'] ?? false,
      offerBanner: json['offerBanner'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'featured': featured,
      'offerBanner': offerBanner,
    };
  }
}