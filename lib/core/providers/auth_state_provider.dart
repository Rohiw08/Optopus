import 'package:optopus/core/services/supabase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state_provider.g.dart';

@riverpod
Stream<User?> authState(Ref ref) {
  // Watch the client from the external core provider
  final client = ref.watch(supabaseClientProvider);

  return client.auth.onAuthStateChange.map((event) => event.session?.user);
}
