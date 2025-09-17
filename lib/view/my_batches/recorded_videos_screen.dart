import 'package:education/core/constants/color.dart';
import 'package:education/view/my_batches/course_controller/course_controller.dart';
import 'package:education/view/my_batches/widgets/my_batches_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordedVideosScreen extends StatelessWidget {
  final CourseController courseCtrl =
      Get.put(CourseController(filterStatus: "upcoming"));

  @override
  Widget build(BuildContext context) {
    courseCtrl.applyFilters(allCourses);

    return Scaffold(
      appBar: AppBar(title: Text("Recorded Videos")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search by title, instructor, category"),
                onChanged: (value) => courseCtrl.updateSearch(value, allCourses),
              ),
            ),
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
                    // return ListTile(
                    //   title: Text(c.title),
                    //   subtitle: Text("${c.instructor} • ${c.board}"),
                    // );
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
      ),
    );
  }
  Widget _buildSearchSection() {
    return Container(
      color: AppColors.primaryColor,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search upcoming courses...",
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
