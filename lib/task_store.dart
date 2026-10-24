import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

/// Holds the tasks of one month split into four weeks and saves them on
/// the device, so each month keeps its own plan.
class TaskStore extends ChangeNotifier {
  TaskStore(this._prefs, {DateTime? month})
      : _month = _firstOfMonth(month ?? DateTime.now()) {
    _load();
  }

  static const weekCount = 4;

  final SharedPreferences _prefs;
  DateTime _month;
  List<List<Task>> _weeks = List.generate(weekCount, (_) => []);
  int _nextId = 0;

  DateTime get month => _month;

  List<Task> week(int index) => List.unmodifiable(_weeks[index]);

  int get total => _weeks.fold(0, (sum, w) => sum + w.length);

  int get completed =>
      _weeks.fold(0, (sum, w) => sum + w.where((t) => t.done).length);

  int doneIn(int week) => _weeks[week].where((t) => t.done).length;

  /// First and last day of [week] in the current month (the last week
  /// runs to the end of the month).
  (DateTime, DateTime) weekRange(int week) {
    final start = DateTime(_month.year, _month.month, week * 7 + 1);
    final lastDay = DateTime(_month.year, _month.month + 1, 0).day;
    final end = DateTime(_month.year, _month.month,
        week == weekCount - 1 ? lastDay : week * 7 + 7);
    return (start, end);
  }

  void changeMonth(int delta) {
    _month = DateTime(_month.year, _month.month + delta);
    _load();
    notifyListeners();
  }

  void add(int week, String title) {
    _weeks[week].add(Task(id: _newId(), title: title));
    _commit();
  }

  void insert(int week, int index, Task task) {
    _weeks[week].insert(index.clamp(0, _weeks[week].length), task);
    _commit();
  }

  void rename(int week, String id, String title) =>
      _update(week, id, (t) => t.copyWith(title: title));

  void toggle(int week, String id) =>
      _update(week, id, (t) => t.copyWith(done: !t.done));

  /// Removes the task and returns its position so it can be restored.
  (int, Task)? remove(int week, String id) {
    final index = _weeks[week].indexWhere((t) => t.id == id);
    if (index == -1) return null;
    final task = _weeks[week].removeAt(index);
    _commit();
    return (index, task);
  }

  void _update(int week, String id, Task Function(Task) change) {
    final index = _weeks[week].indexWhere((t) => t.id == id);
    if (index == -1) return;
    _weeks[week][index] = change(_weeks[week][index]);
    _commit();
  }

  String _newId() => '${DateTime.now().microsecondsSinceEpoch}-${_nextId++}';

  String get _key =>
      'tasks-${_month.year}-${_month.month.toString().padLeft(2, '0')}';

  void _load() {
    final raw = _prefs.getString(_key);
    _weeks = List.generate(weekCount, (_) => []);
    if (raw == null) return;
    final decoded = jsonDecode(raw) as List<dynamic>;
    for (var i = 0; i < weekCount && i < decoded.length; i++) {
      _weeks[i] = (decoded[i] as List<dynamic>)
          .map((t) => Task.fromJson(t as Map<String, dynamic>))
          .toList();
    }
  }

  void _commit() {
    notifyListeners();
    _prefs.setString(
      _key,
      jsonEncode([
        for (final w in _weeks) [for (final t in w) t.toJson()]
      ]),
    );
  }

  static DateTime _firstOfMonth(DateTime d) => DateTime(d.year, d.month);
}
