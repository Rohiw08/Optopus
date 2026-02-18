import 'package:supabase_flutter/supabase_flutter.dart';

class SessionRemoteDataSource {
  final SupabaseClient _supabase;
  SessionRemoteDataSource(this._supabase);

  Stream<Map<String, dynamic>?> getAccountStream(String uid) {
    return _supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', uid)
        .map((data) {
          final result = data.isEmpty ? null : data.first;
          return result;
        });
  }
}
