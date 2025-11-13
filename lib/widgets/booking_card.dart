import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locallinker/models/booking_model.dart';
import 'package:locallinker/services/booking_service.dart';
import 'package:locallinker/widgets/feedback_dialog.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final bookingService = BookingService();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 25, backgroundImage: NetworkImage(booking.helperImageUrl)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.helperName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(booking.serviceName, style: TextStyle(color: Colors.grey[400])),
                    ],
                  ),
                ),
                if (booking.status == BookingStatus.Completed)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(DateFormat('EEE, MMM d').format(booking.dateTime)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(DateFormat('h:mm a').format(booking.dateTime)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // --- DYNAMIC ACTION BUTTONS ---
            if (booking.status == BookingStatus.Upcoming)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => bookingService.updateBookingStatus(booking.id, 'Completed'),
                  child: const Text("Mark as Complete"),
                ),
              ),
            if (booking.status == BookingStatus.Completed && !booking.feedbackSubmitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => showFeedbackDialog(context, booking),
                  child: const Text("Rate Helper"),
                ),
              ),
            if (booking.status == BookingStatus.Completed && booking.feedbackSubmitted)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey), SizedBox(width: 8), Text("Feedback Submitted", style: TextStyle(color: Colors.grey))]),
          ],
        ),
      ),
    );
  }
}