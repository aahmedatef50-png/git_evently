import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../model/event.dart';
import '../../../../utils/app_colors.dart';
import '../home/event_item_widget.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  Stream<List<Event>>? favoriteStream;
  List<Event> favoriteList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoriteStream = FirebaseUtils.getAllFavoriteEvents();
  }
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
                child: StreamBuilder(stream: favoriteStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainLightColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,),);
                    } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(child: Text(AppLocalizations.of(context)!
                          .no_events_found,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,),);
                    } else {
                      favoriteList = snapshot.data!;

                      return favoriteList.isEmpty ?
                      Center(child: Text(AppLocalizations.of(context)!
                          .no_events_found,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineMedium,),)
                          :
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return EventItemWidget(event: favoriteList[index],);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: height * 0.02);
                        },
                        itemCount: favoriteList.length,);
                    }
                  }
                  ,)
            ),

          ],
        ),
      ),
    );
  }
}
