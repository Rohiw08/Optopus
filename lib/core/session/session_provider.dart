import 'package:optopus/core/models/account_entity.dart';
import 'package:optopus/core/providers/auth_state_provider.dart';
import 'package:optopus/core/services/supabase_service.dart';
import 'package:optopus/core/session/application/session_service.dart';
import 'package:optopus/core/session/data/data_source/session_remote_data_source.dart';
import 'package:optopus/core/session/data/repositories/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_provider.g.dart';

@riverpod
SessionRemoteDataSource _sessionRemoteDataSource(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return SessionRemoteDataSource(client);
}

@riverpod
SessionService _sessionService(Ref ref) {
  final remoteSource = ref.watch(_sessionRemoteDataSourceProvider);
  final repo = SessionRepositoryImpl(remoteSource);
  return SessionService(repo);
}

@riverpod
Stream<AccountEntity?> session(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);

      final service = ref.watch(_sessionServiceProvider);
      return service.watchAccount(user.id).map((result) {
        return result.fold((failure) {
          return null;
        }, (profile) => profile);
      });
    },
    loading: () => const Stream.empty(),
    error: (err, stack) {
      return Stream.value(null);
    },
  );
}

@riverpod
Stream<AccountEntity?> profile(Ref ref, String userId) {
  final service = ref.watch(_sessionServiceProvider);
  return service.watchAccount(userId).map((result) {
    return result.fold((failure) => null, (profile) => profile);
  });
}
