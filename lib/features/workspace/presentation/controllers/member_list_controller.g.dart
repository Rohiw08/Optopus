// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MemberListController)
final memberListControllerProvider = MemberListControllerFamily._();

final class MemberListControllerProvider
    extends
        $AsyncNotifierProvider<
          MemberListController,
          List<WorkspaceMemberEntity>
        > {
  MemberListControllerProvider._({
    required MemberListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'memberListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberListControllerHash();

  @override
  String toString() {
    return r'memberListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MemberListController create() => MemberListController();

  @override
  bool operator ==(Object other) {
    return other is MemberListControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberListControllerHash() =>
    r'61e213580e17611c373e212b21fedb0ae19254e8';

final class MemberListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MemberListController,
          AsyncValue<List<WorkspaceMemberEntity>>,
          List<WorkspaceMemberEntity>,
          FutureOr<List<WorkspaceMemberEntity>>,
          String
        > {
  MemberListControllerFamily._()
    : super(
        retry: null,
        name: r'memberListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberListControllerProvider call(String workspaceId) =>
      MemberListControllerProvider._(argument: workspaceId, from: this);

  @override
  String toString() => r'memberListControllerProvider';
}

abstract class _$MemberListController
    extends $AsyncNotifier<List<WorkspaceMemberEntity>> {
  late final _$args = ref.$arg as String;
  String get workspaceId => _$args;

  FutureOr<List<WorkspaceMemberEntity>> build(String workspaceId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<WorkspaceMemberEntity>>,
              List<WorkspaceMemberEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WorkspaceMemberEntity>>,
                List<WorkspaceMemberEntity>
              >,
              AsyncValue<List<WorkspaceMemberEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
