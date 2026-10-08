import 'package:flutter/material.dart';

enum AppThemeId { system, clean, dark, amoled, forest, ocean, sunset }

class AppThemeData {
  final AppThemeId id;
  final String name;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color border;
  final Color textPrimary;
  final Color textMuted;
  final Color appBarFg;
  final Color playBg;
  final Color playBorder;
  final Color playShadow;
  final Color randomBg;
  final Color randomBorder;
  final Color randomShadow;
  final Color levelsBg;
  final Color levelsBorder;
  final Color levelsShadow;
  final Color settingsBg;
  final Color settingsBorder;
  final Color settingsShadow;
  final Color levelCurrent;
  final Color levelCurrentBorder;
  final Color levelCurrentShadow;
  final Color levelNormal;
  final Color levelNormalBorder;
  final Color levelNormalShadow;
  final Color levelLocked;
  final Color levelLockedBorder;
  final Color levelLockedIcon;
  final Color cardBg;
  final Color dialogBg;
  final Color switchActiveColor;

  const AppThemeData({
    required this.id,
    required this.name,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.textPrimary,
    required this.textMuted,
    required this.appBarFg,
    required this.playBg,
    required this.playBorder,
    required this.playShadow,
    required this.randomBg,
    required this.randomBorder,
    required this.randomShadow,
    required this.levelsBg,
    required this.levelsBorder,
    required this.levelsShadow,
    required this.settingsBg,
    required this.settingsBorder,
    required this.settingsShadow,
    required this.levelCurrent,
    required this.levelCurrentBorder,
    required this.levelCurrentShadow,
    required this.levelNormal,
    required this.levelNormalBorder,
    required this.levelNormalShadow,
    required this.levelLocked,
    required this.levelLockedBorder,
    required this.levelLockedIcon,
    required this.cardBg,
    required this.dialogBg,
    required this.switchActiveColor,
  });

  AppThemeData copyWith({
    AppThemeId? id,
    String? name,
  }) {
    return AppThemeData(
      id: id ?? this.id,
      name: name ?? this.name,
      background: background,
      surface: surface,
      surfaceVariant: surfaceVariant,
      border: border,
      textPrimary: textPrimary,
      textMuted: textMuted,
      appBarFg: appBarFg,
      playBg: playBg,
      playBorder: playBorder,
      playShadow: playShadow,
      randomBg: randomBg,
      randomBorder: randomBorder,
      randomShadow: randomShadow,
      levelsBg: levelsBg,
      levelsBorder: levelsBorder,
      levelsShadow: levelsShadow,
      settingsBg: settingsBg,
      settingsBorder: settingsBorder,
      settingsShadow: settingsShadow,
      levelCurrent: levelCurrent,
      levelCurrentBorder: levelCurrentBorder,
      levelCurrentShadow: levelCurrentShadow,
      levelNormal: levelNormal,
      levelNormalBorder: levelNormalBorder,
      levelNormalShadow: levelNormalShadow,
      levelLocked: levelLocked,
      levelLockedBorder: levelLockedBorder,
      levelLockedIcon: levelLockedIcon,
      cardBg: cardBg,
      dialogBg: dialogBg,
      switchActiveColor: switchActiveColor,
    );
  }

  ThemeData toMaterialTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Fredoka',
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: _isDark ? Brightness.dark : Brightness.light,
        primary: playBg,
        onPrimary: Colors.white,
        secondary: randomBg,
        onSecondary: Colors.white,
        surface: surface,
        onSurface: textPrimary,
        error: const Color(0xFFEF4444),
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: appBarFg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: appBarFg,
          fontFamily: 'Fredoka',
          fontWeight: FontWeight.w900,
          fontSize: 18,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardThemeData(color: cardBg),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return switchActiveColor;
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return switchActiveColor.withValues(alpha: 0.4);
          return null;
        }),
      ),
    );
  }

  bool get _isDark {
    final luminance = background.computeLuminance();
    return luminance < 0.3;
  }
}

