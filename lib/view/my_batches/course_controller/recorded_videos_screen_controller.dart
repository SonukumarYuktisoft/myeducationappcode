import 'package:education/core/services/localapi_service.dart';
import 'package:education/model/CourseModel/course_model.dart';
import 'package:get/get.dart';

class RecordedVideosScreenController extends GetxController {
  var allCourses = <CourseModel>[].obs;
  var filteredCourses = <CourseModel>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = "All".obs;
  var selectedTag = "All Tags".obs;
  final LocalApiService apiService = LocalApiService();

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  void loadCourses() async {
    final response = await apiService.getLocalJson("assets/data/recordedCourses.json");
    allCourses.value =
        response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();

    // Extract unique categories
    Set<String> categorySet = {};
    for (var course in allCourses) {
      categorySet.add(course.category);
    }
    categories.value = ["All", ...categorySet.toList()];

    // Initially show all courses
    filteredCourses.value = allCourses;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    _applyFilters();
  }

  void filterByTag(String tag) {
    selectedTag.value = tag;
    _applyFilters();
  }

  void _applyFilters() {
    var courses = allCourses;

    // Filter by category
    if (selectedCategory.value != "All") {
      courses =
          courses
              .where((course) => course.category == selectedCategory.value)
              .toList()
              .obs;
    }

    // Filter by tag
    if (selectedTag.value != "All Tags") {
      courses =
          courses
              .where((course) => course.tags.contains(selectedTag.value))
              .toList()
              .obs;
    }

    filteredCourses.value = courses;
  }

  void resetFilters() {
    selectedCategory.value = "All";
    selectedTag.value = "All Tags";
    filteredCourses.value = allCourses;
  }

  // Get courses based on type
  List<CourseModel> getCoursesByType(String type) {
    return filteredCourses.where((course) => course.type == type).toList();
  }

  // Get free courses only
  List<CourseModel> getFreeCourses() {
    return allCourses.where((course) => !course.isPaid).toList();
  }

  // Get paid courses only
  List<CourseModel> getPaidCourses() {
    return allCourses.where((course) => course.isPaid).toList();
  }

  // Get enrolled courses
  List<CourseModel> getEnrolledCourses() {
    return allCourses.where((course) => course.isEnrolled).toList();
  }

  // Get Live Class courses
  List<CourseModel> getLiveClassCourses() {
    return allCourses.where((course) => course.type == "Live Class").toList();
  }
// Get Live Class courses
  List<CourseModel> getUpcomingCourses() {
    return allCourses.where((course) => course.type == "upcoming").toList();
  }
  // Get Recorded Videos courses
  List<CourseModel> getRecordedVideoCourses() {
    return allCourses.where((course) => course.recordingsAvailable).toList();
  }

  // // Get Upcoming Batches
  // List<CourseModel> getUpcomingBatches() {
  //   return allCourses.where((course) => course.isUpcomingBatch == true).toList();
  // }

  // Get My Batches (all batches)
  List<CourseModel> getMyBatches() {
    return allCourses;
  }

  // Get featured courses
  List<CourseModel> getFeaturedCourses() {
    return allCourses.where((course) => course.offers.featured).toList();
  }

  // Search courses by title or description
  List<CourseModel> searchCourses(String query) {
    if (query.isEmpty) return filteredCourses;

    return filteredCourses
        .where(
          (course) =>
              course.title.toLowerCase().contains(query.toLowerCase()) ||
              course.shortDescription.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              course.instructor.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }

  // Get all unique tags from courses
  List<String> getAllTags() {
    Set<String> tagSet = {};
    for (var course in allCourses) {
      tagSet.addAll(course.tags);
    }
    return tagSet.toList();
  }

  // Get all unique tags from free courses only
  List<String> getFreeCoursesTags() {
    Set<String> tagSet = {};
    final freeCourses = getFreeCourses();
    for (var course in freeCourses) {
      tagSet.addAll(course.tags);
    }
    return tagSet.toList();
  }

  // Get course by ID
  CourseModel? getCourseById(String id) {
    try {
      return allCourses.firstWhere((course) => course.id == id);
    } catch (e) {
      return null;
    }
  }
}
