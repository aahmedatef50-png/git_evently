import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../model/event.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/size_utils.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * 0.02,
            top: height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).highlightColor,
            border: Border.all(width: 2, color: Theme.of(context).dividerColor),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: width * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit, color: Theme.of(context).cardColor),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: width * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete_outline, color: AppColors.redColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: height * 0.02,
          children: [
            Container(
              height: height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Theme.of(context).dividerColor),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(event!.eventImage),
                ),
              ),
            ),
            Text(
              event.eventTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: width * 0.04,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                spacing: width * 0.04,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.02,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).dividerColor,
                    ),
                    child: Icon(
                      Icons.date_range_outlined,
                      size: 25,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('dd MMM').format(event.eventDate).toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                      Text(
                        DateFormat('h mma').format(event.eventDate).toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              AppLocalizations.of(context)!.description,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).dividerColor),
                color: Theme.of(context).highlightColor,
              ),
              child: Text(
                event.eventDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
