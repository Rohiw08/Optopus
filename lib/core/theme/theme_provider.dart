import 'package:flutter/material.dart';
import 'package:optopus/core/startup/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeStr = prefs.getString('theme') ?? 'light';
    return themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() {
    final prefs = ref.read(sharedPreferencesProvider);
    final newMode = state == ThemeMode.dark ? 'light' : 'dark';
    prefs.setString('theme', newMode);
    state = newMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }
}
