import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moodly/shared/theme.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key, required this.time, required this.value})
      : super(key: key);

  final double value;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    String day = DateFormat('EEE').format(time.toDate()).toString();

    return Column(
      children: [
        SizedBox(
          height: 85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 20,
                height: 85 * value,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: greyText.copyWith(
            fontSize: 12,
            fontWeight: medium,
          ),
        )
      ],
    );
  }
}
