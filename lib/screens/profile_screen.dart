import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import 'progress_history_screen.dart';
import 'skill_gap_screen.dart';
import 'login_screen.dart';
import 'resume_home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(onTap: () => Navigator.pop(context),
                  child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                    child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
                Text('Profile', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                  child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                    child: const Icon(Icons.settings_outlined, size: 18, color: AppColors.textPrimary)),
                ),
              ]),
            ),

            // Avatar
            const SizedBox(height: 8),
            Stack(alignment: Alignment.bottomRight, children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.border),
                child: const Icon(Icons.person_rounded, size: 44, color: AppColors.textMuted)),
              Container(width: 26, height: 26, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.edit_rounded, color: Colors.white, size: 13)),
            ]),
            const SizedBox(height: 12),
            Text('Vishal Singh', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text('vishal@example.com', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            PillChip(label: '🎓 Computer Science & Engineering'),
            const SizedBox(height: 24),

            // Academic info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Academic Information', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                    child: Text('Edit', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary))),
                ]),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(children: [
                    _AcadRow(icon: Icons.account_balance_outlined, label: 'College /\nUniversity', value: 'National Institute of Technology'),
                    const Divider(height: 1, indent: 56, color: AppColors.border),
                    _AcadRow(icon: Icons.school_outlined, label: 'Course', value: 'B.Tech'),
                    const Divider(height: 1, indent: 56, color: AppColors.border),
                    _AcadRow(icon: Icons.calendar_today_outlined, label: 'Year of Study', value: '4th Year (2025 Grad)'),
                    const Divider(height: 1, indent: 56, color: AppColors.border),
                    _AcadRow(icon: Icons.computer_outlined, label: 'Branch /\nSpecialization', value: 'Computer Science & Eng.'),
                  ]),
                ),
                const SizedBox(height: 24),

                Text('Account & Settings', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    AppListItem(icon: Icons.person_outline_rounded, title: 'Edit Profile', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(icon: Icons.trending_up_rounded, title: 'Progress & History', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressHistoryScreen()))),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(icon: Icons.analytics_outlined, title: 'Skill Gap Analysis', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SkillGapScreen()))),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(icon: Icons.description_outlined, title: 'Resume Builder', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResumeHomeScreen()))),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(
                      icon: Icons.notifications_outlined, title: 'Notifications',
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)),
                          child: Text('2', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white))),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
                      ]),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(icon: Icons.settings_outlined, title: 'Settings', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(icon: Icons.help_outline_rounded, title: 'Help & Support'),
                    const Divider(height: 1, color: AppColors.border),
                    AppListItem(icon: Icons.info_outline_rounded, title: 'About Placement Prep'),
                  ]),
                ),
                const SizedBox(height: 20),

                // Logout
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false),
                  child: Container(
                    width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.logout_rounded, color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text('Log Out', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ]),
                  ),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _AcadRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _AcadRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 18, color: AppColors.textMuted),
        const SizedBox(width: 12),
        SizedBox(width: 120, child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.4))),
        Expanded(child: Text(value, textAlign: TextAlign.right, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4))),
      ]),
    );
  }
}
