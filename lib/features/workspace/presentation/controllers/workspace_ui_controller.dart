import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_ui_controller.g.dart';

@riverpod
class WorkspaceSearchQuery extends _$WorkspaceSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
  void clear() => state = '';
}

enum WorkspaceSortStrategy { nameAz, nameZa, lastUpdated, createdNewest }

@riverpod
class WorkspaceSort extends _$WorkspaceSort {
  @override
  WorkspaceSortStrategy build() => WorkspaceSortStrategy.lastUpdated;

  void set(WorkspaceSortStrategy strategy) => state = strategy;
}
