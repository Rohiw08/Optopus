import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/models/account_entity.dart';
import 'package:optopus/core/session/domain/failures/session_failure.dart';
import 'package:optopus/core/session/domain/repository/profile_repository.dart';

class SessionService {
  final SessionRepository _repository;
  SessionService(this._repository);

  Stream<Either<SessionFailure, AccountEntity?>> watchAccount(String? uid) {
    if (uid == null) return Stream.value(const Right(null));
    return _repository.watchAccount(uid);
  }
}
