import 'package:flutter/material.dart';

class DayItemWidget extends StatelessWidget {
  const DayItemWidget({
    super.key,
    required this.day,
    required this.isSunday,
  });

  final int day;
  final bool isSunday;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
      ),
      child: Text(
        '$day',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSunday ? const Color(0xFFFF5247) : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
