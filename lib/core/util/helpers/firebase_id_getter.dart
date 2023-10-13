import 'package:cloud_firestore/cloud_firestore.dart';

/// Gets the document ID of a desired document from Firebase.
///
/// Example: Suppose you have a collection 'countries' with a 'name' field.
/// To get the document ID of 'Germany', use the following:
///
/// ```dart
/// String collectionString = 'countries';
/// String fieldNameToBeQueried = 'name';
/// String searchPattern = 'Germany';
///
/// String? documentId = getDocumentId(collectionString, fieldNameToBeQueried, searchPattern);
/// ```
///
/// Common use case: Document ID can be used to access the fields of the subcollection, i.e., cities of Germany.
Future<String?> getDocumentIdFromCollection<T>({
  required String collectionString,
  required String fieldNameToBeQueried,
  required String searchPattern,
}) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection(collectionString)
      .where(fieldNameToBeQueried, isEqualTo: searchPattern)
      .get();
  final String documentId = querySnapshot.docs.first.id;
  return documentId;
}
