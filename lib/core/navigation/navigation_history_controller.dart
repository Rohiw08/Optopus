import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_history_controller.g.dart';

class NavigationHistory {
  final List<String> backStack;
  final List<String> forwardStack;
  final String? currentPath;

  NavigationHistory({
    this.backStack = const [],
    this.forwardStack = const [],
    this.currentPath,
  });

  NavigationHistory copyWith({
    List<String>? backStack,
    List<String>? forwardStack,
    String? currentPath,
  }) {
    return NavigationHistory(
      backStack: backStack ?? this.backStack,
      forwardStack: forwardStack ?? this.forwardStack,
      currentPath: currentPath ?? this.currentPath,
    );
  }
}

@riverpod
class NavigationHistoryController extends _$NavigationHistoryController {
  @override
  NavigationHistory build() => NavigationHistory();

  void onPathChanged(String path) {
    if (state.currentPath == path) return;

    final newBackStack = List<String>.from(state.backStack);
    if (state.currentPath != null) {
      newBackStack.add(state.currentPath!);
    }

    state = state.copyWith(
      backStack: newBackStack,
      forwardStack: [], // New navigation clears forward stack
      currentPath: path,
    );
  }

  bool get canGoBack => state.backStack.isNotEmpty;
  bool get canGoForward => state.forwardStack.isNotEmpty;

  String? goBack() {
    if (!canGoBack) return null;

    final newBackStack = List<String>.from(state.backStack);
    final previousPath = newBackStack.removeLast();

    final newForwardStack = List<String>.from(state.forwardStack);
    if (state.currentPath != null) {
      newForwardStack.add(state.currentPath!);
    }

    state = state.copyWith(
      backStack: newBackStack,
      forwardStack: newForwardStack,
      currentPath: previousPath,
    );

    return previousPath;
  }

  String? goForward() {
    if (!canGoForward) return null;

    final newForwardStack = List<String>.from(state.forwardStack);
    final nextPath = newForwardStack.removeLast();

    final newBackStack = List<String>.from(state.backStack);
    if (state.currentPath != null) {
      newBackStack.add(state.currentPath!);
    }

    state = state.copyWith(
      backStack: newBackStack,
      forwardStack: newForwardStack,
      currentPath: nextPath,
    );

    return nextPath;
  }
}

class NavigationHistoryObserver extends NavigatorObserver {
  final void Function(String path) onPathChanged;

  NavigationHistoryObserver({required this.onPathChanged});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _notify(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Don't notify on pop because the controller handles its own state for back/forward
  }

  void _notify(Route<dynamic> route) {
    final name = route.settings.name;
    if (name != null) {
      onPathChanged(name);
    }
  }
}
