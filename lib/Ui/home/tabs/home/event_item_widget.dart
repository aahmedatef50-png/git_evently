import 'package:evently_app/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../model/event.dart';
import '../../../../utils/size_utils.dart';

class EventItemWidget extends StatelessWidget {
  final Event event;

  const EventItemWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Container(
      height: height * 0.25,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: Theme.of(context).dividerColor),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.eventImage),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Text(
              DateFormat('dd MMM').format(event.eventDate).toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.eventTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseUtils.updateIsFavorite(event);
                  },
                  icon: Icon(
                    event.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
