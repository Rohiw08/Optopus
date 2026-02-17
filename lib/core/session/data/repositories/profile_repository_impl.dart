import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/models/account_entity.dart';
import 'package:optopus/core/session/data/data_source/session_remote_data_source.dart';
import 'package:optopus/core/session/domain/failures/session_failure.dart';
import 'package:optopus/core/session/domain/repository/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource _remoteDataSource;

  SessionRepositoryImpl(this._remoteDataSource);

  @override
  Stream<Either<SessionFailure, AccountEntity?>> watchAccount(String uid) {
    return _remoteDataSource
        .getAccountStream(uid)
        .map<Either<SessionFailure, AccountEntity?>>((json) {
          if (json == null) return const Right(null);
          return Right(AccountEntity.fromJson(json));
        })
        .handleError((error) {
          if (error is AuthException) {
            return Left(SessionNetworkFailure(error.message));
          }
          return Left(SessionUnknownFailure(error.toString()));
        });
  }
}
