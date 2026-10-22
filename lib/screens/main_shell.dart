import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import 'home_screen.dart';
import 'tests_screen.dart';
import 'coding_home_screen.dart';
import 'interview_home_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  final _screens = const [
    HomeScreen(),
    TestsScreen(),
    CodingHomeScreen(),
    InterviewHomeScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _BottomNav(
        current: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int current;
  final void Function(int) onTap;
  const _BottomNav({required this.current, required this.onTap});

  static const _items = [
    (Icons.home_rounded, Icons.home_outlined, 'Home'),
    (Icons.school_rounded, Icons.school_outlined, 'Tests'),
    (Icons.code_rounded, Icons.code_rounded, 'Coding'),
    (Icons.chat_bubble_rounded, Icons.chat_bubble_outline_rounded, 'Interview'),
    (Icons.person_rounded, Icons.person_outline_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(_items.length, (i) {
              final (activeIcon, inactiveIcon, label) = _items[i];
              final isActive = i == current;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        isActive ? activeIcon : inactiveIcon,
                        key: ValueKey(isActive),
                        color: isActive ? AppColors.primary : AppColors.textMuted,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(label, style: GoogleFonts.inter(
                      fontSize: 11, fontWeight: FontWeight.w500,
                      color: isActive ? AppColors.primary : AppColors.textMuted,
                    )),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
