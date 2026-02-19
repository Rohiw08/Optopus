import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/app/router/router.dart';
import 'package:optopus/core/startup/app_startup_provider.dart';
import 'package:optopus/core/startup/shared_preferences_provider.dart';
import 'package:optopus/core/theme/theme_provider.dart';
import 'package:optopus/core/theme/app_theme.dart';
import 'package:optopus/core/widgets/error_screen.dart';
import 'package:optopus/core/widgets/loading_screen.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register the custom protocol handler for deep linking on Windows
  if (!kIsWeb && Platform.isWindows) {
    await protocolHandler.register('io.supabase.optopus');
  }
  final sharedPrefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
      child: const MyApp(),
    ),
  );

  doWhenWindowReady(() {
    const initialSize = Size(1280, 720);
    appWindow.minSize = const Size(600, 450);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final startupState = ref.watch(appStartupProvider);

    return startupState.when(
      data: (_) {
        final router = ref.watch(routerProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: router,
        );
      },
      error: (err, stack) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        home: ErrorScreen(message: err.toString()),
      ),
      loading: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        home: const LoadingScreen(),
      ),
    );
  }
}
