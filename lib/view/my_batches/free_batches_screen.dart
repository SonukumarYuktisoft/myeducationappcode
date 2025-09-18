import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/model/CourseModel/course_model.dart';
import 'package:education/view/my_batches/batch_detail_copy.dart';
import 'package:education/view/my_batches/course_controller/course_controller.dart';
import 'package:education/view/my_batches/widgets/my_batches_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeBatchesScreen extends StatelessWidget {
  final CourseController courseCtrl = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Free Courses",
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.blackColor,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        foregroundColor: AppColors.blackColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Filter Section Header
            Text(
              "Filter by Category",
              style: TextStyleCustom.headingStyle(
                fontSize: 16,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 12),

            /// Category Filter Chips
            Obx(() {
              return SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: courseCtrl.categories.length,
                  itemBuilder: (context, index) {
                    final category = courseCtrl.categories[index];
                    final isSelected =
                        courseCtrl.selectedCategory.value == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () => courseCtrl.filterByCategory(category),
                        child: MyBatchesChip(
                          label: category,
                          color: AppColors.primaryColor,
                          isSelected: isSelected,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 20),

            /// Tags Filter Section
            // Text(
            //   "Filter by Tags",
            //   style: TextStyleCustom.headingStyle(
            //     fontSize: 16,
            //     color: AppColors.blackColor,
            //   ),
            // ),
            // const SizedBox(height: 12),

            /// Tags Filter Chips
            // Obx(() {
            //   final freeCourses = courseCtrl.getFreeCourses();
            //   final allTags = <String>{};

            //   for (var course in freeCourses) {
            //     allTags.addAll(course.tags);
            //   }

            //   final tagsList = ["All Tags", ...allTags.toList()];

            //   return SizedBox(
            //     height: 40,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: tagsList.length,
            //       itemBuilder: (context, index) {
            //         final tag = tagsList[index];
            //         final isSelected = courseCtrl.selectedTag.value == tag;

            //         return Padding(
            //           padding: const EdgeInsets.only(right: 8.0),
            //           child: GestureDetector(
            //             onTap: () => courseCtrl.filterByTag(tag),
            //             child: MyBatchesChip(
            //               label: tag,
            //               color: Colors.blue,
            //               isSelected: isSelected,
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   );
            // }),
            const SizedBox(height: 20),

            /// Course Count
            Obx(() {
              final freeCoursesCount = _getFilteredFreeCourses().length;
              return Text(
                "$freeCoursesCount Free Course${freeCoursesCount != 1 ? 's' : ''} Found",
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.clr606060,
                  fontFamily: FontFamily.medium,
                ),
              );
            }),

            const SizedBox(height: 16),

            /// Free Courses List
            Expanded(
              child: Obx(() {
                if (courseCtrl.allCourses.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                final filteredFreeCourses = _getFilteredFreeCourses();

                if (filteredFreeCourses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: AppColors.clr606060.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No free courses found",
                          style: TextStyleCustom.headingStyle(
                            fontSize: 18,
                            color: AppColors.clr606060,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Try selecting different filters",
                          style: TextStyleCustom.normalStyle(
                            fontSize: 14,
                            color: AppColors.clr606060,
                            fontFamily: FontFamily.medium,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    courseCtrl.loadCourses();
                  },
                  color: AppColors.primaryColor,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredFreeCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredFreeCourses[index];
                      return _buildFreeCourseCard(
                        onTap: () {
                          Get.to(() => BatchDetailCopy(item: course));
                        },
                        course: course,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Get filtered free courses based on category and tag
  List<CourseModel> _getFilteredFreeCourses() {
    var freeCourses = courseCtrl.getFreeCourses();

    // Filter by category
    if (courseCtrl.selectedCategory.value != "All") {
      freeCourses =
          freeCourses
              .where(
                (course) =>
                    course.category == courseCtrl.selectedCategory.value,
              )
              .toList();
    }

    // Filter by tag
    if (courseCtrl.selectedTag.value != "All Tags") {
      freeCourses =
          freeCourses
              .where(
                (course) => course.tags.contains(courseCtrl.selectedTag.value),
              )
              .toList();
    }

    return freeCourses;
  }

  Widget _buildFreeCourseCard({
    void Function()? onTap,
    required CourseModel course,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: AppColors.clrD6D6D6.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Banner Image with Overlays
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    course.bannerUrl.isNotEmpty
                        ? course.bannerUrl
                        : 'assets/png/trending_courses_img.jpg',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        width: double.infinity,
                        color: AppColors.clrD6D6D6.withOpacity(0.3),
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.clr606060,
                          size: 48,
                        ),
                      );
                    },
                  ),

                  // /// Free Badge
                  // Positioned(
                  //   top: 12,
                  //   left: 12,
                  //   child: MyBatchesChip(
                  //     label: "FREE",
                  //     color: Colors.green,
                  //     isSelected: true,
                  //   ),
                  // ),

                  /// Featured Badge
                  if (course.offers.featured)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: MyBatchesChip(
                        label: "Featured",
                        color: Colors.orange,
                        isSelected: true,
                      ),
                    ),

                  /// Demo Classes Badge
                  // if (course.demoClasses > 0)
                  //   Positioned(
                  //     bottom: 12,
                  //     left: 12,
                  //     child: MyBatchesChip(
                  //       label: "${course.demoClasses} Demo Classes",
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                ],
              ),
            ),

            /// Course Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Category and Language Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          MyBatchesChip(
                            label: course.category,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          MyBatchesChip(
                            label: course.language,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                      if (course.demoClasses > 0)
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: MyBatchesChip(
                            label: "${course.demoClasses} Demo Classes",
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Course Title
                  Text(
                    course.title,
                    style: TextStyleCustom.headingStyle(
                      fontSize: 18,
                      color: AppColors.blackColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  /// Short Description
                  Text(
                    course.shortDescription,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 14,
                      color: AppColors.clr606060,
                      fontFamily: FontFamily.medium,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // const SizedBox(height: 12),

                  // /// Course Tags
                  // Wrap(
                  //   spacing: 6,
                  //   runSpacing: 6,
                  //   children:
                  //       course.tags
                  //           .take(3)
                  //           .map(
                  //             (tag) =>
                  //                 MyBatchesChip(label: tag, color: Colors.cyan),
                  //           )
                  //           .toList(),
                  // ),
                  const SizedBox(height: 12),

                  /// Course Details Row
                  Row(
                    children: [
                      /// Instructor
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: AppColors.clr606060,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          course.instructor.name,
                          style: TextStyleCustom.normalStyle(
                            fontSize: 12,
                            color: AppColors.clr606060,
                            fontFamily: FontFamily.medium,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// Duration
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.clr606060,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course.duration,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 12,
                          color: AppColors.clr606060,
                          fontFamily: FontFamily.medium,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Second Details Row
                  Row(
                    children: [
                      /// Total Classes
                      Icon(
                        Icons.play_circle_outline,
                        size: 16,
                        color: AppColors.clr606060,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${course.totalClasses} Classes",
                        style: TextStyleCustom.normalStyle(
                          fontSize: 12,
                          color: AppColors.clr606060,
                          fontFamily: FontFamily.medium,
                        ),
                      ),

                      const SizedBox(width: 16),

                      /// Enrollments
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: AppColors.clr606060,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${course.engagement.enrollmentCount}+ enrolled",
                        style: TextStyleCustom.normalStyle(
                          fontSize: 12,
                          color: AppColors.clr606060,
                          fontFamily: FontFamily.medium,
                        ),
                      ),

                      const Spacer(),

                      /// Rating
                      if (course.engagement.rating > 0) ...[
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          course.engagement.rating.toStringAsFixed(1),
                          style: TextStyleCustom.normalStyle(
                            fontSize: 12,
                            color: AppColors.clr606060,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                      ],
                    ],
                  ),

                  /// Target Exams
                  if (course.target.related.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      "Target: ${course.target.related.take(2).join(', ')}${course.target.related.length > 2 ? '...' : ''}",
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontFamily: FontFamily.medium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
