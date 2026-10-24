import 'package:flutter/material.dart';

import 'task.dart';
import 'task_sheet.dart';
import 'task_store.dart';

const _shortMonths = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

class WeekTasksView extends StatelessWidget {
  const WeekTasksView({super.key, required this.store, required this.week});

  final TaskStore store;
  final int week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tasks = store.week(week);
    final (start, end) = store.weekRange(week);
    final range = '${_shortMonths[start.month - 1]} ${start.day} – ${end.day}';

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            tasks.isEmpty
                ? range
                : '$range · ${store.doneIn(week)} of ${tasks.length} done',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        if (tasks.isEmpty)
          _EmptyWeek(week: week)
        else
          for (final task in tasks)
            _TaskTile(
                key: ValueKey(task.id), store: store, week: week, task: task),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    super.key,
    required this.store,
    required this.week,
    required this.task,
  });

  final TaskStore store;
  final int week;
  final Task task;

  Future<void> _edit(BuildContext context) async {
    final title = await showTaskSheet(
      context,
      heading: 'Edit task',
      initial: task.title,
      action: 'Save',
    );
    if (title != null) store.rename(week, task.id, title);
  }

  void _delete(BuildContext context) {
    final removed = store.remove(week, task.id);
    if (removed == null) return;
    final (index, deleted) = removed;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('Deleted "${deleted.title}"'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => store.insert(week, index, deleted),
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: ValueKey('dismiss-${task.id}'),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => _delete(context),
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: colors.errorContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.delete_outline, color: colors.onErrorContainer),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: task.done ? colors.surfaceContainerHigh : colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colors.outlineVariant),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 8, right: 4),
            leading: Checkbox(
              value: task.done,
              shape: const CircleBorder(),
              onChanged: (_) => store.toggle(week, task.id),
            ),
            title: Text(
              task.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                decoration: task.done ? TextDecoration.lineThrough : null,
                color: task.done ? colors.onSurfaceVariant : colors.onSurface,
              ),
            ),
            onTap: () => store.toggle(week, task.id),
            trailing: PopupMenuButton<String>(
              tooltip: 'Task options',
              onSelected: (choice) =>
                  choice == 'edit' ? _edit(context) : _delete(context),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text('Delete'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyWeek extends StatelessWidget {
  const _EmptyWeek({required this.week});

  final int week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: colors.primaryContainer,
            child: Icon(Icons.event_note_rounded,
                size: 40, color: colors.onPrimaryContainer),
          ),
          const SizedBox(height: 16),
          Text('Nothing planned for week ${week + 1}',
              style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            'Tap “Add task” to plan your week.',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
