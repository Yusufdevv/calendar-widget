import 'package:flutter/material.dart';

class ErrorUi extends StatelessWidget {
  const ErrorUi({
    required this.onPressed,
    super.key,
  });
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
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
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.black),
              ),
              child: const Text('Try again!', style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }
}
