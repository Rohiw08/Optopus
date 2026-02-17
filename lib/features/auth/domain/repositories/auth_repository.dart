import 'package:optopus/features/auth/domain/enums/auth_mode_enum.dart';
import 'package:optopus/features/auth/domain/inputs/auth_method.dart';

abstract interface class AuthRepository {
  Future<void> perform(AuthAction action, {AuthMethod? method});
}
