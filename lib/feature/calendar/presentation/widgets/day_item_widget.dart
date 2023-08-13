import 'package:flutter/material.dart';

class DayItemWidget extends StatelessWidget {
  const DayItemWidget({
    super.key,
    required this.day,
    required this.isSunday,
    required this.dayColor,
    required this.onPressed,
  });

  final int day;
  final bool isSunday;
  final Color dayColor;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            backgroundColor: dayColor,
            elevation: dayColor == const Color(0xFFFFFFFF) ? 0 : 1),
        onPressed: onPressed,
        child: Text(
          '$day',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSunday ? const Color(0xFFFF5247) : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
