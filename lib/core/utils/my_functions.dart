import 'package:intl/intl.dart';

class MyFunctions {
  static int realTotalDaysOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);

    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    // Birinchi kunni hisoblash
    int numberOfDaysInMonth = lastDayOfMonth.day - firstDayOfMonth.day + 1;

    return numberOfDaysInMonth;
  }

  static int addedDay(int totalDays, int year, int month) {
    DateTime firstDayOfAugust = DateTime(year, month, 1);

    DateFormat dayOfWeekFormat = DateFormat('EEE');
    String firstDayOfWeek = dayOfWeekFormat.format(firstDayOfAugust);
    switch (firstDayOfWeek) {
      case 'Mon':
        return 0;
      case 'Tue':
        return 1;
      case 'Wed':
        return 2;
      case 'Thu':
        return 3;
      case 'Fri':
        return 4;
      case 'Sat':
        return 5;
      case 'Sun':
        return 6;
      default:
        return 0;
    }
  }

  static bool isSunday(DateTime day) {
    DateTime dateToCheck = day; // Tekshiriladigan kun

    return dateToCheck.weekday == DateTime.sunday;
  }
}
