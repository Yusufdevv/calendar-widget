import 'package:flutter/material.dart';

abstract class DayAbstract extends CalendarDatePicker {
  DayAbstract(
      {super.key,
      required super.initialDate,
      required super.firstDate,
      required super.lastDate,
      required super.onDateChanged});
}
