import 'package:calendar_widget/core/utils/my_functions.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/day_item_widget.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/week_days_part.dart';
import 'package:flutter/material.dart';

@immutable
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalDays = MyFunctions.realTotalDaysOfMonth(2023, 8);
    final addedDay = MyFunctions.addedDay(totalDays, 2023, 8);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const WeekDaysPart(),
            const SizedBox(height: 38),
            Expanded(
              child: GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  semanticChildCount: totalDays + addedDay,
                  children: List.generate(
                    totalDays + addedDay,
                    (index) {
                      if (index < addedDay) {
                        return Container();
                      }
                      final day = index - addedDay + 1;
                      return DayItemWidget(day: day);
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
