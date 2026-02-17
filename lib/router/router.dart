import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:optopus/core/providers/auth_state_provider.dart';
import 'package:optopus/features/auth/presentation/auth_screen.dart';
import 'package:optopus/features/home/presentation/home_screen.dart';
import 'package:optopus/features/workspace/presentation/screens/create_workspace_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  // Use a ValueNotifier to handle the auth state for the router
  final authNotifier = ValueNotifier<bool>(false);

  // Listen to the stream and update the notifier
  // We use listen instead of watch to keep the GoRouter instance stable
  ref.listen(authStateProvider, (previous, next) {
    if (next is AsyncData) {
      authNotifier.value = next.value != null;
    }
  }, fireImmediately: true);

  ref.onDispose(authNotifier.dispose);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable:
        authNotifier, // Triggers redirect logic when notifier changes
    redirect: (context, state) {
      final isLoggedIn = authNotifier.value;
      final isLoggingIn = state.uri.path == '/login';

      if (!isLoggedIn) {
        return isLoggingIn ? null : '/login';
      }

      if (isLoggingIn) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const AuthScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/create-workspace',
        builder: (context, state) => const CreateWorkspaceScreen(),
      ),
    ],
  );
}
