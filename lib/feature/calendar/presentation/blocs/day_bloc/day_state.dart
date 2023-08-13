part of 'day_bloc.dart';

sealed class DayState {
  final DateTime date;
  final int type;

  DayState(this.date, this.type);
}

final class DayInitial extends DayState {
  DayInitial(super.date, super.type);
}
