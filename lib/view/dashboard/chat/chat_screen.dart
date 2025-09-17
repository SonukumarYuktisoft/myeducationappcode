import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/view/dashboard/chat/chat_with_ai.dart';
import 'package:education/view/dashboard/chat/conversation_screen.dart';
import 'package:education/view/dashboard/chat/support_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                _buildInstructorsTab(),
                _buildSupportTab(),
                _buildGroupsTab(),
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
        'Chat',
        style: TextStyleCustom.headingStyle(
          fontSize: 20,
          color: AppColors.blackColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: AppColors.blackColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: AppColors.blackColor),
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
          Tab(text: 'Instructors'),
          Tab(text: 'Support'),
          Tab(text: 'Groups'),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> instructors = [
    {
      "name": "Demis Hassabis",
      "subject": "UPSC History",
      "lastMessage": "Good morning! Today we will discuss...",
      "time": "9:30 AM",
      "isOnline": true,
      "unreadCount": 2,
      "image": "assets/png/teachers_image/DemisHassabis.jpg",
    },
    {
      "name": "Prof. Anjali Sharma",
      "subject": "Mathematics",
      "lastMessage": "Please solve the practice questions",
      "time": "8:45 AM",
      "isOnline": false,
      "unreadCount": 0,
      "image": "assets/png/teachers_image/femaleTeacher.jpg",
    },
    {
      "name": "Ian Goodfellow",
      "subject": "Current Affairs",
      "lastMessage": "Weekly quiz results are out",
      "time": "Yesterday",
      "isOnline": true,
      "unreadCount": 5,
      "image": "assets/png/teachers_image/IanGoodfellow.jpg",
    },
    {
      "name": "Sam Altman",
      "subject": "English",
      "lastMessage": "Grammar exercises uploaded",
      "time": "2 days ago",
      "isOnline": false,
      "unreadCount": 1,
      "image": "assets/png/teachers_image/SamAltman.jpg",
    },
  ];

  Widget _buildInstructorsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildQuickAccessCard(),
          // const SizedBox(height: 20),
          // Text(
          //   'Your Instructors',
          //   style: TextStyleCustom.headingStyle(
          //     fontSize: 18,
          //     color: AppColors.blackColor,
          //   ),
          // ),
          // const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: instructors.length,
            itemBuilder: (context, index) {
              final instructor = instructors[index];
              return _buildInstructorChatCard(
                name: instructor["name"],
                subject: instructor["subject"],
                lastMessage: instructor["lastMessage"],
                time: instructor["time"],
                isOnline: instructor["isOnline"],
                unreadCount: instructor["unreadCount"],
                image: instructor["image"], // 👈 new key
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSupportOptionsCard(),
          const SizedBox(height: 20),
          Text(
            'Recent Support Chats',
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
              return _buildSupportChatCard(
                title:
                    index == 0
                        ? 'Course Access Issue'
                        : index == 1
                        ? 'Payment Query'
                        : 'Technical Support',
                ticketId:
                    index == 0
                        ? '#TKT-001234'
                        : index == 1
                        ? '#TKT-001235'
                        : '#TKT-001236',
                status:
                    index == 0
                        ? 'Resolved'
                        : index == 1
                        ? 'In Progress'
                        : 'Open',
                lastMessage:
                    index == 0
                        ? 'Thank you for your help!'
                        : index == 1
                        ? 'Please check your email for refund details'
                        : 'I am facing login issues',
                time:
                    index == 0
                        ? '2 hours ago'
                        : index == 1
                        ? '1 day ago'
                        : '3 days ago',
              );
            },
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> groupsData = [
    {
      "groupName": "UPSC 2025 Aspirants",
      "members": 156,
      "lastMessage": "Rahul: Can someone explain this concept?",
      "time": "10 min ago",
      "unreadCount": 12,
      "image": "assets/png/groups_images/upsc.jpg", // 👈 group icon
    },
    {
      "groupName": "SSC CGL Study Group",
      "members": 89,
      "lastMessage": "Anjali: Sharing important notes",
      "time": "1 hour ago",
      "unreadCount": 5,
      "image": "assets/png/groups_images/ssc.jpg",
    },
    {
      "groupName": "Current Affairs Discussion",
      "members": 234,
      "lastMessage": "Vikash: Today's current affairs quiz",
      "time": "2 hours ago",
      "unreadCount": 8,
      "image": "assets/png/groups_images/current.jpg",
    },
    {
      "groupName": "Mathematics Problem Solving",
      "members": 67,
      "lastMessage": "Priya: Solution to yesterday's problem",
      "time": "5 hours ago",
      "unreadCount": 0,
      "image": "assets/png/groups_images/math.jpg",
    },
    {
      "groupName": "BPSC Preparation",
      "members": 112,
      "lastMessage": "Kumar: Mock test results discussion",
      "time": "Yesterday",
      "unreadCount": 3,
      "image": "assets/png/groups_images/bpsc.jpg",
    },
  ];

  Widget _buildGroupsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Study Groups',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupsData.length,
            itemBuilder: (context, index) {
              return _buildGroupChatCard(
                groupName: groupsData[index]['groupName'],
                members: groupsData[index]['members'],
                lastMessage: groupsData[index]['lastMessage'],
                time: groupsData[index]['time'],
                unreadCount: groupsData[index]['unreadCount'],
                image: groupsData[index]["image"],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.help_outline,
                  label: 'Ask Doubt',
                  onTap: () {
                    Get.to(() => ChatWithAiScreen());
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.support_agent,
                  label: 'Contact Support',
                  onTap: () {
                    Get.to(() => SupportChatScreen());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyleCustom.normalStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOptionsCard() {
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
            'Need Help?',
            style: TextStyleCustom.headingStyle(
              fontSize: 16,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => SupportChatScreen());
                  },
                  child: _buildSupportOption(
                    icon: Icons.chat_bubble_outline,
                    label: 'Live Chat',
                    subtitle: 'Chat with support team',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => SupportChatScreen());
                  },
                  child: _buildSupportOption(
                    icon: Icons.email_outlined,
                    label: 'Email Support',
                    subtitle: 'Send us an email',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String label,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyleCustom.normalStyle(
              fontSize: 12,
              color: AppColors.blackColor,
              fontFamily: FontFamily.semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyleCustom.normalStyle(
              fontSize: 10,
              color: AppColors.clr606060,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorChatCard({
    required String name,
    required String subject,
    required String lastMessage,
    required String time,
    required bool isOnline,
    required int unreadCount,
    required String image, // 👈 new key
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ConversationScreen(
            instructorName: name,
            subject: subject,
            isOnline: isOnline,
            image: image, // 👈 new key
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(image),
                  radius: 25,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  // child: Text(

                  //   name.split(' ').map((e) => e[0]).take(2).join(),
                  //   style: TextStyleCustom.normalStyle(
                  //     fontSize: 16,
                  //     color: AppColors.primaryColor,
                  //     fontFamily: FontFamily.semiBold,
                  //   ),
                  // ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 12,
                          color: AppColors.clr606060,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subject,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyleCustom.normalStyle(
                            fontSize: 13,
                            color: AppColors.clr606060,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            unreadCount.toString(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportChatCard({
    required String title,
    required String ticketId,
    required String status,
    required String lastMessage,
    required String time,
  }) {
    Color statusColor =
        status == 'Resolved'
            ? const Color(0xFF4CAF50)
            : status == 'In Progress'
            ? const Color(0xFFFFA500)
            : AppColors.redColor;

    return GestureDetector(
      onTap: () {
        // Navigate to support chat
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyleCustom.normalStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontFamily: FontFamily.semiBold,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontFamily: FontFamily.semiBold,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 12,
                        color: AppColors.clr606060,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  ticketId,
                  style: TextStyleCustom.normalStyle(
                    fontSize: 12,
                    color: AppColors.clr606060,
                  ),
                ),
                // const SizedBox(width: 12),
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 8,
                //     vertical: 2,
                //   ),
                //   decoration: BoxDecoration(
                //     color: statusColor.withOpacity(0.1),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Text(
                //     status,
                //     style: TextStyleCustom.normalStyle(
                //       fontSize: 10,
                //       color: statusColor,
                //       fontFamily: FontFamily.semiBold,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              lastMessage,
              style: TextStyleCustom.normalStyle(
                fontSize: 13,
                color: AppColors.clr606060,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupChatCard({
    required String groupName,
    required int members,
    required String lastMessage,
    required String time,
    required int unreadCount,
    required String image,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ConversationScreen(
            isGroup: false,
            instructorName: groupName,
            isOnline: true,
            subject: '$members members',
            image: image,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 25,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              // child: Icon(Icons.group, color: AppColors.primaryColor, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          groupName,
                          style: TextStyleCustom.normalStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontFamily: FontFamily.semiBold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 12,
                          color: AppColors.clr606060,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$members members',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyleCustom.normalStyle(
                            fontSize: 13,
                            color: AppColors.clr606060,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            unreadCount.toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}
