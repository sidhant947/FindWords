import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_theme.dart';
import '../providers/theme_provider.dart';

class HowToPlayScreen extends ConsumerWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: appTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: appTheme.appBarFg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: appTheme.appBarFg,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'HOW TO PLAY',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: appTheme.appBarFg,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            _buildSectionHeader(
              icon: Icons.track_changes_rounded,
              iconColor: appTheme.playBg,
              title: 'THE GOAL',
              appTheme: appTheme,
            ),
            const SizedBox(height: 8),
            Text(
              'Find all the words listed at the bottom of the screen. Letters are hidden in a grid of scrambled letters. When every word is found, the level is solved!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: appTheme.textMuted,
              ),
            ),
            _buildDivider(appTheme),
            _buildSectionHeader(
              icon: Icons.touch_app_rounded,
              iconColor: const Color(0xFF00CEC9),
              title: 'HOW TO SELECT',
              appTheme: appTheme,
            ),
            const SizedBox(height: 8),
            Text(
              'Touch the first letter of a word and drag your finger in a continuous straight line to the last letter. Lift your finger to confirm. You can drag in either direction!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: appTheme.textMuted,
              ),
            ),
            _buildDivider(appTheme),
            _buildSectionHeader(
              icon: Icons.swap_horiz_rounded,
              iconColor: const Color(0xFFFF4757),
              title: 'WORDS CAN BE REVERSED!',
              appTheme: appTheme,
            ),
            const SizedBox(height: 8),
            Text(
              'Words are not only spelled forward—they can also appear backwards in any direction! For example:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: appTheme.textMuted,
              ),
            ),
            const SizedBox(height: 12),
            _buildExampleRow(
              word: 'STAR',
              reversed: 'R • A • T • S (Backwards)',
              appTheme: appTheme,
            ),
            const SizedBox(height: 6),
            _buildExampleRow(
              word: 'LION',
              reversed: 'N • O • I • L (Backwards)',
              appTheme: appTheme,
            ),
            const SizedBox(height: 12),
            Text(
              'You can swipe a word starting from either the first letter or the last letter.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: appTheme.textPrimary,
              ),
            ),
            _buildDivider(appTheme),
            _buildSectionHeader(
              icon: Icons.explore_rounded,
              iconColor: appTheme.levelsBg,
              title: 'ALL 8 WORD DIRECTIONS',
              appTheme: appTheme,
            ),
            const SizedBox(height: 8),
            Text(
              'Words must always form a straight line with no bending or turns. They can run in any of these 8 directions:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: appTheme.textMuted,
              ),
            ),
            const SizedBox(height: 14),
            _buildDirectionRow(
              title: 'Horizontal Forward',
              subtitle: 'Left → Right',
              icon: Icons.arrow_forward_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Horizontal Reversed',
              subtitle: 'Right ← Left (Backwards)',
              icon: Icons.arrow_back_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Vertical Downward',
              subtitle: 'Top ↓ Bottom',
              icon: Icons.arrow_downward_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Vertical Upward',
              subtitle: 'Bottom ↑ Top (Backwards)',
              icon: Icons.arrow_upward_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Diagonal Down-Right',
              subtitle: 'Top-Left ↘ Bottom-Right',
              icon: Icons.south_east_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Diagonal Up-Left',
              subtitle: 'Bottom-Right ↖ Top-Left (Backwards)',
              icon: Icons.north_west_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Diagonal Down-Left',
              subtitle: 'Top-Right ↙ Bottom-Left',
              icon: Icons.south_west_rounded,
              appTheme: appTheme,
            ),
            _buildDirectionRow(
              title: 'Diagonal Up-Right',
              subtitle: 'Bottom-Left ↗ Top-Right (Backwards)',
              icon: Icons.north_east_rounded,
              appTheme: appTheme,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(AppThemeData appTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: appTheme.border.withValues(alpha: 0.35),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required Color iconColor,
    required String title,
    required AppThemeData appTheme,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
              color: appTheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExampleRow({
    required String word,
    required String reversed,
    required AppThemeData appTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              word,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                color: appTheme.textPrimary,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: appTheme.textMuted,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              reversed,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: Color(0xFFFF4757),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required AppThemeData appTheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: appTheme.playBg,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: appTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: appTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
