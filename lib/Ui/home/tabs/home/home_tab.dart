import 'package:evently_app/Ui/home/tabs/home/event_item_widget.dart';
import 'package:evently_app/Ui/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});


  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];

  Stream<List<Event>>? eventStream;

  void initState() {
    // TODO: implement initState
    super.initState();
    eventStream = FirebaseUtils.getAllEvents();
  }

  void ubdateStream(int index) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      eventStream = FirebaseUtils.getAllEvents();
    } else {
      eventStream = FirebaseUtils.getFilterAllEvents(selectedIndex);
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: DefaultTabController(
          length: eventsNameList.length,
          child: Column(
            spacing: height * 0.02,
            children: [
              Row(
                spacing: width * 0.04,
                children: [
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcomeback,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        userProvider.currentUser!.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    themeProvider.isDark()
                        ? Icons.brightness_2_outlined
                        : Icons.light_mode_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Text(
                      languageProvider.appLanguage.toUpperCase(),
                      style: AppStyles.semi14whiteColor,
                    ),
                  ),
                ],
              ),
              TabBar(
                onTap: (index) {
                  ubdateStream(index);
                },
                isScrollable: true,
                indicatorColor: AppColors.transparentColor,
                dividerColor: AppColors.transparentColor,
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                tabAlignment: TabAlignment.start,
                tabs: eventsNameList.map((eventName) {
                  return TabItemWidget(
                    isSelected:
                        selectedIndex == eventsNameList.indexOf(eventName),
                    eventName: eventName,
                  );
                }).toList(),
              ),
              Expanded(
                  child: StreamBuilder(stream: eventStream,
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
                        eventsList = snapshot.data!;
                        if (selectedIndex == 0) {
                          filterEventsList = eventsList;
                        } else {
                          filterEventsList = eventsList.where((event) {
                            return event.eventName ==
                                eventsNameList[selectedIndex];
                          }).toList();
                        }

                        return filterEventsList.isEmpty ?
                        Center(child: Text(AppLocalizations.of(context)!
                            .no_events_found,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,),)
                            :
                        ListView.separated(
                          itemBuilder: (context, index) {
                            return EventItemWidget(
                              event: filterEventsList[index],);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: height * 0.02);
                          },
                          itemCount: filterEventsList.length,);
                      }
                    }
                    ,)
                ),

            ],
          ),
        ),
      ),
    );
  }


}
