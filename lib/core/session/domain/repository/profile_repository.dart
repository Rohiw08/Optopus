import 'package:fpdart/fpdart.dart';
import 'package:optopus/core/models/account_entity.dart';
import 'package:optopus/core/session/domain/failures/session_failure.dart';

abstract interface class SessionRepository {
  Stream<Either<SessionFailure, AccountEntity?>> watchAccount(String uid);
}
