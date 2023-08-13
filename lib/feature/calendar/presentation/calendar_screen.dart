import 'package:calendar_widget/core/utils/my_functions.dart';
import 'package:calendar_widget/feature/calendar/presentation/blocs/calendar_bloc/calendar_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/blocs/day_bloc/day_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/day_item_widget.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/week_days_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@immutable
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalendarBloc()
            ..add(GetMonthDataEvent())
            ..add(GetTypesDataEvent()),
        ),
        BlocProvider(
          create: (context) => DayBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              if (state.status == CalendarStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == CalendarStatus.success) {
                // "year" api dan kelgan yil
                final year = state.date?.year ?? DateTime.now().year;

                // "month" api dan kelgan oy
                final month = state.date?.month ?? DateTime.now().month;

                // "totalDaysNumber" =  berilgan oydagi umumiy kunlar soni
                final totalDaysNumber = MyFunctions.realTotalDaysOfMonth(year, month);

                // "addedDayNumber" kunlar ni besh qator joylashtirilganda 1-qatordaga kunsiz hafta kunlarini soni
                final addedDayNumber = MyFunctions.addedDay(totalDaysNumber, year, month);

                // "days" = jami kunlar: api dan olingan kunlar + va api da yoq kunlar, tartiblangan holatda
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
                              // kuni yoq hafta kunlari uchun bo'sh widget
                              if (index < addedDayNumber) {
                                return const SizedBox();
                              }
                              // "dayNumber" = kunning raqami
                              final dayNumber = index - addedDayNumber + 1;

                              // "isSunday" = kunni yakshanba ekanligi
                              final isSunday = MyFunctions.isSunday(DateTime(year, month, dayNumber));

                              // "day" = Api dan kelgan kun
                              final day = days[dayNumber - 1];

                              // "color" = kunning rangi
                              final color = '0xFF${MyFunctions.getColorForType(state.types ?? [], day.type)}';

                              return DayItemWidget(
                                day: dayNumber,
                                isSunday: isSunday,
                                dayColor: Color(int.parse(color)),
                                onPressed: () {
                                  // day bloc ga tanlangan kun malumotlarinu saqlash event-i
                                  context.read<DayBloc>().add(GetDayDataEvent(
                                      date: DateTime(year, month, dayNumber),
                                      type: day.type,
                                      onSuccess: (DateTime date, int type) {
                                        // agar eventda gi datalar state ga  saqlangan bo'lsa, o'sha datalar function orqali yuboriladi va Snackbar ko'rsatiladi
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red,
                                            duration: const Duration(seconds: 1),
                                            content: Text(
                                              'Date :  ${DateFormat('dd/MM/yyyy').format(date)}, Type : $type',
                                            ),
                                          ),
                                        );
                                      }));
                                },
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
