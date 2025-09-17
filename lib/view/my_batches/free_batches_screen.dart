import 'package:education/core/constants/color.dart';
import 'package:education/view/my_batches/course_controller/course_controller.dart';
import 'package:education/view/my_batches/widgets/my_batches_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FreeBatchesScreen extends StatelessWidget {
  final CourseController courseCtrl =
      Get.put(CourseController(filterIsPaid: false));

  @override
  Widget build(BuildContext context) {
    courseCtrl.applyFilters(allCourses);

    return Scaffold(
      appBar: AppBar(title: Text("Free Courses")),
      body: Column(
        children: [
          _buildSearchSection(courseCtrl),
          _buildCategoryChips(courseCtrl),
          // List
          Expanded(
            child: Obx(() {
              if (courseCtrl.filteredCourses.isEmpty) {
                return Center(child: Text("No courses found"));
              }
              return ListView.builder(
                itemCount: courseCtrl.filteredCourses.length,
                itemBuilder: (ctx, i) {
                  final c = courseCtrl.filteredCourses[i];
                    return MyBatchesWidgets.buildOverviewCard(
                            item: c,
                            onTap: () {
                              Get.to(()=> MyBatchesWidgets.buildOverviewCardDetail(c));
                            },
                          );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchSection(CourseController courseCtrl) {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search free courses...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          suffixIcon: Obx(() {
            return courseCtrl.searchQuery.value.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey.shade600),
                    onPressed: () => courseCtrl.updateSearch("", allCourses),
                  )
                : SizedBox.shrink();
          }),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: (value) => courseCtrl.updateSearch(value, allCourses),
      ),
    );
  }
   Widget _buildCategoryChips(CourseController courseCtrl) {
  return Obx(() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:courseCtrl. categories.map((cat) {
          final isSelected = courseCtrl.selectedCategory.value == cat;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              selectedColor: Colors.blue.shade200,
              onSelected: (_) {
                if (isSelected) {
                  // agar already selected hai → reset
                  courseCtrl.updateCategory("", allCourses);
                } else {
                  courseCtrl.updateCategory(cat, allCourses);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  });
}
}
