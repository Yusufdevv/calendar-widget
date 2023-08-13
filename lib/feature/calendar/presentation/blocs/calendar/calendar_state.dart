part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState {
  final DateModel? date;
  final List<TypeModel>? types;
  final CalendarStatus status;
  CalendarState({
    this.date,
    this.types,
    required this.status,
  });

  CalendarState copyWith({
    DateModel? date,
    List<TypeModel>? types,
    CalendarStatus? status,
  }) {
    return CalendarState(
      date: date ?? this.date,
      types: types ?? this.types,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'CalendarState(date: $date, types: $types, status: $status)';

  @override
  bool operator ==(covariant CalendarState other) {
    if (identical(this, other)) return true;

    return other.date == date && other.types == types && other.status == status;
  }

  @override
  int get hashCode => date.hashCode ^ types.hashCode ^ status.hashCode;
}
