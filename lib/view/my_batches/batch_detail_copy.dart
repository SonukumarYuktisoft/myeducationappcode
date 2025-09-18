import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/core/utils/text.dart';
import 'package:education/model/CourseModel/course_model.dart';
import 'package:education/model/CourseModel/course_overview.dart';
import 'package:education/view/my_batches/live_class_screen.dart';
import 'package:education/view/my_batches/my_batches.dart';
import 'package:education/view/my_batches/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class BatchDetailCopy extends StatefulWidget {
  final CourseModel item;
  
  BatchDetailCopy({super.key, required this.item});

  @override
  State<BatchDetailCopy> createState() => _BatchDetailCopyState();
}

class _BatchDetailCopyState extends State<BatchDetailCopy>
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
                Hero(tag: widget.item, child: _buildOverviewCard(widget.item)),
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
        'My Batches',
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
            color: widget.item.isPaid ? AppColors.primaryColor : Colors.green,
          ),
          child: BuildText.buildText(
            text: widget.item.isPaid ? 'Paid' : 'Free', 
            color: AppColors.whiteColor
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
        tabs: const [Tab(text: 'Overview'), Tab(text: 'Curriculum')],
      ),
    );
  }

  Widget _buildOverviewCard(CourseModel item) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 12, left: 15, right: 15),
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
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.bannerUrl),
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
              ),
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
                          item.title,
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
              _kv('Start date', _formatDate(item.startDate)),
              const SizedBox(height: 12),
              _kv('Duration', item.duration),
              const SizedBox(height: 12),
              _kv('Teacher', item.instructor.name),
              const SizedBox(height: 12),
              _kv('Type', item.isPaid ? 'Paid' : 'Free'),
              const SizedBox(height: 12),
              _kv('Classes', '${item.totalClasses} total'),
              const SizedBox(height: 12),
              _kv('Language', item.language),
        
              buildSizeBox(20.0, 0.0),
              BuildText.buildText(
                text: "Targeted Exams",
                fontFamily: FontFamily.semiBold,
              ),
              buildSizeBox(10.0, 0.0),
              Wrap(
                spacing: 6,
                runSpacing: -8,
                children: item.target.related.map((exam) => _chip(exam, AppColors.primaryColor)).toList(),
              ),
              
              buildSizeBox(20.0, 0.0),
              BuildText.buildText(
                text: "Syllabus",
                fontFamily: FontFamily.semiBold,
              ),
              buildSizeBox(10.0, 0.0),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: item.syllabus.map((subject) => _chip(subject, Colors.blue)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Curriculum Tab ----------------
  Widget _buildCurriculumTab() {
    if (widget.item.curriculum.isEmpty) {
      return Center(
        child: Text(
          'No curriculum available',
          style: TextStyleCustom.normalStyle(
            fontSize: 14,
            color: AppColors.clr606060,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.item.curriculum.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final section = widget.item.curriculum[index];
        return _buildSubjectTile(section);
      },
    );
  }

  Widget _buildSubjectTile(CurriculumSection section) {
    return InkWell(
      onTap: () => _openTopicsBottomSheet(section),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.sectionTitle,
                    style: TextStyleCustom.headingStyle(
                      fontSize: 15,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    '${section.classes.length} classes',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.clr606060,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _openTopicsBottomSheet(CurriculumSection section) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
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
                          section.sectionTitle,
                          style: TextStyleCustom.headingStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: section.classes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildTopicRow(section.classes[index]);
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

  Widget _buildTopicRow(Class classItem) {
    List<Widget> actions = [];
    
    // Determine class status and actions based on business logic
    if (!widget.item.isPaid || widget.item.isEnrolled || classItem.isDemo) {
      // Free course, enrolled in paid course, or demo class
      if (classItem.isLocked) {
        // Locked class
        actions = [_statusPill('Upcoming', const Color(0xFFFFA500))];
      } else {
        // Available class
        if (classItem.videoUrl.isNotEmpty) {
          // Has video content - could be live or recorded
          if (_isLiveClass(classItem)) {
            actions = [
              _statusPill('Live', AppColors.primaryColor),
              const SizedBox(width: 8),
              _primaryButton('Join', onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LiveClassScreen()),
                );
              }),
            ];
          } else {
            // Completed/recorded class
            actions = [
              _outlineButton('View', onPressed: () {
                print('akljfkla');
             Get.to(()=>  VideoPlayerScreen(youtubeUrl: 'https://youtu.be/enY83Li8_ps?si=ErkiCJo_g4izyDql'));
              }),
              const SizedBox(width: 8),
              _outlineButton('Notes', onPressed: () {
                // Handle viewing notes
              }),
            ];
          }
        } else {
          actions = [_statusPill('Upcoming', const Color(0xFFFFA500))];
        }
      }
    } else {
      // Paid course, not enrolled, not demo
      actions = [
        _statusPill('Locked', Colors.red),
        const SizedBox(width: 8),
        _primaryButton('Enroll', onPressed: () {
          _showEnrollDialog();
        }),
      ];
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: (!widget.item.isPaid || widget.item.isEnrolled || classItem.isDemo)
              ? AppColors.clrD6D6D6.withOpacity(0.5)
              : Colors.red.withOpacity(0.3)
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Lock icon for paid locked content
          if (widget.item.isPaid && !widget.item.isEnrolled && !classItem.isDemo)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.lock, size: 16, color: Colors.red),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classItem.title,
                  style: TextStyleCustom.normalStyle(
                    fontSize: 14,
                    color: (!widget.item.isPaid || widget.item.isEnrolled || classItem.isDemo)
                        ? AppColors.blackColor
                        : Colors.red.shade700,
                    fontFamily: FontFamily.semiBold,
                  ),
                ),
                if (classItem.isDemo)
                  Text(
                    'Demo Class',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 11,
                      color: Colors.blue,
                      fontFamily: FontFamily.medium,
                    ),
                  ),
              ],
            ),
          ),
          ...actions,
        ],
      ),
    );
  }

  // Helper method to determine if a class is currently live
  bool _isLiveClass(Class classItem) {
    // This would typically check against current time and scheduled class time
    // For demo purposes, we'll simulate this
    return classItem.title.toLowerCase().contains('core concepts') && 
           classItem.videoUrl.isNotEmpty;
  }

  void _showEnrollDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enroll in Course'),
        content: Text(
          'To access this content, you need to enroll in "${widget.item.title}". '
          'Price: ₹${widget.item.discountPrice > 0 ? widget.item.discountPrice : widget.item.price}'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle enrollment logic here
            },
            child: Text('Enroll Now'),
          ),
        ],
      ),
    );
  }

  // ---------------- UI helpers ----------------
  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  Widget _outlineButton(String text,{required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
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

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}