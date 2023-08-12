import 'package:flutter/material.dart';

class WeekDaysPart extends StatelessWidget {
  const WeekDaysPart({
    super.key,
  });

  final List<String> days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
