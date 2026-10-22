import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: GestureDetector(onTap: () => Navigator.pop(context),
          child: Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Save', style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.w700))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 16),
          Stack(alignment: Alignment.bottomRight, children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.border),
              child: const Icon(Icons.person_rounded, size: 44, color: AppColors.textMuted)),
            Container(width: 26, height: 26, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 13)),
          ]),
          const SizedBox(height: 24),
          const AppTextField(label: 'Full Name', hint: 'Vishal Singh'),
          const SizedBox(height: 16),
          const AppTextField(label: 'Email', hint: 'vishal@example.com', keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16),
          const AppTextField(label: 'College / University', hint: 'National Institute of Technology'),
          const SizedBox(height: 16),
          const AppTextField(label: 'Course', hint: 'B.Tech'),
          const SizedBox(height: 16),
          const AppTextField(label: 'Year of Study', hint: '4th Year (2025 Grad)'),
          const SizedBox(height: 16),
          const AppTextField(label: 'Branch / Specialization', hint: 'Computer Science & Engineering'),
          const SizedBox(height: 32),
          PrimaryButton(label: 'Save Changes', onTap: () => Navigator.pop(context)),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}
