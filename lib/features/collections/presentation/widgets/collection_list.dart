import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/features/collections/presentation/controllers/collection_list_controller.dart';
import 'package:optopus/features/collections/domain/entities/collection_entity.dart';
import 'package:optopus/features/flows/presentation/controllers/flow_list_controller.dart';
import 'package:optopus/features/flows/domain/entities/flow_entity.dart';
import 'package:optopus/features/studio/presentation/controllers/studio_view_controller.dart';

class CollectionList extends ConsumerWidget {
  final String workspaceId;

  const CollectionList({super.key, required this.workspaceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(
      collectionListControllerProvider(workspaceId),
    );
    final isCreating = ref.watch(isCreatingCollectionProvider);

    return collectionsAsync.when(
      data: (collections) {
        if (collections.isEmpty && !isCreating) {
          return const Center(child: Text('No collections found'));
        }

        final rootCollections = collections
            .where((c) => c.parentId == null)
            .toList();

        return ListView(
          children: [
            if (isCreating)
              _CollectionInputTile(
                key: const ValueKey('new_root'),
                workspaceId: workspaceId,
              ),
            ...rootCollections.map(
              (c) => _CollectionTreeItem(
                key: ValueKey(c.id),
                collection: c,
                allCollections: collections,
                workspaceId: workspaceId,
                depth: 0,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _CollectionTreeItem extends ConsumerStatefulWidget {
  final CollectionEntity collection;
  final List<CollectionEntity> allCollections;
  final String workspaceId;
  final int depth;

  const _CollectionTreeItem({
    super.key,
    required this.collection,
    required this.allCollections,
    required this.workspaceId,
    required this.depth,
  });

  @override
  ConsumerState<_CollectionTreeItem> createState() =>
      _CollectionTreeItemState();
}

class _CollectionTreeItemState extends ConsumerState<_CollectionTreeItem> {
  final Set<String> _expandedIds = {};
  late final ExpansionTileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    final childrenCollections = widget.allCollections
        .where((c) => c.parentId == widget.collection.id)
        .toList();

    // Watch flows for THIS collection
    final flowsAsync = ref.watch(
      flowListControllerProvider(widget.collection.id),
    );

    final creatingSubId = ref.watch(creatingSubCollectionForIdProvider);
    final creatingFlowId = ref.watch(creatingFlowForCollectionIdProvider);
    final renamingId = ref.watch(renamingCollectionIdProvider);

    final isCreatingSub = creatingSubId == widget.collection.id;
    final isCreatingFlow = creatingFlowId == widget.collection.id;
    final isRenaming = renamingId == widget.collection.id;

    // Auto-expand checks - using controller instead of key-switching or post-frame callbacks
    if (isCreatingSub || isCreatingFlow) {
      if (!_controller.isExpanded) {
        _controller.expand();
      }
    }

    final flows = flowsAsync.when(
      data: (data) => data,
      loading: () => <FlowEntity>[],
      error: (_, __) => <FlowEntity>[],
    );

    final currentIsExpanded =
        _controller.isExpanded || _expandedIds.contains(widget.collection.id);

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        controller: _controller,
        key: ValueKey('expansion_${widget.collection.id}'), // Stable key!
        initiallyExpanded: currentIsExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            if (expanded) {
              _expandedIds.add(widget.collection.id);
            } else {
              _expandedIds.remove(widget.collection.id);
            }
          });
        },
        shape: const Border(),
        textColor: Theme.of(context).textTheme.bodyMedium?.color,
        collapsedTextColor: Theme.of(context).textTheme.bodyMedium?.color,
        iconColor: Theme.of(context).iconTheme.color,
        collapsedIconColor: Theme.of(context).iconTheme.color,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: widget.depth * 12.0),
            Icon(
              currentIsExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: Theme.of(context).iconTheme.color,
              size: 20, // Slightly smaller for chevrons usually looks better
            ),
          ],
        ),
        dense: true,
        title: isRenaming
            ? _CollectionInputTile(
                key: ValueKey('rename_${widget.collection.id}'),
                workspaceId: widget.workspaceId,
                existingCollection: widget.collection,
              )
            : Text(
                widget.collection.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
        trailing: isRenaming ? const SizedBox() : _buildPopupMenu(),
        children: [
          // 1. New Sub-Collection Input
          if (isCreatingSub)
            Padding(
              padding: EdgeInsets.only(left: (widget.depth + 1) * 12.0),
              child: _CollectionInputTile(
                key: ValueKey('new_sub_${widget.collection.id}'),
                workspaceId: widget.workspaceId,
                parentId: widget.collection.id,
              ),
            ),

          // 2. Sub-Collections
          ...childrenCollections.map(
            (c) => _CollectionTreeItem(
              key: ValueKey(c.id),
              collection: c,
              allCollections: widget.allCollections,
              workspaceId: widget.workspaceId,
              depth: widget.depth + 1,
            ),
          ),

          // 3. New Flow Input
          if (isCreatingFlow)
            Padding(
              padding: EdgeInsets.only(left: (widget.depth + 1) * 12.0),
              child: _FlowInputTile(
                key: ValueKey('new_flow_${widget.collection.id}'),
                collectionId: widget.collection.id,
              ),
            ),

          // 4. Flows
          ...flows.map(
            (f) => _FlowListItem(
              key: ValueKey(f.id),
              flow: f,
              depth: widget.depth + 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz, color: Theme.of(context).iconTheme.color),
      onSelected: (value) async {
        if (value == 'rename') {
          ref
              .read(renamingCollectionIdProvider.notifier)
              .set(widget.collection.id);
        } else if (value == 'add_collection') {
          ref
              .read(creatingSubCollectionForIdProvider.notifier)
              .set(widget.collection.id);
        } else if (value == 'add_flow') {
          ref
              .read(creatingFlowForCollectionIdProvider.notifier)
              .set(widget.collection.id);
        } else if (value == 'delete') {
          try {
            await ref
                .read(
                  collectionListControllerProvider(widget.workspaceId).notifier,
                )
                .deleteCollection(widget.collection.id, widget.workspaceId);
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Failed to delete: $e')));
            }
          }
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'add_collection',
          child: Text('Add Collection'),
        ),
        const PopupMenuItem(value: 'add_flow', child: Text('Add Flow')),
        const PopupMenuItem(value: 'rename', child: Text('Rename')),
        const PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    );
  }
}

class _FlowListItem extends ConsumerWidget {
  final FlowEntity flow;
  final int depth;

  const _FlowListItem({super.key, required this.flow, required this.depth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFlowId = ref.watch(selectedFlowIdProvider);
    final isSelected = selectedFlowId == flow.id;
    final renamingId = ref.watch(renamingFlowIdProvider);
    final isRenaming = renamingId == flow.id;

    if (isRenaming) {
      return _FlowRenameInputTile(
        key: ValueKey('rename_${flow.id}'),
        flow: flow,
        depth: depth,
      );
    }

    return ListTile(
      selected: isSelected,
      selectedTileColor: const Color(0xFF007FD4), // VS Code-like selection blue
      selectedColor: Colors.white,
      hoverColor: isSelected ? Colors.transparent : null,
      splashColor: isSelected ? Colors.transparent : null,
      dense: true,
      // Fixed width leading that includes indentation + icon
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: depth * 12.0),
          // White if selected, Green if not
          Icon(
            Icons.account_tree,
            color: isSelected ? Colors.white : Colors.green,
            size: 20,
          ),
        ],
      ),
      minLeadingWidth: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(flow.name, overflow: TextOverflow.ellipsis, maxLines: 1),
      trailing: _buildPopupMenu(context, ref),
      onTap: () {
        ref.read(selectedFlowIdProvider.notifier).set(flow.id);
        ref.read(studioViewControllerProvider.notifier).showEditor(flow.id);
      },
    );
  }

  Widget _buildPopupMenu(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz, color: Theme.of(context).iconTheme.color),
      onSelected: (value) async {
        if (value == 'delete') {
          try {
            await ref
                .read(flowListControllerProvider(flow.collectionId).notifier)
                .deleteFlow(flow.id);
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to delete flow: $e')),
              );
            }
          }
        } else if (value == 'rename') {
          ref.read(renamingFlowIdProvider.notifier).set(flow.id);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'rename', child: Text('Rename')),
        const PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    );
  }
}

