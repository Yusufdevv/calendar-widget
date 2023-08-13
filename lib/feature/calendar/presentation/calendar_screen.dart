import 'package:calendar_widget/feature/calendar/presentation/blocs/calendar_bloc/calendar_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/blocs/day_bloc/day_bloc.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/calendar_widget.dart';
import 'package:calendar_widget/feature/calendar/presentation/widgets/week_days_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalendarBloc()..add(GetMonthDataEvent()),
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
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    WeekDaysPart(),
                    SizedBox(height: 38),
                    CalendarWidget(),
                  ],
                );
              }
              if (state.status == CalendarStatus.failure) {
                return SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Something went wrong',
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            context.read<CalendarBloc>().add(GetMonthDataEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black),
                          ),
                          child: const Text('Try again!', style: TextStyle(color: Colors.black)))
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
