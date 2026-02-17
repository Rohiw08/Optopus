import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collection/collection.dart';

class SessionRemoteDataSource {
  final SupabaseClient _supabase;
  SessionRemoteDataSource(this._supabase);

  Stream<Map<String, dynamic>?> getAccountStream(String uid) {
    return _supabase
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', uid)
        .map((data) => data.isEmpty ? null : data.first)
        .distinct(
          (prev, next) => const DeepCollectionEquality().equals(prev, next),
        );
  }
}
