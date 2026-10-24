import 'package:flutter/widgets.dart';

/// UI text in English and Arabic, picked from the app's locale.
class S {
  const S._(this.isArabic);

  final bool isArabic;

  static const supportedLocales = [Locale('en'), Locale('ar')];

  static S of(BuildContext context) =>
      S._(Localizations.localeOf(context).languageCode == 'ar');

  String _t(String en, String ar) => isArabic ? ar : en;

  String get appTitle => 'TodoMonth';
  String get addTask => _t('Add task', 'إضافة مهمة');
  String get previousMonth => _t('Previous month', 'الشهر السابق');
  String get nextMonth => _t('Next month', 'الشهر التالي');
  String get monthlyProgress => _t('Monthly progress', 'إنجاز الشهر');
  String get emptyMonth =>
      _t('Plan your month one week at a time', 'خطّط شهرك أسبوعًا بأسبوع');
  String doneOfTotal(int done, int total) =>
      _t('$done of $total tasks done', 'المنجز $done من $total');
  String week(int number) => _t('Week $number', 'أسبوع $number');
  String newTaskHeading(int week) =>
      _t('New task · Week $week', 'مهمة جديدة · الأسبوع $week');
  String get editTask => _t('Edit task', 'تعديل المهمة');
  String get save => _t('Save', 'حفظ');
  String get add => _t('Add', 'إضافة');
  String get cancel => _t('Cancel', 'إلغاء');
  String get taskHint => _t('What do you need to do?', 'وش تبي تنجز؟');
  String deleted(String title) => _t('Deleted "$title"', 'حُذفت "$title"');
  String get undo => _t('Undo', 'تراجع');
  String get taskOptions => _t('Task options', 'خيارات المهمة');
  String get edit => _t('Edit', 'تعديل');
  String get delete => _t('Delete', 'حذف');
  String emptyWeek(int week) =>
      _t('Nothing planned for week $week', 'ما فيه مهام للأسبوع $week');
  String get emptyWeekHint => _t(
      'Tap “Add task” to plan your week.', 'اضغط "إضافة مهمة" وخطّط أسبوعك.');
  String weekDone(int done, int total) =>
      _t('$done of $total done', 'المنجز $done من $total');

  /// Dates of a week, e.g. "Oct 1 – 7" or "1 – 7 أكتوبر".
  String dayRange(DateTime start, DateTime end) => isArabic
      ? '${start.day} – ${end.day} ${month(start.month)}'
      : '${shortMonth(start.month)} ${start.day} – ${end.day}';

  String month(int month) => (isArabic ? _arMonths : _enMonths)[month - 1];
  String shortMonth(int month) =>
      isArabic ? _arMonths[month - 1] : _enMonths[month - 1].substring(0, 3);

  static const _enMonths = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', //
    'August', 'September', 'October', 'November', 'December',
  ];
  static const _arMonths = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', //
    'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];
}
