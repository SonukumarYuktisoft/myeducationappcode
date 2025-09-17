import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/core/utils/text.dart';
import 'package:education/view/my_batches/live_class_screen.dart';
import 'package:education/view/my_batches/my_batches.dart';
import 'package:flutter/material.dart';


class BatchDetailScreen extends StatefulWidget {
  final CourseOverview item;
  BatchDetailScreen({super.key,required this.item});

  @override
  State<BatchDetailScreen> createState() => _BatchDetailScreenState();
}

class _BatchDetailScreenState extends State<BatchDetailScreen>
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
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Hero(
                  tag: widget.item,
                  child: _buildOverviewCard(widget.item)),
                _buildCurriculumTab(),
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
        'Bacth Details',
        style: TextStyleCustom.headingStyle(
          fontSize: 20,
          color: AppColors.blackColor,
        ),
      ),
      actions: [
        Container(
          height: 28,
          width: 55,
          margin: EdgeInsets.only(right: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.primaryColor
          ),
          child: BuildText.buildText(text: 'Paid',color: AppColors.whiteColor),
        )
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
          Tab(text: 'Overview'),
          Tab(text: 'Curriculum'),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(CourseOverview item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12,left: 15,right: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildText.buildText(text: "Course Overview"),
          const SizedBox(height: 12),
           Container(
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
        ),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.menu_book, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyleCustom.headingStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _kv('Start date', item.startDate),
          const SizedBox(height: 12),
          _kv('Duration', item.duration),
          const SizedBox(height: 12),
          _kv('Teacher', item.teacher),
          const SizedBox(height: 12),
          _kv('Paid', item.isPaid ? 'Yes' : 'No'),

          buildSizeBox(20.0, 0.0),
          BuildText.buildText(text: "Targeted",fontFamily: FontFamily.semiBold),
          buildSizeBox(10.0, 0.0),
          Wrap(
            spacing: 6,
            runSpacing: -8,
            children: item.categories
                .map((c) => _chip(c, AppColors.primaryColor))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ---------------- Curriculum Tab ----------------
  Widget _buildCurriculumTab() {
    final subjects = <_SubjectItem>[
      const _SubjectItem(title: 'Science - Light'),
      const _SubjectItem(title: 'Mathematics - Algebra'),
      const _SubjectItem(title: 'GK/GS - Polity'),
      const _SubjectItem(title: 'Reasoning - Series'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildSubjectTile(subjects[index]);
      },
    );
  }

  Widget _buildSubjectTile(_SubjectItem item) {
    return InkWell(
      onTap: () => _openTopicsBottomSheet(item),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
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
              child: Icon(Icons.menu_book, color: AppColors.primaryColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: TextStyleCustom.headingStyle(
                  fontSize: 15,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _openTopicsBottomSheet(_SubjectItem subject) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final topics = <_TopicItem>[
          const _TopicItem(title: 'Introduction and basics', status: _TopicStatus.upcoming),
          const _TopicItem(title: 'Core concepts and derivations', status: _TopicStatus.live),
          const _TopicItem(title: 'Practice questions set 1', status: _TopicStatus.completed),
          const _TopicItem(title: 'Practice questions set 2', status: _TopicStatus.completed),
        ];

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.clrD6D6D6,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject.title,
                          style: TextStyleCustom.headingStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: topics.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildTopicRow(topics[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopicRow(_TopicItem topic) {
    List<Widget> actions = [];
    switch (topic.status) {
      case _TopicStatus.live:
        actions = [
          _statusPill('Live', AppColors.primaryColor),
          const SizedBox(width: 8),
          _primaryButton('Join', onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const LiveClassScreen(),
              ),
            );
          }),
        ];
        break;
      case _TopicStatus.completed:
        actions = [
          _outlineButton('View'),
          const SizedBox(width: 8),
          _outlineButton('Notes'),
        ];
        break;
      case _TopicStatus.upcoming:
        actions = [
          _statusPill('Upcoming', const Color(0xFFFFA500)),
        ];
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              topic.title,
              style: TextStyleCustom.normalStyle(
                fontSize: 14,
                color: AppColors.blackColor,
                fontFamily: FontFamily.semiBold,
              ),
            ),
          ),
          ...actions,
        ],
      ),
    );
  }

  // ---------------- UI helpers ----------------
  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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

class _SubjectItem {
  final String title;
  const _SubjectItem({required this.title});
}

enum _TopicStatus { live, completed, upcoming }

class _TopicItem {
  final String title;
  final _TopicStatus status;
  const _TopicItem({required this.title, required this.status});
}