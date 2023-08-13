import 'package:calendar_widget/core/utils/my_functions.dart';
import 'package:calendar_widget/feature/calendar/data/models/day_model.dart';
import 'package:calendar_widget/feature/calendar/data/models/type_model.dart';
import 'package:calendar_widget/feature/calendar/presentation/blocs/calendar_bloc/calendar_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/blocs/day_bloc/day_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/day_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final int year;
  late final int month;
  late final int totalDaysNumber;
  late final int addedDayNumber;
  late final List<DayModel> days;
  late final List<TypeModel>? types;
  @override
  void initState() {
    final state = context.read<CalendarBloc>().state;

    // "year" api dan kelgan yil
    year = state.date?.year ?? DateTime.now().year;

    // "month" api dan kelgan oy
    month = state.date?.month ?? DateTime.now().month;

    // "totalDaysNumber" =  berilgan oydagi umumiy kunlar soni
    totalDaysNumber = MyFunctions.realTotalDaysOfMonth(year, month);

    // "addedDayNumber" kunlar ni besh qator joylashtirilganda 1-qatordaga kunsiz hafta kunlarini soni
    addedDayNumber = MyFunctions.addedDay(totalDaysNumber, year, month);

    // "days" = jami kunlar: api dan olingan kunlar + va api da yoq kunlar, tartiblangan holatda
    days = MyFunctions.addOtherDays(state.date?.days ?? [], totalDaysNumber);

    // "types" = api dan kelgan type lar
    types = state.types;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              print('======= ${days.length}');

              // "color" = kunning rangi
              final color = '0xFF${MyFunctions.getColorForType(types ?? [], day.type)}';
              print('======= ${color}');

              return DayItemWidget(
                day: dayNumber,
                isSunday: isSunday,
                dayColor: Color(int.parse(color)),
                onPressed: () {
                  // agar day oddiy kun bolsa event ishlashi shart emas
                  if (day.type == 0) {
                    return;
                  }
                  // DayBloc ga tanlangan kun malumotlarini saqlash event-i
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
    );
  }
}
