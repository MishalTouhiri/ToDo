import 'package:flutter/material.dart';

import 'task_sheet.dart';
import 'task_store.dart';
import 'week_tasks.dart';

const _months = [
  'January', 'February', 'March', 'April', 'May', 'June', 'July', //
  'August', 'September', 'October', 'November', 'December',
];

class TasksPage extends StatefulWidget {
  const TasksPage({super.key, required this.store});

  final TaskStore store;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs =
      TabController(length: TaskStore.weekCount, vsync: this);

  TaskStore get store => widget.store;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    final week = _tabs.index;
    final title =
        await showTaskSheet(context, heading: 'New task · Week ${week + 1}');
    if (title != null) store.add(week, title);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) => Scaffold(
        backgroundColor: colors.surfaceContainerLowest,
        body: SafeArea(
          child: Column(
            children: [
              _Header(store: store),
              TabBar(
                controller: _tabs,
                dividerColor: colors.outlineVariant,
                tabs: [
                  for (var i = 0; i < TaskStore.weekCount; i++)
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Week ${i + 1}'),
                          if (store.week(i).isNotEmpty) ...[
                            const SizedBox(width: 6),
                            _CountBadge(
                              '${store.doneIn(i)}/${store.week(i).length}',
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabs,
                  children: [
                    for (var i = 0; i < TaskStore.weekCount; i++)
                      WeekTasksView(store: store, week: i),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addTask,
          icon: const Icon(Icons.add),
          label: const Text('Add task'),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.store});

  final TaskStore store;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final progress = store.total == 0 ? 0.0 : store.completed / store.total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit_calendar_rounded, color: colors.primary),
              const SizedBox(width: 8),
              Text(
                'TodoMonth',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Previous month',
                onPressed: () => store.changeMonth(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_months[store.month.month - 1]} ${store.month.year}',
                style: theme.textTheme.titleSmall,
              ),
              IconButton(
                tooltip: 'Next month',
                onPressed: () => store.changeMonth(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Color(0xFF0284C7), Color(0xFF6366F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 6,
                        color: Colors.white,
                        backgroundColor: Colors.white.withValues(alpha: 0.25),
                      ),
                      Center(
                        child: Text(
                          '${(progress * 100).round()}%',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly progress',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        store.total == 0
                            ? 'Plan your month one week at a time'
                            : '${store.completed} of ${store.total} tasks done',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: colors.onPrimaryContainer),
      ),
    );
  }
}
