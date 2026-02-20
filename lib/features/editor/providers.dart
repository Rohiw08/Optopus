import 'package:optopus/core/network/api_client.dart';
import 'package:optopus/features/editor/application/editor_service.dart';
import 'package:optopus/features/editor/data/datasources/editor_data_source.dart';
import 'package:optopus/features/editor/data/repositories/editor_repository_impl.dart';
import 'package:optopus/features/editor/domain/repositories/editor_repository.dart';
import 'package:optopus/features/flows/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
EditorDataSource editorDataSource(Ref ref) {
  return EditorDataSourceImpl(OptopusApiClient());
}

@Riverpod(keepAlive: true)
EditorRepository editorRepository(Ref ref) {
  return EditorRepositoryImpl(ref.watch(editorDataSourceProvider));
}

@Riverpod(keepAlive: true)
EditorService editorService(Ref ref) {
  return EditorService(
    ref.watch(editorRepositoryProvider),
    ref.watch(flowRepositoryProvider),
  );
}
