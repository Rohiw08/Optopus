import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:optopus/core/providers/auth_state_provider.dart';
import 'package:optopus/core/navigation/navigation_history_controller.dart';
import 'package:optopus/features/auth/presentation/screens/auth_screen.dart';
import 'package:optopus/features/dashboard/screens/home_screen.dart';
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

  final historyObserver = NavigationHistoryObserver(
    onPathChanged: (path) {
      Future.microtask(() {
        ref
            .read(navigationHistoryControllerProvider.notifier)
            .onPathChanged(path);
      });
    },
  );

  return GoRouter(
    initialLocation: '/login',
    observers: [historyObserver],
    // Triggers redirect logic when notifier changes
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isLoggedIn = authNotifier.value;
      final isLoggingIn = state.uri.path == '/login';

      // If not logged in, force login page
      if (!isLoggedIn && !isLoggingIn) return '/login';

      // If logged in and trying to go to login, send home
      if (isLoggedIn && isLoggingIn) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        name: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: '/workspaces',
        name: '/workspaces',
        builder: (context, state) => const CreateWorkspaceScreen(),
      ),
    ],
  );
}
