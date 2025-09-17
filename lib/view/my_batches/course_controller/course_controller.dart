import 'dart:io';

import 'package:get/get.dart';

final List<Course> allCourses = [
  Course(
    id: "1",
    title: "UPSC Prelims 2026 Foundation",
    instructor: "Ketan Sharma",
    category: "UPSC",
    board: "National",
    description: "Complete GS + CSAT with tests.",
    banner: "assets/png/trending_courses_img.jpg",
    isPaid: true,
    status: "upcoming",
    type: "live",
    targets: ["UPSC"],
    startDate: "01 Jan 2026",
    duration: "6 months",
  ),
  Course(
    id: "2",
    title: "BPSC Mains Crash Course",
    instructor: "Ravi Kumar",
    category: "BPSC",
    board: "Bihar Board",
    description: "Answer writing practice + PYQs.",
    banner: "assets/png/trending_courses_img.jpg",
    isPaid: false,
    status: "ongoing",
    type: "recorded",
    targets: ["BPSC", "UPSC"],
    startDate: "15 Sep 2025",
    duration: "4 months",
  ),
  Course(
    id: "3",
    title: "SSC CGL Tier-1 Foundation",
    instructor: "Neha Gupta",
    category: "SSC",
    board: "National",
    description: "Quant + Reasoning full coverage.",
    banner: "assets/png/trending_courses_img.jpg",
    isPaid: true,
    status: "completed",
    type: "recorded",
    targets: ["SSC", "Railway"],
    startDate: "10 May 2025",
    duration: "5 months",
  ),
  Course(
    id: "4",
    title: "Rajasthan Teacher Exam Live Batch",
    instructor: "Sunita Meena",
    category: "Teaching",
    board: "Rajasthan Board",
    description: "Pedagogy + Child Development.",
    banner: "assets/png/trending_courses_img.jpg",
    isPaid: false,
    status: "upcoming",
    type: "live",
    targets: ["Teaching", "Rajasthan Exams"],
    startDate: "20 Oct 2025",
    duration: "3 months",
  ),
  Course(
    id: "5",
    title: "UPSI Final Merit Complete Theory Batch",
    instructor: "Vivek Sir (UPSI Rank 5)",
    category: "UPSI",
    board: "UP Board",
    description: "Complete theory batch with LIVE classes, PDFs, "
        "12,000+ PYQs, 6 hours daily classes, VOD, DPP, "
        "Current Affairs & Test Series.",
    banner: "assets/png/trending_courses_img.jpg",
    isPaid: true,
    status: "upcoming",
    type: "live",
    targets: ["UPSI"],
    startDate: "26 Aug 2025",
    duration: "Till Exam",
  ),
  Course(
    id: "6",
    title: "SSC CGL Mathematics",
    instructor: "Prof. Anjali Sharma",
    category: "SSC",
    board: "National",
    description: "Maths foundation + advanced level.",
    banner: "assets/png/trending_courses_img.jpg",
    isPaid: false,
    status: "upcoming",
    type: "recorded",
    targets: ["SSC", "Railway"],
    startDate: "01 Nov 2025",
    duration: "3 months",
  ),
];



class Course {
  final String id;
  final String title;
  final String instructor;
  final String category;
  final String board;
  final String description;
  final String banner;
  final bool isPaid;
  final String status; // upcoming, ongoing, completed
  final String type;   // live, recorded
  final List<String> targets; // 👈 exams ya categories multiple
  final String startDate; // 👈 new field
  final String duration;  // 👈 new field

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.board,
    required this.description,
    required this.banner,
    required this.isPaid,
    required this.status,
    required this.type,
    required this.targets,
    required this.startDate, // 👈
    required this.duration,  // 👈
  });
}

class CourseController extends GetxController {
  var selectedCategory = "".obs;
  var selectedBoard = "".obs;
  var searchQuery = "".obs;

  var filteredCourses = <Course>[].obs;

  String? filterStatus; // upcoming, ongoing, completed
  bool? filterIsPaid; // free/paid
  String? filterType; // live/recorded

  CourseController({this.filterStatus, this.filterIsPaid, this.filterType});

  void applyFilters(List<Course> allCourses) {
    filteredCourses.value =
        allCourses.where((course) {
          // screen-level filter
          final matchesStatus =
              filterStatus == null || course.status == filterStatus;
          final matchesPaid =
              filterIsPaid == null || course.isPaid == filterIsPaid;
          final matchesType = filterType == null || course.type == filterType;

          // user-level filter
          final matchesCategory =
              selectedCategory.value.isEmpty ||
              course.category == selectedCategory.value;

          final matchesBoard =
              selectedBoard.value.isEmpty ||
              course.board == selectedBoard.value;

          final matchesSearch =
              searchQuery.value.isEmpty ||
              course.title.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              course.instructor.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              course.category.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              );

          return matchesStatus &&
              matchesPaid &&
              matchesType &&
              matchesCategory &&
              matchesBoard &&
              matchesSearch;
        }).toList();
  }

  void updateCategory(String category, List<Course> allCourses) {
    selectedCategory.value = category;
    applyFilters(allCourses);
  }

  void updateBoard(String board, List<Course> allCourses) {
    selectedBoard.value = board;
    applyFilters(allCourses);
  }

  void updateSearch(String query, List<Course> allCourses) {
    searchQuery.value = query;
    applyFilters(allCourses);
  }

  void resetFilters(List<Course> allCourses) {
    selectedCategory.value = "";
    selectedBoard.value = "";
    searchQuery.value = "";
    applyFilters(allCourses);
  }

  List<String> get categories => allCourses.map((c) => c.category).toSet().toList();
}
