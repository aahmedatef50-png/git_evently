import 'package:evently_app/Ui/home/tabs/home/add_event/date_or_time_widget.dart';
import 'package:evently_app/Ui/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<String> eventLightImagesList = [
    AppAssets.sport_light,
    AppAssets.birthday_light,
    AppAssets.meeting_light,
    AppAssets.book_club_light,
    AppAssets.exhbition_light,
  ];

  List<String> eventDarkImagesList = [
    AppAssets.sport_dark,
    AppAssets.birthday_dark,
    AppAssets.meeting_dark,
    AppAssets.book_club_dark,
    AppAssets.exhbition_dark,
  ];

  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final formKey = GlobalKey<FormState>();
  var title = '';
  var description = '';

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];
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
          AppLocalizations.of(context)!.add_event,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                      image: AssetImage(
                        themeProvider.isDark()
                            ? eventDarkImagesList[selectedIndex]
                            : eventLightImagesList[selectedIndex],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabItemWidget(
                          isSelected: selectedIndex == index,
                          eventName: eventsNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.02);
                    },
                    itemCount: eventsNameList.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: AppLocalizations.of(context)!.event_title,
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Event Title';
                    }
                    return null;
                  },
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  maxLines: 4,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: AppLocalizations.of(context)!.event_description,
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Event Description';
                    }
                    return null;
                  },
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                ),
                DateOrTimeWidget(
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.event_date,
                  onChooseDateOrTime: onChooseDate,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                ),
                DateOrTimeWidget(
                  icon: Icon(Icons.timer, color: Theme.of(context).cardColor),
                  eventDateOrTime: AppLocalizations.of(context)!.event_time,
                  onChooseDateOrTime: onChooseTime,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : selectedTime!.format(context),
                ),
                CustomElevatedButton(
                  verticalPadding: height * 0.01,
                  backgroundColor: Theme.of(context).cardColor,
                  onPressed: addEvent,
                  child: Text(
                    AppLocalizations.of(context)!.add_event,
                    style: AppStyles.medium20white,
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      // todo add event
    }
  }

  void onChooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }

  void onChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (chooseTime != null) {
      selectedTime = chooseTime;
      setState(() {});
    }
  }
}
