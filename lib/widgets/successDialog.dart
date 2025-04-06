import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatefulWidget {
  final String message;
  const SuccessDialog({super.key, required this.message});

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.black38,
      elevation: 15,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset('assets/animations/check.json',
                fit: BoxFit.fill, height: 170, width: 180),
            //Icon(Icons.check_circle, color: Colors.green, size: 70),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Click Anywhere to continue',
                  style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
