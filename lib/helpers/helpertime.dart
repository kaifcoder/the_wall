import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  return "${date.day}/${date.month}/${date.year}";
}
