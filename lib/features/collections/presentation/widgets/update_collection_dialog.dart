import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/collections/presentation/controllers/collection_list_controller.dart';
import 'package:optopus/core/widgets/create_button.dart';
import 'package:optopus/core/widgets/custom_textfield_widget.dart';

class UpdateCollectionDialog extends ConsumerStatefulWidget {
  final CollectionEntity collection;

  const UpdateCollectionDialog({super.key, required this.collection});

  @override
  ConsumerState<UpdateCollectionDialog> createState() =>
      _UpdateCollectionDialogState();
}

class _UpdateCollectionDialogState
    extends ConsumerState<UpdateCollectionDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.collection.name);
    _descriptionController = TextEditingController(
      text: widget.collection.description,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Collection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            CustomTextfield(controller: _nameController, hintText: 'Name'),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: _descriptionController,
              hintText: 'Description',
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                CreateButton(
                  height: 40,
                  width: 100,
                  text: 'Save',
                  onPressed: () {
                    ref
                        .read(
                          collectionListControllerProvider(
                            widget.collection.workspaceId,
                          ).notifier,
                        )
                        .updateCollection(
                          collectionId: widget.collection.id,
                          workspaceId: widget.collection.workspaceId,
                          name: _nameController.text,
                          description: _descriptionController.text,
                        );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
