import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new booking
  Future<void> createBooking(Map<String, dynamic> bookingData) {
    return _db.collection('bookings').add(bookingData);
  }

  // Get a stream of bookings for a specific user
  Stream<QuerySnapshot> getUserBookingsStream(String userId) {
    return _db
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  // Update booking status
  Future<void> updateBookingStatus(String bookingId, String newStatus) {
    return _db.collection('bookings').doc(bookingId).update({'status': newStatus});
  }

  // Submit feedback and update booking
  Future<void> submitFeedback(String bookingId, String helperId, String userId, double rating, String review) async {
    final reviewData = {
      'bookingId': bookingId,
      'helperId': helperId,
      'userId': userId,
      'rating': rating,
      'review': review,
      'createdAt': Timestamp.now(),
    };

    // In a real app, use a transaction or a cloud function to ensure both writes succeed.
    await _db.collection('reviews').add(reviewData);
    await _db.collection('bookings').doc(bookingId).update({'feedbackSubmitted': true});

    // IMPORTANT: Calculating and updating the helper's average rating should be done
    // on a secure backend (like Firebase Cloud Functions) to prevent manipulation.
    // We are skipping that complex client-side logic here.
  }
}