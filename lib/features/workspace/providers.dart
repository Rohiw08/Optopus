import 'package:optopus/core/services/supabase_service.dart';
import 'package:optopus/features/workspace/application/workspace_service.dart';
import 'package:optopus/features/workspace/data/data_sources/workspace_remote_data_source.dart';
import 'package:optopus/features/workspace/data/repository/workspace_repository_impl.dart';
import 'package:optopus/features/workspace/domain/repositories/workspace_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
WorkspaceRemoteDataSource workspaceRemoteDataSource(Ref ref) {
  return WorkspaceRemoteDataSource(ref.read(supabaseClientProvider));
}

@riverpod
WorkspaceRepository workspaceRepository(Ref ref) {
  return WorkspaceRepositoryImpl(ref.read(workspaceRemoteDataSourceProvider));
}

@riverpod
WorkspaceService workspaceService(Ref ref) {
  return WorkspaceService(ref.watch(workspaceRepositoryProvider));
}
