import 'package:calendar_widget/core/utils/my_functions.dart';
import 'package:calendar_widget/feature/calendar/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/day_item_widget.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/week_days_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc()
        ..add(GetMonthDataEvent())
        ..add(GetTypesDataEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              if (state.status == CalendarStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == CalendarStatus.success) {
                final year = state.date?.year ?? DateTime.now().year;
                final month = state.date?.month ?? DateTime.now().month;
                final totalDaysNumber = MyFunctions.realTotalDaysOfMonth(year, month);
                final addedDayNumber = MyFunctions.addedDay(totalDaysNumber, year, month);
                final days = MyFunctions.addOtherDays(state.date!.days, totalDaysNumber);
                return Column(
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
                          semanticChildCount: totalDaysNumber + addedDayNumber,
                          children: List.generate(
                            totalDaysNumber + addedDayNumber,
                            (index) {
                              if (index < addedDayNumber) {
                                return Container();
                              }
                              final dayNumber = index - addedDayNumber + 1;
                              final isSunday = MyFunctions.isSunday(DateTime(year, month, dayNumber));
                              final day = days[dayNumber - 1];
                              final color = '0xFF${MyFunctions.getColorForType(state.types ?? [], day.type)}';
                              return DayItemWidget(
                                day: dayNumber,
                                isSunday: isSunday,
                                dayColor: Color(int.parse(color)),
                                onPressed: () {},
                              );
                            },
                          )),
                    ),
                  ],
                );
              }
              if (state.status == CalendarStatus.failure) {
                return const Center(child: Text('Something went wrong'));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
