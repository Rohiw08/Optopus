import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleAuthDataSource {
  final SupabaseClient _supabase;

  GoogleAuthDataSource(this._supabase);

  Future<void> signIn() async {
    await _supabase.auth.signInWithOAuth(OAuthProvider.google);
  }
}
