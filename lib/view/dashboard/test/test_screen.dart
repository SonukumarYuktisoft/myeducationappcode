import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/core/utils/text.dart';
import 'package:flutter/material.dart';

class MockTestScreen extends StatefulWidget {
  const MockTestScreen({super.key});

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
                _buildAllTestsTab(),
                _buildOngoingTestsTab(),
                _buildCompletedTestsTab(),
                _buildPerformanceTab(),
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
        'Mock Tests',
        style: TextStyleCustom.headingStyle(
          fontSize: 20,
          color: AppColors.blackColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.filter_list,
            color: AppColors.blackColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.history,
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
          fontSize: 12,
          fontFamily: FontFamily.semiBold,
        ),
        unselectedLabelStyle: TextStyleCustom.normalStyle(
          fontSize: 12,
          fontFamily: FontFamily.medium,
        ),
        tabs: const [
          Tab(text: 'All Tests'),
          Tab(text: 'Ongoing'),
          Tab(text: 'Completed'),
          Tab(text: 'Performance'),
        ],
      ),
    );
  }

  Widget _buildAllTestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTestStatsCard(),
          const SizedBox(height: 20),
          _buildTestCategoriesSection(),
          const SizedBox(height: 20),
          Text(
            'Recommended Tests',
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
              return _buildTestCard(
                title: index == 0
                    ? 'UPSC Prelims Mock Test - 15'
                    : index == 1
                        ? 'SSC CGL Full Length Test - 8'
                        : index == 2
                            ? 'Current Affairs Weekly Quiz'
                            : 'BPSC Mains Practice Test - 3',
                subject: index == 0
                    ? 'General Studies'
                    : index == 1
                        ? 'Quantitative Aptitude'
                        : index == 2
                            ? 'Current Affairs'
                            : 'Essay Writing',
                duration: index == 0
                    ? '2 Hours'
                    : index == 1
                        ? '3 Hours'
                        : index == 2
                            ? '30 Minutes'
                            : '3 Hours',
                questions: index == 0 ? 100 : index == 1 ? 100 : index == 2 ? 25 : 8,
                marks: index == 0 ? 200 : index == 1 ? 200 : index == 2 ? 50 : 300,
                attempts: index == 0 ? 1247 : index == 1 ? 890 : index == 2 ? 2156 : 456,
                difficulty: index == 0
                    ? 'Medium'
                    : index == 1
                        ? 'Hard'
                        : index == 2
                            ? 'Easy'
                            : 'Hard',
                isPremium: index == 1 ? true : false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingTestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActiveTestCard(),
          const SizedBox(height: 20),
          Text(
            'Continue Your Tests',
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
              return _buildOngoingTestCard(
                title: index == 0
                    ? 'UPSC Prelims Mock Test - 12'
                    : 'Current Affairs Monthly Test',
                subject: index == 0 ? 'General Studies' : 'Current Affairs',
                timeLeft: index == 0 ? '45 minutes' : '1 hour 20 minutes',
                progress: index == 0 ? 0.65 : 0.30,
                answered: index == 0 ? 65 : 15,
                total: index == 0 ? 100 : 50,
                startedOn: index == 0 ? 'Today 10:30 AM' : 'Yesterday 2:00 PM',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedTestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecentPerformanceCard(),
          const SizedBox(height: 20),
          Text(
            'Completed Tests',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildCompletedTestCard(
                title: index == 0
                    ? 'UPSC Prelims Mock Test - 10'
                    : index == 1
                        ? 'SSC CGL Practice Test - 5'
                        : index == 2
                            ? 'Current Affairs Quiz - Week 12'
                            : index == 3
                                ? 'Mathematics Speed Test'
                                : 'General Knowledge Test - 8',
                subject: index == 0
                    ? 'General Studies'
                    : index == 1
                        ? 'Quantitative Aptitude'
                        : index == 2
                            ? 'Current Affairs'
                            : index == 3
                                ? 'Mathematics'
                                : 'General Knowledge',
                score: index == 0
                    ? 156
                    : index == 1
                        ? 142
                        : index == 2
                            ? 38
                            : index == 3
                                ? 85
                                : 72,
                totalMarks: index == 0
                    ? 200
                    : index == 1
                        ? 200
                        : index == 2
                            ? 50
                            : index == 3
                                ? 100
                                : 100,
                percentage: index == 0
                    ? 78.0
                    : index == 1
                        ? 71.0
                        : index == 2
                            ? 76.0
                            : index == 3
                                ? 85.0
                                : 72.0,
                rank: index == 0 ? 45 : index == 1 ? 67 : index == 2 ? 23 : index == 3 ? 12 : 89,
                totalStudents: index == 0
                    ? 1247
                    : index == 1
                        ? 890
                        : index == 2
                            ? 2156
                            : index == 3
                                ? 654
                                : 987,
                completedOn: index == 0
                    ? '2 days ago'
                    : index == 1
                        ? '1 week ago'
                        : index == 2
                            ? '1 week ago'
                            : index == 3
                                ? '2 weeks ago'
                                : '3 weeks ago',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverallPerformanceCard(),
          const SizedBox(height: 20),
          _buildSubjectWisePerformance(),
          const SizedBox(height: 20),
          _buildMonthlyProgressChart(),
          const SizedBox(height: 20),
          _buildWeakAreasCard(),
        ],
      ),
    );
  }

  Widget _buildTestStatsCard() {
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
            child: _buildStatItem('15', 'Tests\nTaken'),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.whiteColor.withOpacity(0.3),
          ),
          Expanded(
            child: _buildStatItem('78%', 'Average\nScore'),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.whiteColor.withOpacity(0.3),
          ),
          Expanded(
            child: _buildStatItem('45', 'Best\nRank'),
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

  Widget _buildTestCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Test Categories',
          style: TextStyleCustom.headingStyle(
            fontSize: 18,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryCard('UPSC', Icons.account_balance, 25),
              _buildCategoryCard('SSC', Icons.work, 18),
              _buildCategoryCard('Banking', Icons.account_balance_wallet, 12),
              _buildCategoryCard('Railway', Icons.train, 15),
              _buildCategoryCard('Police', Icons.security, 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String category, IconData icon, int testCount) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            category,
            style: TextStyleCustom.normalStyle(
              fontSize: 14,
              color: AppColors.blackColor,
              fontFamily: FontFamily.semiBold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$testCount Tests',
            style: TextStyleCustom.normalStyle(
              fontSize: 12,
              color: AppColors.clr606060,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard({
    required String title,
    required String subject,
    required String duration,
    required int questions,
    required int marks,
    required int attempts,
    required String difficulty,
    required bool isPremium,
  }) {
    Color difficultyColor = difficulty == 'Easy'
        ? const Color(0xFF4CAF50)
        : difficulty == 'Medium'
            ? const Color(0xFFFFA500)
            : AppColors.redColor;

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
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyleCustom.headingStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              if (isPremium)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'PREMIUM',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 10,
                      color: const Color(0xFFB8860B),
                      fontFamily: FontFamily.semiBold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subject,
            style: TextStyleCustom.normalStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTestInfoItem(Icons.access_time, duration),
              _buildTestInfoItem(Icons.quiz, '$questions Questions'),
              _buildTestInfoItem(Icons.grade, '$marks Marks'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                    color: AppColors.clr606060,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$attempts attempts',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.clr606060,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: difficultyColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      difficulty,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 10,
                        color: difficultyColor,
                        fontFamily: FontFamily.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Start Test',
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

  Widget _buildTestInfoItem(IconData icon, String text) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.clr606060,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyleCustom.normalStyle(
                fontSize: 12,
                color: AppColors.clr606060,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTestCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.redColor.withOpacity(0.8),
            AppColors.redColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer,
            size: 40,
            color: AppColors.whiteColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test in Progress!',
                  style: TextStyleCustom.headingStyle(
                    fontSize: 18,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Continue your UPSC Mock Test - only 45 minutes left',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.redColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: Text(
                    'Continue Test',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOngoingTestCard({
    required String title,
    required String subject,
    required String timeLeft,
    required double progress,
    required int answered,
    required int total,
    required String startedOn,
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.redColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.timer,
                  color: AppColors.redColor,
                  size: 20,
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
                    Text(
                      subject,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                timeLeft,
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: AppColors.redColor,
                  fontFamily: FontFamily.semiBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress: $answered of $total questions',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Started: $startedOn',
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: AppColors.clr606060,
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

  Widget _buildRecentPerformanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4CAF50),
            const Color(0xFF2E7D32),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.trending_up,
            size: 40,
            color: AppColors.whiteColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Great Progress!',
                  style: TextStyleCustom.headingStyle(
                    fontSize: 18,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your average score improved by 12% this month',
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

  Widget _buildCompletedTestCard({
    required String title,
    required String subject,
    required int score,
    required int totalMarks,
    required double percentage,
    required int rank,
    required int totalStudents,
    required String completedOn,
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF4CAF50),
                  size: 20,
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
                    Text(
                      subject,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                completedOn,
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: AppColors.clr606060,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildScoreItem('Score', '$score/$totalMarks'),
              ),
              Expanded(
                child: _buildScoreItem('Percentage', '${percentage.toInt()}%'),
              ),
              Expanded(
                child: _buildScoreItem('Rank', '$rank/$totalStudents'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'View Analysis',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Retake Test',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyleCustom.headingStyle(
            fontSize: 16,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyleCustom.normalStyle(
            fontSize: 12,
            color: AppColors.clr606060,
          ),
        ),
      ],
    );
  }

  Widget _buildOverallPerformanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Performance',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceMetric(
                  'Tests Taken',
                  '15',
                  Icons.quiz,
                  AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: _buildPerformanceMetric(
                  'Average Score',
                  '78%',
                  Icons.grade,
                  const Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceMetric(
                  'Best Rank',
                  '12',
                  Icons.emoji_events,
                  const Color(0xFFFFD700),
                ),
              ),
              Expanded(
                child: _buildPerformanceMetric(
                  'Time Spent',
                  '45h',
                  Icons.access_time,
                  AppColors.redColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(String label, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyleCustom.headingStyle(
              fontSize: 20,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyleCustom.normalStyle(
              fontSize: 12,
              color: AppColors.clr606060,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectWisePerformance() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject-wise Performance',
            style: TextStyleCustom.headingStyle(
              fontSize: 16,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          _buildSubjectPerformanceItem('General Studies', 0.78, AppColors.primaryColor),
          _buildSubjectPerformanceItem('Mathematics', 0.85, const Color(0xFF4CAF50)),
          _buildSubjectPerformanceItem('Current Affairs', 0.72, const Color(0xFFFFA500)),
          _buildSubjectPerformanceItem('English', 0.68, AppColors.redColor),
        ],
      ),
    );
  }

  Widget _buildSubjectPerformanceItem(String subject, double score, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                '${(score * 100).toInt()}%',
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: color,
                  fontFamily: FontFamily.semiBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: score,
            backgroundColor: AppColors.clrD6D6D6,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyProgressChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Progress',
            style: TextStyleCustom.headingStyle(
              fontSize: 16,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMonthlyBar('Jan', 0.6),
              _buildMonthlyBar('Feb', 0.7),
              _buildMonthlyBar('Mar', 0.75),
              _buildMonthlyBar('Apr', 0.78),
              _buildMonthlyBar('May', 0.82),
              _buildMonthlyBar('Jun', 0.85),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trending_up,
                color: const Color(0xFF4CAF50),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '12% improvement this month',
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: const Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyBar(String month, double value) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 20,
          decoration: BoxDecoration(
            color: AppColors.clrD6D6D6.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80 * value,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: TextStyleCustom.normalStyle(
            fontSize: 10,
            color: AppColors.clr606060,
          ),
        ),
      ],
    );
  }

  Widget _buildWeakAreasCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.priority_high,
                color: AppColors.redColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Areas to Improve',
                style: TextStyleCustom.headingStyle(
                  fontSize: 16,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildWeakAreaItem('Logical Reasoning', '62%'),
          _buildWeakAreaItem('Data Interpretation', '58%'),
          _buildWeakAreaItem('Quantitative Aptitude', '65%'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.school, size: 16),
            label: const Text('Practice Weak Areas'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeakAreaItem(String area, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            area,
            style: TextStyleCustom.normalStyle(
              fontSize: 14,
              color: AppColors.blackColor,
            ),
          ),
          Text(
            score,
            style: TextStyleCustom.normalStyle(
              fontSize: 14,
              color: AppColors.redColor,
              fontFamily: FontFamily.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}