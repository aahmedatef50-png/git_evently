import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'events';
  String eventId;

  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavorite;
  int eventCategoryIndex;

  Event({
    this.eventId = '',
    required this.eventImage,
    required this.eventName,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    this.isFavorite = false,
    required this.eventCategoryIndex,
  });

  // todo : json => object
  Event.fromJson(Map<String, dynamic> data)
    : this(
        eventId: data['event_id'],
        eventImage: data['event_image'],
        eventName: data['event_name'],
        eventTitle: data['event_title'],
        eventDescription: data['event_description'],
        eventDate: (data['event_date'] as Timestamp).toDate(),
        eventCategoryIndex: data['event_category_index'],
        isFavorite: data['is_favorite'],
      );

  // todo : object => json
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'event_image': eventImage,
      'event_name': eventName,
      'event_title': eventTitle,
      'event_description': eventDescription,
      'event_category_index': eventCategoryIndex,
      'event_date': eventDate,
      'is_favorite': isFavorite,
    };
  }
}
