import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_theme.dart';
import '../services/storage_service.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppThemeData>
    with WidgetsBindingObserver {
  late AppThemeId _selectedId;

  ThemeNotifier() : super(AppThemes.clean) {
    WidgetsBinding.instance.addObserver(this);
    final savedName = StorageService.getThemeId();
    _selectedId = AppThemeId.values.firstWhere(
      (e) => e.name == savedName,
      orElse: () => AppThemeId.clean,
    );
    _updateState();
  }

  @override
  void didChangePlatformBrightness() {
    if (_selectedId == AppThemeId.system) {
      _updateState();
    }
  }

  void setTheme(AppThemeId id) {
    _selectedId = id;
    StorageService.setThemeId(id.name);
    _updateState();
  }

  void _updateState() {
    state = AppThemes.resolve(_selectedId);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
