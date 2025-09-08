import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_family.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/core/utils/text.dart';
import 'package:education/routes/route_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatsCard(),
                  const SizedBox(height: 24),
                  _buildMenuSection('Account Settings', [
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      subtitle: 'Update your details',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      subtitle: 'Update your password',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Manage your preferences',
                      onTap: () {},
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: AppColors.primaryColor,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildMenuSection('Learning', [
                    _buildMenuItem(
                      icon: Icons.bookmark_outline,
                      title: 'My Courses',
                      subtitle: 'View enrolled courses',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.download_outlined,
                      title: 'Downloads',
                      subtitle: 'Offline content',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.file_copy,
                      title: 'Certificates',
                      subtitle: 'View achievements',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.analytics_outlined,
                      title: 'Progress Report',
                      subtitle: 'Track your performance',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildMenuSection('Support', [
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      subtitle: 'Get assistance',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.feedback_outlined,
                      title: 'Feedback',
                      subtitle: 'Share your thoughts',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      title: 'About',
                      subtitle: 'App information',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 32),
                  _buildLogoutButton(),
                  const SizedBox(height: 20),
                  _buildVersionInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: AppColors.linearButtonColor,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                _buildProfileImage(),
                const SizedBox(height: 16),
                Text(
                  'Rajesh Kumar Singh',
                  style: TextStyleCustom.headingStyle(
                    fontSize: 24,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Student ID: EDU2024001',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'UPSC Aspirant',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.whiteColor,
                      fontFamily: FontFamily.medium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // title: Text(
        //   'Profile',
        //   style: TextStyleCustom.headingStyle(
        //     fontSize: 20,
        //     color: AppColors.whiteColor,
        //   ),
        // ),
      ),
      actions: [
        IconButton(
          onPressed: () => _showEditProfileDialog(),
          icon: Icon(
            Icons.edit,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.whiteColor, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 46,
            backgroundColor: AppColors.whiteColor,
            child: Text(
              'RK',
              style: TextStyleCustom.headingStyle(
                fontSize: 32,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.camera_alt,
              color: AppColors.primaryColor,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '3',
              'Courses\nEnrolled',
              Icons.book_outlined,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColors.clrD6D6D6,
          ),
          Expanded(
            child: _buildStatItem(
              '127',
              'Hours\nStudied',
              Icons.access_time,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColors.clrD6D6D6,
          ),
          Expanded(
            child: _buildStatItem(
              '2',
              'Certificates\nEarned',
              Icons.emoji_events,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          number,
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyleCustom.normalStyle(
            fontSize: 12,
            color: AppColors.clr606060,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.blackColor,
            ),
          ),
        ),
        Container(
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
            border: Border.all(color: AppColors.clrD6D6D6.withOpacity(0.3)),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      color: AppColors.clrD6D6D6.withOpacity(0.5),
                      indent: 60,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: TextStyleCustom.normalStyle(
          fontSize: 16,
          color: AppColors.blackColor,
          fontFamily: FontFamily.semiBold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyleCustom.normalStyle(
          fontSize: 12,
          color: AppColors.clr606060,
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.clr606060,
            size: 16,
          ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.redColor, width: 1.5),
      ),
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.redColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        icon: const Icon(Icons.logout, size: 20),
        label: Text(
          'Logout',
          style: TextStyleCustom.normalStyle(
            fontSize: 16,
            color: AppColors.redColor,
            fontFamily: FontFamily.semiBold,
          ),
        ),
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Text(
      'Version 1.0.0',
      style: TextStyleCustom.normalStyle(
        fontSize: 12,
        color: AppColors.clr606060,
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Edit Profile',
          style: TextStyleCustom.headingStyle(
            fontSize: 18,
            color: AppColors.blackColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyleCustom.normalStyle(color: AppColors.clr606060),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyleCustom.normalStyle(color: AppColors.clr606060),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyleCustom.normalStyle(color: AppColors.clr606060),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Save',
              style: TextStyleCustom.normalStyle(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Logout',
          style: TextStyleCustom.headingStyle(
            fontSize: 18,
            color: AppColors.blackColor,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyleCustom.normalStyle(color: AppColors.clr606060),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyleCustom.normalStyle(color: AppColors.clr606060),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(RouteNavigation.loginScreenRoute);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Logout',
              style: TextStyleCustom.normalStyle(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}