class _CollectionInputTile extends ConsumerStatefulWidget {
  final String workspaceId;
  final CollectionEntity? existingCollection;
  final String? parentId;

  const _CollectionInputTile({
    super.key,
    required this.workspaceId,
    this.existingCollection,
    this.parentId,
  });

  @override
  ConsumerState<_CollectionInputTile> createState() =>
      _CollectionInputTileState();
}

class _CollectionInputTileState extends ConsumerState<_CollectionInputTile> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: widget.existingCollection?.name ?? '',
    );
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          _focusNode.requestFocus();
          _focusNode.addListener(_onFocusLost);
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusLost);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusLost() {
    if (!_focusNode.hasFocus && mounted && !_submitted) {
      _submit();
    }
  }

  void _closeInput() {
    if (!mounted) return;
    if (widget.existingCollection != null) {
      ref.read(renamingCollectionIdProvider.notifier).set(null);
    } else {
      ref.read(isCreatingCollectionProvider.notifier).set(false);
      ref.read(creatingSubCollectionForIdProvider.notifier).set(null);
    }
  }

  Future<void> _submit() async {
    if (_submitted) return;
    _submitted = true;
    _focusNode.removeListener(_onFocusLost);

    final value = _textController.text.trim();

    if (value.isEmpty) {
      _closeInput();
      return;
    }

    if (widget.existingCollection != null &&
        value == widget.existingCollection!.name) {
      _closeInput();
      return;
    }

    try {
      if (widget.existingCollection == null) {
        await ref
            .read(collectionListControllerProvider(widget.workspaceId).notifier)
            .createCollection(
              name: value,
              workspaceId: widget.workspaceId,
              parentId: widget.parentId,
            );
      } else {
        await ref
            .read(collectionListControllerProvider(widget.workspaceId).notifier)
            .updateCollection(
              collectionId: widget.existingCollection!.id,
              workspaceId: widget.workspaceId,
              name: value,
            );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
      }
    } finally {
      _closeInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Collection Name',
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}

class _FlowInputTile extends ConsumerStatefulWidget {
  final String collectionId;

  const _FlowInputTile({super.key, required this.collectionId});

  @override
  ConsumerState<_FlowInputTile> createState() => _FlowInputTileState();
}

class _FlowInputTileState extends ConsumerState<_FlowInputTile> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          _focusNode.requestFocus();
          _focusNode.addListener(_onFocusLost);
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusLost);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusLost() {
    if (!_focusNode.hasFocus && mounted && !_submitted) {
      _submit();
    }
  }

  void _closeInput() {
    if (mounted) {
      ref.read(creatingFlowForCollectionIdProvider.notifier).set(null);
    }
  }

  Future<void> _submit() async {
    if (_submitted) return;
    _submitted = true;
    _focusNode.removeListener(_onFocusLost);

    final value = _textController.text.trim();

    if (value.isEmpty) {
      _closeInput();
      return;
    }

    try {
      await ref
          .read(flowListControllerProvider(widget.collectionId).notifier)
          .createFlow(name: value);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to create flow: $e')));
      }
    } finally {
      _closeInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Flow Name',
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}

