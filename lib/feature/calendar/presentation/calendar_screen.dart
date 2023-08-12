import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  final List<String> days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  int realTotalDaysOfMonth(int year, int month) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);

    // Berilgan oyning oxirgi kunini olish
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    // Birinchi va oxirgi kunlarni hisoblash
    int numberOfDaysInMonth = lastDayOfMonth.day - firstDayOfMonth.day + 1;

    return numberOfDaysInMonth;
  }

  int addedDay(int totalDays, int year, int month) {
    DateTime firstDayOfAugust = DateTime(year, month, 1);

    // Hafta kunlarini aniqlash
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

  @override
  Widget build(BuildContext context) {
    final totalDays = realTotalDaysOfMonth(2023, 8);
    final addDay = addedDay(totalDays, 2023, 8);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: List.generate(
                  days.length,
                  (index) => Expanded(
                    child: Text(
                      days[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF6C7072),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.86,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 38),
            Expanded(
              child: GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  semanticChildCount: totalDays + addDay,
                  children: List.generate(
                    totalDays + addDay,
                    (index) {
                      if (index < addDay) {
                        return Container();
                      }
                      return Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        child: Text(
                          '${index - addDay + 1}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  )),
            )
          ],
        )));
  }
}
