import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
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
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOngoingCoursesTab(),
                _buildCompletedCoursesTab(),
                _buildWishlistTab(),
              ],
            ),
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
        'My Courses',
        style: TextStyleCustom.headingStyle(
          fontSize: 20,
          color: AppColors.blackColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: AppColors.blackColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.filter_list,
            color: AppColors.blackColor,
          ),
        ),
      ],
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
        tabs: const [
          Tab(text: 'Ongoing'),
          Tab(text: 'Completed'),
          Tab(text: 'Wishlist'),
        ],
      ),
    );
  }

  Widget _buildOngoingCoursesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsCard(),
          const SizedBox(height: 20),
          Text(
            'Continue Learning',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildOngoingCourseCard(
                title: index == 0
                    ? 'UPSC Prelims Complete Course'
                    : index == 1
                        ? 'SSC CGL Mathematics'
                        : 'Current Affairs 2024',
                instructor: index == 0
                    ? 'Dr. Rajesh Kumar'
                    : index == 1
                        ? 'Prof. Anjali Sharma'
                        : 'Mr. Vikash Singh',
                progress: index == 0 ? 0.65 : index == 1 ? 0.40 : 0.80,
                totalLessons: index == 0 ? 120 : index == 1 ? 80 : 60,
                completedLessons: index == 0 ? 78 : index == 1 ? 32 : 48,
                nextLesson: index == 0
                    ? 'History - Medieval India'
                    : index == 1
                        ? 'Algebra - Quadratic Equations'
                        : 'Weekly Current Affairs Quiz',
                thumbnail: index == 0
                    ? 'assets/course1.jpg'
                    : index == 1
                        ? 'assets/course2.jpg'
                        : 'assets/course3.jpg',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCoursesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAchievementCard(),
          const SizedBox(height: 20),
          Text(
            'Completed Courses',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildCompletedCourseCard(
                title: index == 0
                    ? 'Basic Computer Skills'
                    : 'English Grammar Foundation',
                instructor: index == 0
                    ? 'Mr. Suresh Patel'
                    : 'Ms. Priya Gupta',
                completedDate: index == 0 ? 'Aug 15, 2024' : 'July 28, 2024',
                rating: index == 0 ? 4.5 : 4.8,
                certificate: true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saved Courses',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildWishlistCourseCard(
                title: index == 0
                    ? 'BPSC Mains Strategy'
                    : index == 1
                        ? 'Railway Group D Complete'
                        : index == 2
                            ? 'Banking Reasoning'
                            : 'Police SI Physical Test',
                instructor: index == 0
                    ? 'Dr. Kumar Singh'
                    : index == 1
                        ? 'Er. Rakesh Jha'
                        : index == 2
                            ? 'Prof. Neha Kumari'
                            : 'Inspector Raj Kumar',
                price: index == 0
                    ? '₹2,999'
                    : index == 1
                        ? '₹1,999'
                        : index == 2
                            ? '₹1,499'
                            : '₹999',
                originalPrice: index == 0
                    ? '₹4,999'
                    : index == 1
                        ? '₹3,999'
                        : index == 2
                            ? '₹2,499'
                            : '₹1,999',
                rating: index == 0 ? 4.6 : index == 1 ? 4.4 : index == 2 ? 4.7 : 4.3,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.linearButtonColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem('3', 'Active\nCourses'),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.whiteColor.withOpacity(0.3),
          ),
          Expanded(
            child: _buildStatItem('127', 'Hours\nLearned'),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.whiteColor.withOpacity(0.3),
          ),
          Expanded(
            child: _buildStatItem('2', 'Certificates\nEarned'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyleCustom.headingStyle(
            fontSize: 24,
            color: AppColors.whiteColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyleCustom.normalStyle(
            fontSize: 12,
            color: AppColors.whiteColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFD700),
            const Color(0xFFFFA500),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_events,
            size: 40,
            color: AppColors.whiteColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyleCustom.headingStyle(
                    fontSize: 18,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have completed 2 courses successfully',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingCourseCard({
    required String title,
    required String instructor,
    required double progress,
    required int totalLessons,
    required int completedLessons,
    required String nextLesson,
    required String thumbnail,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.play_circle_filled,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleCustom.headingStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by $instructor',
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.clr606060,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$completedLessons of $totalLessons lessons',
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: AppColors.clr606060,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% complete',
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.clrD6D6D6,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            minHeight: 6,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Next: $nextLesson',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCourseCard({
    required String title,
    required String instructor,
    required String completedDate,
    required double rating,
    required bool certificate,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF4CAF50),
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleCustom.headingStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'by $instructor',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.clr606060,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Completed on $completedDate',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.clr606060,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor() ? Icons.star : Icons.star_border,
                          color: const Color(0xFFFFD700),
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      rating.toString(),
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (certificate)
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_download, size: 16),
              label: const Text('Certificate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: TextStyleCustom.normalStyle(fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWishlistCourseCard({
    required String title,
    required String instructor,
    required String price,
    required String originalPrice,
    required double rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.bookmark,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleCustom.headingStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'by $instructor',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.clr606060,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor() ? Icons.star : Icons.star_border,
                          color: const Color(0xFFFFD700),
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      rating.toString(),
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyleCustom.headingStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      originalPrice,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ).copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: AppColors.redColor,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Enroll',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}