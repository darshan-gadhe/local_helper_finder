import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingStatus { Upcoming, Completed, Cancelled }

class Booking {
  final String id;
  final String userId;
  final String helperId;
  final String helperName;
  final String helperImageUrl;
  final String serviceName;
  final DateTime dateTime;
  final BookingStatus status;
  final bool feedbackSubmitted;

  Booking({
    required this.id,
    required this.userId,
    required this.helperId,
    required this.helperName,
    required this.helperImageUrl,
    required this.serviceName,
    required this.dateTime,
    required this.status,
    this.feedbackSubmitted = false,
  });

  // Factory constructor to create a Booking from a Firestore document
  factory Booking.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Booking(
      id: doc.id,
      userId: data['userId'] ?? '',
      helperId: data['helperId'] ?? '',
      helperName: data['helperName'] ?? '',
      helperImageUrl: data['helperImageUrl'] ?? '',
      serviceName: data['serviceName'] ?? 'Service',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      status: BookingStatus.values.byName(data['status'] ?? 'Upcoming'),
      feedbackSubmitted: data['feedbackSubmitted'] ?? false,
    );
  }
}