import 'package:flutter/material.dart';
import 'package:optopus/features/workspace/domain/entities/workspace_template_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_templates_provider.g.dart';

@riverpod
List<WorkspaceTemplateEntity> workspaceTemplates(Ref ref) {
  return [
    const WorkspaceTemplateEntity(
      title: 'Blank workspace',
      imagePath: 'assets/blank_workspace_image.png',
      icon: Icons.dashboard_outlined,
    ),
  ];
}
