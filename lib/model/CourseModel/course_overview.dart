class CourseOverview {
  final String name;
  final List<String> categories;
  final String startDate;
  final String duration;
  final String teacher;
  final bool isPaid;
  final String? image;

  const CourseOverview({
    required this.name,
    required this.categories,
    required this.startDate,
    required this.duration,
    required this.teacher,
    required this.isPaid,
    this.image,
  });
}
