import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollections() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static CollectionReference<Event> getEventCollections() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static Future<void> addUserInFireStore(MyUser myUser) {
    var CollectionRef = getUsersCollections();
    var docRef = CollectionRef.doc(myUser.id);
    return docRef.set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUsersCollections().doc(uId).get();
    return querySnapshot.data();
  }

  static Future<void> addEventFromFireStore(Event event) {
    var collectionRef = getEventCollections();
    var docRef = collectionRef.doc();
    // todo : auto Id
    event.eventId = docRef.id;
    return docRef.set(event);
  }

  static Stream<List<Event>> getAllEvents() {
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventCollections()
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Stream<List<Event>> getFilterAllEvents(int selectedIndex) {
    var stream = FirebaseUtils.getEventCollections()
        .where('event_category_index', isEqualTo: selectedIndex)
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<void> updateIsFavorite(Event event) {
    return getEventCollections().doc(event.eventId).update({
      'is_favorite': !event.isFavorite,
    });
  }

  static getAllFavoriteEvents() {
    return getEventCollections()
        .where('is_favorite', isEqualTo: true)
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }

  Future<void> updateUser(Event event) {
    return getEventCollections()
        .doc('events')
        .update({'events': event.eventId})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