class _FlowRenameInputTile extends ConsumerStatefulWidget {
  final FlowEntity flow;
  final int depth;

  const _FlowRenameInputTile({
    super.key,
    required this.flow,
    required this.depth,
  });

  @override
  ConsumerState<_FlowRenameInputTile> createState() =>
      _FlowRenameInputTileState();
}

class _FlowRenameInputTileState extends ConsumerState<_FlowRenameInputTile> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.flow.name);
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          _focusNode.requestFocus();
          _focusNode.addListener(_onFocusLost);
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusLost);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusLost() {
    if (!_focusNode.hasFocus && mounted && !_submitted) {
      _submit();
    }
  }

  void _closeInput() {
    if (mounted) {
      ref.read(renamingFlowIdProvider.notifier).set(null);
    }
  }

  Future<void> _submit() async {
    if (_submitted) return;
    _submitted = true;
    _focusNode.removeListener(_onFocusLost);

    final value = _textController.text.trim();

    if (value.isEmpty || value == widget.flow.name) {
      _closeInput();
      return;
    }

    try {
      await ref
          .read(flowListControllerProvider(widget.flow.collectionId).notifier)
          .renameFlow(flowId: widget.flow.id, newName: value);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to rename flow: $e')));
      }
    } finally {
      _closeInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: widget.depth * 12.0),
          const Icon(Icons.account_tree, color: Colors.green, size: 20),
        ],
      ),
      minLeadingWidth: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: TextField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}
