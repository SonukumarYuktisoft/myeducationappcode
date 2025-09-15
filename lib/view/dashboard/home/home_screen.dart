
import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/view/my_batches/my_batches.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 20),
            _buildTrendingCoursesSection(),
            const SizedBox(height: 25),
            _buildQuickActions(),
            const SizedBox(height: 25),
            _buildUpcomingBatchesSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leadingWidth: 60,
      titleSpacing: 10.0,
      leading: Container(
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: Icon(Icons.school, color: AppColors.whiteColor, size: 24),
      ),
      title: Text(
        'Career Classes',
        style: TextStyleCustom.headingStyle(
          fontSize: 20,
          color: AppColors.blackColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_outlined, color: AppColors.blackColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.account_circle_outlined,
            color: AppColors.blackColor,
          ),
        ),
        
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyleCustom.headingStyle(
              fontSize: 24,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to continue your learning journey?',
            style: TextStyleCustom.normalStyle(
              fontSize: 16,
              color: AppColors.whiteColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flash_on, color: AppColors.primaryColor, size: 24),
            const SizedBox(width: 8),
            Text(
              'Quick Actions',
              style: TextStyleCustom.headingStyle(
                fontSize: 20,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: [
            _buildActionCard(
              icon: Icons.book_outlined,
              title: 'My Batches',
              color: const Color(0xFF4285F4),
              onTap: () {
                Get.to(() => MyBatchesScreen());
              },
            ),
            _buildActionCard(
              icon: Icons.quiz_outlined,
              title: 'Mock Tests',
              color: const Color(0xFF34A853),
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.live_tv_outlined,
              title: 'Live Classes',
              color: const Color(0xFFEA4335),
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.note_outlined,
              title: 'Notes',
              color: const Color(0xFFFBBC05),
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.stars_outlined,
              title: 'Free Batches',
              color: const Color(0xFF9C27B0),
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.play_circle_outline,
              title: 'Recorded Videos',
              color: const Color(0xFFFF5722),
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.schedule_outlined,
              title: 'Upcoming Batches',
              color: const Color(0xFF795548),
              onTap: () {},
            ),
            _buildActionCard(
              icon: Icons.psychology_outlined,
              title: 'AI Assistant',
              color: const Color(0xFF607D8B),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyleCustom.normalStyle(
                fontSize: 12,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingCoursesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Courses',
              style: TextStyleCustom.headingStyle(
                fontSize: 20,
                color: AppColors.blackColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyleCustom.normalStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCourseCard(
                title: index == 0
                    ? 'UPSC Prelims 2024'
                    : index == 1
                    ? 'SSC CGL Special'
                    : 'Banking Preparation',
                subtitle: index == 0
                    ? 'Complete Course'
                    : index == 1
                    ? 'Crash Course'
                    : 'Foundation Course',
                price: index == 0
                    ? '₹2999'
                    : index == 1
                    ? '₹1999'
                    : '₹1499',
                originalPrice: index == 0
                    ? '₹4999'
                    : index == 1
                    ? '₹2999'
                    : '₹2499',
                color: index == 0
                    ? const Color(0xFF1565C0)
                    : index == 1
                    ? const Color(0xFFD32F2F)
                    : const Color(0xFF388E3C),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingBatchesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Batches',
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _buildUpcomingBatchCard(
              title: index == 0
                  ? 'BPSC Mains Batch'
                  : index == 1
                  ? 'Railway Group D'
                  : 'Police SI Preparation',
              startDate: index == 0
                  ? 'Sept 15, 2024'
                  : index == 1
                  ? 'Sept 20, 2024'
                  : 'Sept 25, 2024',
              duration: index == 0
                  ? '6 Months'
                  : index == 1
                  ? '4 Months'
                  : '3 Months',
              seats: index == 0
                  ? '45'
                  : index == 1
                  ? '60'
                  : '30',
            );
          },
        ),
      ],
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String subtitle,
    required String price,
    required String originalPrice,
    required Color color,
  }) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.8)],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TRENDING',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 10,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.bookmark_outline,
                  color: AppColors.whiteColor,
                  size: 20,
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyleCustom.headingStyle(
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyleCustom.normalStyle(
                fontSize: 14,
                color: AppColors.whiteColor.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  price,
                  style: TextStyleCustom.headingStyle(
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  originalPrice,
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.whiteColor.withOpacity(0.7),
                  ).copyWith(decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingBatchCard({
    required String title,
    required String startDate,
    required String duration,
    required String seats,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.schedule,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
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
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.clr606060,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      startDate,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.clr606060,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
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
          Column(
            children: [
              Text(
                seats,
                style: TextStyleCustom.headingStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                'seats left',
                style: TextStyleCustom.normalStyle(
                  fontSize: 10,
                  color: AppColors.clr606060,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}