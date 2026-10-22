import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifs = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: GestureDetector(onTap: () => Navigator.pop(context),
          child: Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 8),
          Text('ACCOUNT', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.1)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              AppListItem(icon: Icons.person_outline_rounded, title: 'Edit Profile', iconColor: AppColors.primary),
              const Divider(height: 1, color: AppColors.border),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.notifications_outlined, color: AppColors.primary, size: 20)),
                title: Text('Notifications', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                trailing: Switch(value: _notifs, onChanged: (v) => setState(() => _notifs = v), activeThumbColor: AppColors.primary),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          Text('PRIVACY', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.1)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              AppListItem(icon: Icons.lock_outline_rounded, title: 'Privacy Settings', iconColor: AppColors.primary),
              const Divider(height: 1, color: AppColors.border),
              AppListItem(icon: Icons.help_outline_rounded, title: 'Help & Support', iconColor: AppColors.primary),
            ]),
          ),
          const SizedBox(height: 20),
          Text('APP', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.1)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.dark_mode_outlined, color: AppColors.primary, size: 20)),
                title: Text('Dark Mode', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                trailing: Switch(value: _darkMode, onChanged: (v) => setState(() => _darkMode = v), activeThumbColor: AppColors.primary),
              ),
              const Divider(height: 1, color: AppColors.border),
              AppListItem(icon: Icons.info_outline_rounded, title: 'About Placement Prep', iconColor: AppColors.primary),
              const Divider(height: 1, color: AppColors.border),
              AppListItem(
                icon: Icons.check_circle_outline_rounded, title: 'App Version',
                iconColor: AppColors.primary,
                trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(20)),
                  child: Text('1.0.0', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
              ),
            ]),
          ),
          const SizedBox(height: 32),
          Center(child: Text('Crafted for Placement Success', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted))),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}
