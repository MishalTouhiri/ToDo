import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todomonth/main.dart';
import 'package:todomonth/task_store.dart';

Future<TaskStore> _store() async {
  SharedPreferences.setMockInitialValues({});
  return TaskStore(await SharedPreferences.getInstance(),
      month: DateTime(2026, 10));
}

Future<void> _addTask(WidgetTester tester, String title) async {
  await tester.tap(find.text('Add task'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), title);
  await tester.pump();
  await tester.tap(find.widgetWithText(FilledButton, 'Add'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('adds, completes, edits and deletes a task', (tester) async {
    final store = await _store();
    await tester.pumpWidget(TodoMonthApp(store: store));

    expect(find.text('Nothing planned for week 1'), findsOneWidget);

    await _addTask(tester, 'Read a chapter');
    expect(find.text('Read a chapter'), findsOneWidget);
    expect(find.text('0 of 1 tasks done'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(store.completed, 1);
    expect(find.text('1 of 1 tasks done'), findsOneWidget);

    await tester.tap(find.byTooltip('Task options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Read two chapters');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Read two chapters'), findsOneWidget);

    await tester.tap(find.byTooltip('Task options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(store.total, 0);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('Read two chapters'), findsOneWidget);
  });

  testWidgets('keeps tasks in the week they were added to', (tester) async {
    final store = await _store();
    await tester.pumpWidget(TodoMonthApp(store: store));

    await tester.tap(find.text('Week 3'));
    await tester.pumpAndSettle();
    await _addTask(tester, 'Pay rent');

    expect(store.week(2).single.title, 'Pay rent');
    expect(store.week(0), isEmpty);
  });

  testWidgets('shows Arabic text right to left on an Arabic device',
      (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('ar')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    final store = await _store();
    await tester.pumpWidget(TodoMonthApp(store: store));

    expect(find.text('إضافة مهمة'), findsOneWidget);
    expect(find.text('أكتوبر 2026'), findsOneWidget);
    expect(Directionality.of(tester.element(find.text('إضافة مهمة'))),
        TextDirection.rtl);
  });

  test('saves tasks per month', () async {
    final store = await _store();
    store.add(0, 'October task');
    store.changeMonth(1);
    expect(store.total, 0);
    store.changeMonth(-1);
    expect(store.week(0).single.title, 'October task');

    final reloaded = TaskStore(await SharedPreferences.getInstance(),
        month: DateTime(2026, 10));
    expect(reloaded.week(0).single.title, 'October task');
  });

  test('last week runs to the end of the month', () async {
    final store = await _store();
    final (start, end) = store.weekRange(3);
    expect(start.day, 22);
    expect(end.day, 31);
  });
}
