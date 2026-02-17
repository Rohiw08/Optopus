// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_cooldown_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetCooldown)
final resetCooldownProvider = ResetCooldownProvider._();

final class ResetCooldownProvider
    extends $NotifierProvider<ResetCooldown, int> {
  ResetCooldownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetCooldownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetCooldownHash();

  @$internal
  @override
  ResetCooldown create() => ResetCooldown();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$resetCooldownHash() => r'4e7821bf4db9d854a4d57eb0783848783f244cba';

abstract class _$ResetCooldown extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
