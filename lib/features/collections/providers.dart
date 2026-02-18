import 'package:optopus/core/services/supabase_service.dart';
import 'package:optopus/features/collections/application/collection_service.dart';
import 'package:optopus/features/collections/domain/repositories/collection_remote_data_source.dart';
import 'package:optopus/features/collections/data/datasources/collection_remote_data_source_impl.dart';
import 'package:optopus/features/collections/data/repositories/collection_repository_impl.dart';
import 'package:optopus/features/collections/domain/repositories/collection_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
CollectionRemoteDataSource collectionRemoteDataSource(Ref ref) {
  return CollectionRemoteDataSourceImpl(ref.read(supabaseClientProvider));
}

@riverpod
CollectionRepository collectionRepository(Ref ref) {
  return CollectionRepositoryImpl(ref.read(collectionRemoteDataSourceProvider));
}

@riverpod
CollectionService collectionService(Ref ref) {
  return CollectionService(ref.watch(collectionRepositoryProvider));
}
