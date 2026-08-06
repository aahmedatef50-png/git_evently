import 'package:evently_app/utils/size_utils.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  final Widget icon;
  final String eventDateOrTime;
  final String chooseDateOrTime;

  final VoidCallback onChooseDateOrTime;

  DateOrTimeWidget({
    super.key,
    required this.icon,
    required this.eventDateOrTime,
    required this.onChooseDateOrTime,
    required this.chooseDateOrTime,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Row(
      spacing: width * 0.04,
      children: [
        icon,
        Text(eventDateOrTime, style: Theme.of(context).textTheme.titleSmall),
        Spacer(),
        TextButton(
          onPressed: onChooseDateOrTime,
          child: Text(
            chooseDateOrTime,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              decorationColor: Theme.of(context).cardColor,
            ),
          ),
        ),
      ],
    );
  }
}
