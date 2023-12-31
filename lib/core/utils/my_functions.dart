import 'package:calendar_widget/feature/calendar/data/models/day_model.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';
import 'package:intl/intl.dart';

class MyFunctions {
  static int totalDaysOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);

    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

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

  static List<DayModel> addOtherDays(List<DayModel> days, int monthTotolDay) {
    List<DayModel> allDays = [];

    for (int day = 1; day <= monthTotolDay; day++) {
      bool dayExists = false;
      for (var dayData in days) {
        if (dayData.day == day) {
          dayExists = true;
          allDays.add(dayData);
          break;
        }
      }

      if (!dayExists) {
        allDays.add(DayModel(day: day, type: 0));
      }
    }

    return allDays;
  }

  static String getColorForType(List<TypeModel> typeModels, int inputType) {
    if (typeModels.isEmpty) {
      return "FFFFFF";
    }
    String color = "#FFFFFF"; // Agar mos kelmasa oq rang ga teng boladi

    for (var typeModel in typeModels) {
      if (typeModel.type == inputType) {
        color = typeModel.color;
        break;
      }
    }
    return color.replaceAll("#", "");
  }
}
