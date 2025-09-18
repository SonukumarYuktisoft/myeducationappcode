import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/model/CourseModel/course_overview.dart';
import 'package:education/view/my_batches/batch_detail.dart';
import 'package:education/view/my_batches/live_class_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

class MyBatchesScreen extends StatefulWidget {
  const MyBatchesScreen({super.key});

  @override
  State<MyBatchesScreen> createState() => _MyBatchesScreenState();
}

class _MyBatchesScreenState extends State<MyBatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // _buildTabBar(),
          Expanded(
            // child: TabBarView(
            //   controller: _tabController,
            //   children: [_buildOverviewTab(), _buildCurriculumTab()],
            // ),
            child: _buildOverviewTab(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      title: Text(
        'My Batches',
        style: TextStyleCustom.headingStyle(
          fontSize: 20,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.clrD6D6D6.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.whiteColor,
        unselectedLabelColor: AppColors.clr606060,
        labelStyle: TextStyleCustom.normalStyle(
          fontSize: 14,
          fontFamily: FontFamily.semiBold,
        ),
        unselectedLabelStyle: TextStyleCustom.normalStyle(
          fontSize: 14,
          fontFamily: FontFamily.medium,
        ),
        tabs: const [Tab(text: 'Overview'), Tab(text: 'Curriculum')],
      ),
    );
  }

  // ---------------- Overview Tab ----------------
  Widget _buildOverviewTab() {
    final overviewItems = [
      CourseOverview(
        name: 'UPSC Prelims Complete',
        categories: const ['UPSC', 'BPSC', 'Railway'],
        startDate: '15 Oct 2025',
        duration: '6 months',
        teacher: 'Dr. Rajesh Kumar',
        isPaid: true,
        // image: 'assets\png\courses_images\upsc.jpeg'
      ),
      CourseOverview(
        name: 'SSC CGL Mathematics',
        categories: const ['SSC'],
        startDate: '01 Nov 2025',
        duration: '3 months',
        teacher: 'Prof. Anjali Sharma',
        isPaid: false,
      ),
      CourseOverview(
        name: 'SSC CGL Mathematics',
        categories: const ['SSC'],
        startDate: '01 Nov 2025',
        duration: '3 months',
        teacher: 'Prof. Anjali Sharma',
        isPaid: false,
      ),
      CourseOverview(
        name: 'SSC CGL Mathematics',
        categories: const ['SSC'],
        startDate: '01 Nov 2025',
        duration: '3 months',
        teacher: 'Prof. Anjali Sharma',
        isPaid: false,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: overviewItems.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = overviewItems[index];
        return _buildOverviewCard(item, () {
          Get.to(() => BatchDetailScreen(item: item));
        });
      },
    );
  }

  Widget _buildOverviewCard(CourseOverview item, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/png/trending_courses_img.jpg'),
            fit: BoxFit.cover,
          ),
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Container(
        //           width: 56,
        //           height: 56,
        //           decoration: BoxDecoration(
        //             color: AppColors.primaryColor.withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //           child: Icon(Icons.menu_book, color: AppColors.primaryColor),
        //         ),
        //         const SizedBox(width: 12),
        //         Expanded(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 item.name,
        //                 style: TextStyleCustom.headingStyle(
        //                   fontSize: 16,
        //                   color: AppColors.blackColor,
        //                 ),
        //               ),
        //               const SizedBox(height: 6),
        //               Wrap(
        //                 spacing: 6,
        //                 runSpacing: -8,
        //                 children:
        //                     item.categories
        //                         .map((c) => _chip(c, AppColors.primaryColor))
        //                         .toList(),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 12),
        //     _kv('Start date', item.startDate),
        //     const SizedBox(height: 8),
        //     _kv('Duration', item.duration),
        //     const SizedBox(height: 8),
        //     _kv('Teacher', item.teacher),
        //     const SizedBox(height: 8),
        //     _kv('Paid', item.isPaid ? 'Yes' : 'No'),
        //   ],
        // ),
      ),
    );
  }

  // ---------------- Curriculum Tab ----------------
  Widget _buildCurriculumTab() {
    final subjects = <_SubjectItem>[
      _SubjectItem(title: 'Science - Light', status: _ClassStatus.live),
      _SubjectItem(
        title: 'Mathematics - Algebra',
        status: _ClassStatus.upcoming,
      ),
      _SubjectItem(title: 'GK/GS - Polity', status: _ClassStatus.completed),
      _SubjectItem(title: 'Reasoning - Series', status: _ClassStatus.upcoming),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildSubjectTile(subjects[index]);
      },
    );
  }

  Widget _buildSubjectTile(_SubjectItem item) {
    Color statusColor;
    String statusText;
    Widget? trailing;

    switch (item.status) {
      case _ClassStatus.upcoming:
        statusColor = const Color(0xFFFFA500);
        statusText = 'Upcoming';
        trailing = _statusPill(statusText, statusColor);
        break;
      case _ClassStatus.live:
        statusColor = AppColors.primaryColor;
        statusText = 'Live';
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _statusPill(statusText, statusColor),
            const SizedBox(width: 8),
            _primaryButton(
              'Join',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LiveClassScreen()),
                );
              },
            ),
          ],
        );
        break;
      case _ClassStatus.completed:
        statusColor = const Color(0xFF4CAF50);
        statusText = 'Completed';
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _statusPill('Recorded', statusColor),
            const SizedBox(width: 8),
            _outlineButton('View'),
            const SizedBox(width: 8),
            _outlineButton('Notes'),
          ],
        );
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.class_, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyleCustom.headingStyle(
                    fontSize: 15,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Class status',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.clr606060,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  // ---------------- UI helpers ----------------
  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyleCustom.normalStyle(
          fontSize: 11,
          color: color,
          fontFamily: FontFamily.semiBold,
        ),
      ),
    );
  }

  Widget _kv(String key, String value) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            key,
            style: TextStyleCustom.normalStyle(
              fontSize: 13,
              color: AppColors.clr606060,
              fontFamily: FontFamily.semiBold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyleCustom.normalStyle(
              fontSize: 13,
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyleCustom.normalStyle(
          fontSize: 11,
          color: color,
          fontFamily: FontFamily.semiBold,
        ),
      ),
    );
  }

  Widget _primaryButton(String text, {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        textStyle: TextStyleCustom.normalStyle(fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text),
    );
  }

  Widget _outlineButton(String text) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: BorderSide(color: AppColors.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: TextStyleCustom.normalStyle(fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text),
    );
  }
}

enum _ClassStatus { upcoming, live, completed }

class _SubjectItem {
  final String title;
  final _ClassStatus status;
  const _SubjectItem({required this.title, required this.status});
}