class AppThemes {
  static const clean = AppThemeData(
    id: AppThemeId.clean,
    name: 'Clean',
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF8FAFC),
    surfaceVariant: Color(0xFFE2E8F0),
    border: Color(0xFF94A3B8),
    textPrimary: Color(0xFF1E293B),
    textMuted: Color(0xFF64748B),
    appBarFg: Color(0xFF1E293B),
    playBg: Color(0xFF10B981),
    playBorder: Color(0xFF047857),
    playShadow: Color(0xFF047857),
    randomBg: Color(0xFFFFA502),
    randomBorder: Color(0xFFCC8400),
    randomShadow: Color(0xFFCC8400),
    levelsBg: Color(0xFF3897F0),
    levelsBorder: Color(0xFF1E6BB8),
    levelsShadow: Color(0xFF1E6BB8),
    settingsBg: Color(0xFF8B5CF6),
    settingsBorder: Color(0xFF6D28D9),
    settingsShadow: Color(0xFF6D28D9),
    levelCurrent: Color(0xFF10B981),
    levelCurrentBorder: Color(0xFF047857),
    levelCurrentShadow: Color(0xFF047857),
    levelNormal: Color(0xFF3897F0),
    levelNormalBorder: Color(0xFF1E6BB8),
    levelNormalShadow: Color(0xFF1E6BB8),
    levelLocked: Color(0xFFCBD5E1),
    levelLockedBorder: Color(0xFF94A3B8),
    levelLockedIcon: Color(0xFF64748B),
    cardBg: Color(0xFFFFFFFF),
    dialogBg: Color(0xFFFFFFFF),
    switchActiveColor: Color(0xFF10B981),
  );

  static const dark = AppThemeData(
    id: AppThemeId.dark,
    name: 'Dark',
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceVariant: Color(0xFF334155),
    border: Color(0xFF475569),
    textPrimary: Color(0xFFF1F5F9),
    textMuted: Color(0xFF94A3B8),
    appBarFg: Color(0xFFF1F5F9),
    playBg: Color(0xFF10B981),
    playBorder: Color(0xFF047857),
    playShadow: Color(0xFF064E3B),
    randomBg: Color(0xFFF59E0B),
    randomBorder: Color(0xFFB45309),
    randomShadow: Color(0xFF78350F),
    levelsBg: Color(0xFF3B82F6),
    levelsBorder: Color(0xFF1D4ED8),
    levelsShadow: Color(0xFF1E3A8A),
    settingsBg: Color(0xFF8B5CF6),
    settingsBorder: Color(0xFF6D28D9),
    settingsShadow: Color(0xFF4C1D95),
    levelCurrent: Color(0xFF10B981),
    levelCurrentBorder: Color(0xFF047857),
    levelCurrentShadow: Color(0xFF064E3B),
    levelNormal: Color(0xFF3B82F6),
    levelNormalBorder: Color(0xFF1D4ED8),
    levelNormalShadow: Color(0xFF1E3A8A),
    levelLocked: Color(0xFF334155),
    levelLockedBorder: Color(0xFF475569),
    levelLockedIcon: Color(0xFF64748B),
    cardBg: Color(0xFF1E293B),
    dialogBg: Color(0xFF1E293B),
    switchActiveColor: Color(0xFF10B981),
  );

  static const amoled = AppThemeData(
    id: AppThemeId.amoled,
    name: 'AMOLED Dark',
    background: Color(0xFF000000),
    surface: Color(0xFF121212),
    surfaceVariant: Color(0xFF1E1E1E),
    border: Color(0xFF333333),
    textPrimary: Color(0xFFFFFFFF),
    textMuted: Color(0xFFA1A1AA),
    appBarFg: Color(0xFFFFFFFF),
    playBg: Color(0xFF10B981),
    playBorder: Color(0xFF047857),
    playShadow: Color(0xFF064E3B),
    randomBg: Color(0xFFF59E0B),
    randomBorder: Color(0xFFB45309),
    randomShadow: Color(0xFF78350F),
    levelsBg: Color(0xFF3B82F6),
    levelsBorder: Color(0xFF1D4ED8),
    levelsShadow: Color(0xFF1E3A8A),
    settingsBg: Color(0xFF8B5CF6),
    settingsBorder: Color(0xFF6D28D9),
    settingsShadow: Color(0xFF4C1D95),
    levelCurrent: Color(0xFF10B981),
    levelCurrentBorder: Color(0xFF047857),
    levelCurrentShadow: Color(0xFF064E3B),
    levelNormal: Color(0xFF3B82F6),
    levelNormalBorder: Color(0xFF1D4ED8),
    levelNormalShadow: Color(0xFF1E3A8A),
    levelLocked: Color(0xFF18181B),
    levelLockedBorder: Color(0xFF27272A),
    levelLockedIcon: Color(0xFF52525B),
    cardBg: Color(0xFF000000),
    dialogBg: Color(0xFF000000),
    switchActiveColor: Color(0xFF10B981),
  );

  static const forest = AppThemeData(
    id: AppThemeId.forest,
    name: 'Forest',
    background: Color(0xFF1A2E1A),
    surface: Color(0xFF243324),
    surfaceVariant: Color(0xFF2F4A2F),
    border: Color(0xFF4A6741),
    textPrimary: Color(0xFFE8F5E9),
    textMuted: Color(0xFF81C784),
    appBarFg: Color(0xFFE8F5E9),
    playBg: Color(0xFF43A047),
    playBorder: Color(0xFF2E7D32),
    playShadow: Color(0xFF1B5E20),
    randomBg: Color(0xFFFFA726),
    randomBorder: Color(0xFFE65100),
    randomShadow: Color(0xFFBF360C),
    levelsBg: Color(0xFF26A69A),
    levelsBorder: Color(0xFF00796B),
    levelsShadow: Color(0xFF004D40),
    settingsBg: Color(0xFF8D6E63),
    settingsBorder: Color(0xFF5D4037),
    settingsShadow: Color(0xFF3E2723),
    levelCurrent: Color(0xFF43A047),
    levelCurrentBorder: Color(0xFF2E7D32),
    levelCurrentShadow: Color(0xFF1B5E20),
    levelNormal: Color(0xFF26A69A),
    levelNormalBorder: Color(0xFF00796B),
    levelNormalShadow: Color(0xFF004D40),
    levelLocked: Color(0xFF2F4A2F),
    levelLockedBorder: Color(0xFF4A6741),
    levelLockedIcon: Color(0xFF81C784),
    cardBg: Color(0xFF243324),
    dialogBg: Color(0xFF243324),
    switchActiveColor: Color(0xFF43A047),
  );

  static const ocean = AppThemeData(
    id: AppThemeId.ocean,
    name: 'Ocean',
    background: Color(0xFF0D1B2A),
    surface: Color(0xFF1B2D3F),
    surfaceVariant: Color(0xFF243B52),
    border: Color(0xFF2E5F7A),
    textPrimary: Color(0xFFE0F2FE),
    textMuted: Color(0xFF7DD3FC),
    appBarFg: Color(0xFFE0F2FE),
    playBg: Color(0xFF0EA5E9),
    playBorder: Color(0xFF0369A1),
    playShadow: Color(0xFF0C4A6E),
    randomBg: Color(0xFF06B6D4),
    randomBorder: Color(0xFF0E7490),
    randomShadow: Color(0xFF164E63),
    levelsBg: Color(0xFF6366F1),
    levelsBorder: Color(0xFF4338CA),
    levelsShadow: Color(0xFF312E81),
    settingsBg: Color(0xFF8B5CF6),
    settingsBorder: Color(0xFF6D28D9),
    settingsShadow: Color(0xFF4C1D95),
    levelCurrent: Color(0xFF0EA5E9),
    levelCurrentBorder: Color(0xFF0369A1),
    levelCurrentShadow: Color(0xFF0C4A6E),
    levelNormal: Color(0xFF6366F1),
    levelNormalBorder: Color(0xFF4338CA),
    levelNormalShadow: Color(0xFF312E81),
    levelLocked: Color(0xFF243B52),
    levelLockedBorder: Color(0xFF2E5F7A),
    levelLockedIcon: Color(0xFF7DD3FC),
    cardBg: Color(0xFF1B2D3F),
    dialogBg: Color(0xFF1B2D3F),
    switchActiveColor: Color(0xFF0EA5E9),
  );

  static const sunset = AppThemeData(
    id: AppThemeId.sunset,
    name: 'Sunset',
    background: Color(0xFF1C0A00),
    surface: Color(0xFF2D1200),
    surfaceVariant: Color(0xFF3D1F00),
    border: Color(0xFF7C3A10),
    textPrimary: Color(0xFFFFF3E0),
    textMuted: Color(0xFFFFAB91),
    appBarFg: Color(0xFFFFF3E0),
    playBg: Color(0xFFFF6B35),
    playBorder: Color(0xFFBF360C),
    playShadow: Color(0xFF870000),
    randomBg: Color(0xFFFF9500),
    randomBorder: Color(0xFFE65100),
    randomShadow: Color(0xFF870000),
    levelsBg: Color(0xFFE91E63),
    levelsBorder: Color(0xFF880E4F),
    levelsShadow: Color(0xFF560027),
    settingsBg: Color(0xFF9C27B0),
    settingsBorder: Color(0xFF4A148C),
    settingsShadow: Color(0xFF12005E),
    levelCurrent: Color(0xFFFF6B35),
    levelCurrentBorder: Color(0xFFBF360C),
    levelCurrentShadow: Color(0xFF870000),
    levelNormal: Color(0xFFE91E63),
    levelNormalBorder: Color(0xFF880E4F),
    levelNormalShadow: Color(0xFF560027),
    levelLocked: Color(0xFF3D1F00),
    levelLockedBorder: Color(0xFF7C3A10),
    levelLockedIcon: Color(0xFFFFAB91),
    cardBg: Color(0xFF2D1200),
    dialogBg: Color(0xFF2D1200),
    switchActiveColor: Color(0xFFFF6B35),
  );

  static const system = AppThemeData(
    id: AppThemeId.system,
    name: 'Follow System',
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF8FAFC),
    surfaceVariant: Color(0xFFE2E8F0),
    border: Color(0xFF94A3B8),
    textPrimary: Color(0xFF1E293B),
    textMuted: Color(0xFF64748B),
    appBarFg: Color(0xFF1E293B),
    playBg: Color(0xFF10B981),
    playBorder: Color(0xFF047857),
    playShadow: Color(0xFF047857),
    randomBg: Color(0xFFFFA502),
    randomBorder: Color(0xFFCC8400),
    randomShadow: Color(0xFFCC8400),
    levelsBg: Color(0xFF3897F0),
    levelsBorder: Color(0xFF1E6BB8),
    levelsShadow: Color(0xFF1E6BB8),
    settingsBg: Color(0xFF8B5CF6),
    settingsBorder: Color(0xFF6D28D9),
    settingsShadow: Color(0xFF6D28D9),
    levelCurrent: Color(0xFF10B981),
    levelCurrentBorder: Color(0xFF047857),
    levelCurrentShadow: Color(0xFF047857),
    levelNormal: Color(0xFF3897F0),
    levelNormalBorder: Color(0xFF1E6BB8),
    levelNormalShadow: Color(0xFF1E6BB8),
    levelLocked: Color(0xFFCBD5E1),
    levelLockedBorder: Color(0xFF94A3B8),
    levelLockedIcon: Color(0xFF64748B),
    cardBg: Color(0xFFFFFFFF),
    dialogBg: Color(0xFFFFFFFF),
    switchActiveColor: Color(0xFF10B981),
  );

  static const all = [system, clean, dark, amoled, forest, ocean, sunset];

  static AppThemeData resolve(AppThemeId id, [Brightness? platformBrightness]) {
    if (id == AppThemeId.system) {
      final brightness = platformBrightness ??
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final base = brightness == Brightness.dark ? dark : clean;
      return base.copyWith(id: AppThemeId.system, name: 'Follow System');
    }
    return fromId(id);
  }

  static AppThemeData fromId(AppThemeId id) {
    return all.firstWhere((t) => t.id == id, orElse: () => clean);
  }
}
