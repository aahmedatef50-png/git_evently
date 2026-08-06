import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../home/event_item_widget.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: SafeArea(
        child: Column(
          spacing: height * 0.02,
          children: [
            CustomTextField(
              filled: true,
              fillColor: Theme.of(context).highlightColor,
              borderColor: Theme.of(context).dividerColor,
              hintText: AppLocalizations.of(context)!.search_for_event,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffixIcon: Icon(
                Icons.search,
                color: Theme.of(context).cardColor,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItemWidget();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.02);
                },
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
