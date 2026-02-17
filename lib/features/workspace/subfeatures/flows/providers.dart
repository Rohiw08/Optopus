import 'package:optopus/core/services/supabase_service.dart';
import 'package:optopus/features/workspace/subfeatures/flows/application/flow_service.dart';
import 'package:optopus/features/workspace/subfeatures/flows/data/datasources/flow_remote_data_source.dart';
import 'package:optopus/features/workspace/subfeatures/flows/data/repositories/flow_remote_data_source_impl.dart';
import 'package:optopus/features/workspace/subfeatures/flows/data/repositories/flow_repository_impl.dart';
import 'package:optopus/features/workspace/subfeatures/flows/domain/repositories/flow_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
FlowRemoteDataSource flowRemoteDataSource(Ref ref) {
  return FlowRemoteDataSourceImpl(ref.read(supabaseClientProvider));
}

@riverpod
FlowRepository flowRepository(Ref ref) {
  return FlowRepositoryImpl(ref.read(flowRemoteDataSourceProvider));
}

@riverpod
FlowService flowService(Ref ref) {
  return FlowService(ref.watch(flowRepositoryProvider));
}
