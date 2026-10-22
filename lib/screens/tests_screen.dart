import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'test_setup_screen.dart';
import 'reports_screen.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});
  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  String _tab = 'All';
  final _tabs = ['All', 'Aptitude', 'Reasoning', 'Verbal', 'Technical'];

  final _categories = [
    (Icons.bar_chart_rounded, 'Quantitative Aptitude', 'Numbers, percentages, ratios and more', '35 Tests • 700+ Qs'),
    (Icons.psychology_rounded, 'Logical Reasoning', 'Puzzles, syllogisms, blood relations & series', '28 Tests • 560+ Qs'),
    (Icons.menu_book_rounded, 'Verbal Ability', 'Reading comprehension, grammar & vocabulary', '24 Tests • 480+ Qs'),
    (Icons.computer_rounded, 'Technical', 'Data structures, DBMS, OS & core concepts', '40 Tests • 800+ Qs'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                      child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                      child: const Icon(Icons.bar_chart_rounded, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                Text('Practice Tests', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Sharpen your placement skills.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 16),
              ]),
            ),

            // Tabs
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _tabs.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final t = _tabs[i];
                  final active = t == _tab;
                  return GestureDetector(
                    onTap: () => setState(() => _tab = t),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(t, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: active ? Colors.white : AppColors.textSecondary)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Featured card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                      child: Row(children: [
                        const Icon(Icons.star_rounded, color: AppColors.primary, size: 14),
                        const SizedBox(width: 4),
                        Text('Recommended for Vishal', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      ]),
                    ),
                    Text('Free Access', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                  ]),
                  const SizedBox(height: 12),
                  Text('Placement Aptitude Test', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Standard placement assessment covering core numerical reasoning and speed math.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, children: [
                    _InfoTag(icon: Icons.quiz_outlined, label: '20 Questions'),
                    _InfoTag(icon: Icons.timer_outlined, label: '20 Minutes'),
                    _InfoTag(icon: Icons.signal_cellular_alt_1_bar_rounded, label: 'Easy'),
                  ]),
                  const SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(children: [
                      const Icon(Icons.group_outlined, size: 16, color: AppColors.textMuted),
                      const SizedBox(width: 5),
                      Text('12.4k taken', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    ]),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestSetupScreen())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary, foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('Start Test', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ]),
                ]),
              ),
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SectionHeader(title: 'Explore by Category', actionLabel: 'View All', onAction: () {}),
                const SizedBox(height: 14),
                ..._categories.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CategoryCard(
                    icon: c.$1, title: c.$2, subtitle: c.$3, badge: c.$4,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestSetupScreen())),
                  ),
                )),
                const SizedBox(height: 8),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
      ]),
    );
  }
}
