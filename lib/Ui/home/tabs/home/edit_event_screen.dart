import 'package:evently_app/Ui/home/tabs/home/add_event/date_or_time_widget.dart';
import 'package:evently_app/Ui/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key, required this.event});

  final Event event;

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
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

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedEventName = '';
  String selectedEventImage = '';

  @override
  void initState() {
    super.initState();

    titleController.text = widget.event.eventTitle;
    descriptionController.text = widget.event.eventDescription;

    selectedDate = widget.event.eventDate;
    selectedTime = TimeOfDay.fromDateTime(widget.event.eventDate);

    selectedIndex = widget.event.eventCategoryIndex - 1;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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

    selectedEventName = eventsNameList[selectedIndex];

    selectedEventImage = themeProvider.isDark()
        ? eventDarkImagesList[selectedIndex]
        : eventLightImagesList[selectedIndex];

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
          AppLocalizations.of(context)!.edit_event,
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
                      image: AssetImage(selectedEventImage),
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
                          setState(() {
                            selectedIndex = index;
                          });
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
                  controller: titleController,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: AppLocalizations.of(context)!.event_title,
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
                  controller: descriptionController,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  maxLines: 4,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: AppLocalizations.of(context)!.event_description,
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
                  onPressed: editEvent,
                  child: Text(
                    AppLocalizations.of(context)!.edit_event,
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

  void editEvent() {
    if (formKey.currentState?.validate() != true) {
      final updatedEvent = Event(
        eventId: widget.event.eventId,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventTitle: titleController.text.trim(),
        eventCategoryIndex: selectedIndex + 1,
        eventDescription: descriptionController.text.trim(),
        eventDate: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
      );
      FirebaseUtils()
          .updateUser(updatedEvent)
          .then((value) {
            ToastUtils.showToastMessage(
              message: "Event Edit Successfully.",
              backgroundColor: AppColors.mainLightColor,
              textColor: AppColors.whiteColor,
            );
            Navigator.pop(context);
          })
          .catchError((error) {
            ToastUtils.showToastMessage(
              message: error.toString(),
              backgroundColor: AppColors.mainLightColor,
              textColor: AppColors.whiteColor,
            );
          });
    }

    final updatedEvent = Event(
      eventImage: selectedEventImage,
      eventName: selectedEventName,
      eventTitle: titleController.text.trim(),
      eventCategoryIndex: selectedIndex + 1,
      eventDescription: descriptionController.text.trim(),
      eventDate: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      ),
    );
  }

  void onChooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }

  void onChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (chooseTime != null) {
      selectedTime = chooseTime;
      setState(() {});
    }
  }
}
