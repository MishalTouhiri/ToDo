// class Task {
//   final String title;
//   final String description;
//   final DateTime dueDate;
//   final int week;
//   bool completed;

//   Task({
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.week,
//     this.completed = false,
//   });

//   Task copyWith({
//     String? title,
//     String? description,
//     DateTime? dueDate,
//     int? week,
//     bool? completed,
//   }) {
//     return Task(
//       title: title ?? this.title,
//       description: description ?? this.description,
//       dueDate: dueDate ?? this.dueDate,
//       week: week ?? this.week,
//       completed: completed ?? this.completed,
//     );
//   }
// }