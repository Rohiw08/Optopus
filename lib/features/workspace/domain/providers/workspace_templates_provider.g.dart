// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_templates_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workspaceTemplates)
final workspaceTemplatesProvider = WorkspaceTemplatesProvider._();

final class WorkspaceTemplatesProvider
    extends
        $FunctionalProvider<
          List<WorkspaceTemplateEntity>,
          List<WorkspaceTemplateEntity>,
          List<WorkspaceTemplateEntity>
        >
    with $Provider<List<WorkspaceTemplateEntity>> {
  WorkspaceTemplatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceTemplatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceTemplatesHash();

  @$internal
  @override
  $ProviderElement<List<WorkspaceTemplateEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<WorkspaceTemplateEntity> create(Ref ref) {
    return workspaceTemplates(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<WorkspaceTemplateEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<WorkspaceTemplateEntity>>(
        value,
      ),
    );
  }
}

String _$workspaceTemplatesHash() =>
    r'fdf41037650d464ee9abf85691b72b242276d1e0';
