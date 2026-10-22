// ─── Shared Widgets ────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

// ─── App Logo Icon ──────────────────────────────────────────────────────────
class AppLogoIcon extends StatelessWidget {
  final double size;
  const AppLogoIcon({super.key, this.size = 52});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(size * 0.27),
      ),
      child: Center(
        child: Icon(Icons.school_rounded, color: AppColors.primary, size: size * 0.52),
      ),
    );
  }
}

// ─── Primary Button ──────────────────────────────────────────────────────────
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool loading;

  const PrimaryButton({super.key, required this.label, this.onTap, this.icon, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 52,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: loading
            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
            : Row(mainAxisSize: MainAxisSize.min, children: [
                if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
                Text(label, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
              ]),
      ),
    );
  }
}

// ─── Outline Button ──────────────────────────────────────────────────────────
class OutlineButton2 extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;

  const OutlineButton2({super.key, required this.label, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
          Text(label, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

// ─── App Text Field ──────────────────────────────────────────────────────────
class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffix;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffix,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.obscure;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      const SizedBox(height: 6),
      TextField(
        controller: widget.controller,
        obscureText: isPassword ? _hidden : false,
        keyboardType: widget.keyboardType,
        style: GoogleFonts.inter(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(_hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textMuted, size: 20),
                  onPressed: () => setState(() => _hidden = !_hidden),
                )
              : widget.suffix,
        ),
      ),
    ]);
  }
}

// ─── Section Header ──────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      if (actionLabel != null)
        GestureDetector(
          onTap: onAction,
          child: Text(actionLabel!, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ),
    ]);
  }
}

// ─── Progress Bar ────────────────────────────────────────────────────────────
class AppProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color? color;
  final double height;

  const AppProgressBar({super.key, required this.value, this.color, this.height = 6});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: AppColors.primaryLight,
        valueColor: AlwaysStoppedAnimation(color ?? AppColors.primary),
      ),
    );
  }
}

// ─── Pill Chip ───────────────────────────────────────────────────────────────
class PillChip extends StatelessWidget {
  final String label;
  final Color? bg;
  final Color? fg;

  const PillChip({super.key, required this.label, this.bg, this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg ?? AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: fg ?? AppColors.primary)),
    );
  }
}

// ─── Select Chip Group ────────────────────────────────────────────────────────
class SelectChipGroup extends StatelessWidget {
  final List<String> options;
  final String selected;
  final void Function(String) onSelect;

  const SelectChipGroup({super.key, required this.options, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, runSpacing: 10, children: options.map((opt) {
      final isSelected = opt == selected;
      return GestureDetector(
        onTap: () => onSelect(opt),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : AppColors.surface,
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(opt, style: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          )),
        ),
      );
    }).toList());
  }
}

// ─── MCQ Option Row ───────────────────────────────────────────────────────────
enum OptionState { normal, selected, correct, wrong }

class McqOption extends StatelessWidget {
  final String letter;
  final String text;
  final OptionState state;
  final VoidCallback onTap;

  const McqOption({super.key, required this.letter, required this.text, required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color bg, borderColor, letterBg, letterFg;
    switch (state) {
      case OptionState.selected:
        bg = AppColors.primaryLight; borderColor = AppColors.primary;
        letterBg = AppColors.primary; letterFg = Colors.white;
        break;
      case OptionState.correct:
        bg = AppColors.successLight; borderColor = AppColors.success;
        letterBg = AppColors.success; letterFg = Colors.white;
        break;
      case OptionState.wrong:
        bg = AppColors.errorLight; borderColor = AppColors.error;
        letterBg = AppColors.error; letterFg = Colors.white;
        break;
      default:
        bg = AppColors.surface; borderColor = AppColors.border;
        letterBg = AppColors.surfaceVariant; letterFg = AppColors.textSecondary;
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(color: letterBg, shape: BoxShape.circle),
            child: Center(child: Text(letter, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: letterFg))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 15, color: AppColors.textPrimary))),
          if (state == OptionState.correct) const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
          if (state == OptionState.wrong)   const Icon(Icons.cancel_rounded, color: AppColors.error, size: 20),
        ]),
      ),
    );
  }
}

// ─── List Item (Profile Menu style) ──────────────────────────────────────────
class AppListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? iconBg;

  const AppListItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: iconBg ?? AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: iconColor ?? AppColors.textSecondary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(subtitle!, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ])),
          trailing ?? const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
        ]),
      ),
    );
  }
}

// ─── Code Block ──────────────────────────────────────────────────────────────
class CodeBlock extends StatelessWidget {
  final String code;
  final String language;
  final bool showLineNumbers;

  const CodeBlock({super.key, required this.code, this.language = 'PYTHON', this.showLineNumbers = false});

  @override
  Widget build(BuildContext context) {
    final lines = code.split('\n');
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(99))),
              const SizedBox(width: 5),
              Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.warning, borderRadius: BorderRadius.circular(99))),
              const SizedBox(width: 5),
              Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(99))),
            ]),
            Text(language, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.08)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (int i = 0; i < lines.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (showLineNumbers) ...[
                    SizedBox(width: 20, child: Text('${i + 1}', style: GoogleFonts.robotoMono(fontSize: 13, color: AppColors.textMuted))),
                    const SizedBox(width: 10),
                  ],
                  Expanded(child: Text(lines[i], style: GoogleFonts.robotoMono(fontSize: 13, color: AppColors.textPrimary))),
                ]),
              ),
          ]),
        ),
      ]),
    );
  }
}

// ─── Timer Badge ──────────────────────────────────────────────────────────────
class TimerBadge extends StatelessWidget {
  final String time;
  const TimerBadge({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.timer_outlined, size: 15, color: AppColors.primary),
        const SizedBox(width: 5),
        Text(time, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
      ]),
    );
  }
}

// ─── Info Note Box ────────────────────────────────────────────────────────────
class InfoBox extends StatelessWidget {
  final String text;
  final Color? bg;
  final Color? fg;
  final IconData? icon;

  const InfoBox({super.key, required this.text, this.bg, this.fg, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (fg ?? AppColors.primary).withAlpha(40)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon ?? Icons.info_outline_rounded, size: 16, color: fg ?? AppColors.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary))),
      ]),
    );
  }
}

// ─── Category Card ────────────────────────────────────────────────────────────
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;

  const CategoryCard({super.key, required this.icon, required this.title, required this.subtitle, this.badge, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 4, offset: const Offset(0, 1))],
        ),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(subtitle, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
            if (badge != null) ...[
              const SizedBox(height: 6),
              PillChip(label: badge!, bg: AppColors.surfaceVariant, fg: AppColors.textSecondary),
            ],
          ])),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
        ]),
      ),
    );
  }
}

// ─── Waveform Animation ────────────────────────────────────────────────────────
class WaveformWidget extends StatefulWidget {
  const WaveformWidget({super.key});
  @override
  State<WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final List<double> _heights = [8, 20, 14, 28, 18, 24, 10, 22, 16];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_heights.length, (i) {
      final c = AnimationController(vsync: this, duration: Duration(milliseconds: 800 + i * 80));
      c.repeat(reverse: true);
      return c;
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_heights.length, (i) {
        return AnimatedBuilder(
          animation: _controllers[i],
          builder: (_, _) => Container(
            width: 3,
            height: _heights[i] * (0.5 + 0.5 * _controllers[i].value),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        );
      }),
    );
  }
}
