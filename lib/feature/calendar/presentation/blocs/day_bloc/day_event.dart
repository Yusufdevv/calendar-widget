// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'day_bloc.dart';

sealed class DayEvent {}

class GetDayDataEvent extends DayEvent {
  final DateTime date;
  final int type;
  final Function(DateTime, int) onSuccess;
  GetDayDataEvent({
    required this.date,
    required this.type,
    required this.onSuccess,
  });
}
