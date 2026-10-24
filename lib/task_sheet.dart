import 'package:flutter/material.dart';

import 'strings.dart';

/// Bottom sheet for writing a new task or renaming one. Returns the
/// trimmed text, or null when dismissed.
Future<String?> showTaskSheet(
  BuildContext context, {
  required String heading,
  String initial = '',
  String action = 'Add',
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _TaskSheet(
      heading: heading,
      initial: initial,
      action: action,
    ),
  );
}

class _TaskSheet extends StatefulWidget {
  const _TaskSheet({
    required this.heading,
    required this.initial,
    required this.action,
  });

  final String heading;
  final String initial;
  final String action;

  @override
  State<_TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<_TaskSheet> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.heading, style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: S.of(context).taskHint,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.task_alt),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.of(context).cancel),
              ),
              const SizedBox(width: 8),
              ListenableBuilder(
                listenable: _controller,
                builder: (context, _) => FilledButton(
                  onPressed: _controller.text.trim().isEmpty ? null : _submit,
                  child: Text(widget.action),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
