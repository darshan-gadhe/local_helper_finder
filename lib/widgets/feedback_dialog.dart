import 'package:flutter/material.dart';
import 'package:locallinker/models/booking_model.dart';
import 'package:locallinker/services/booking_service.dart';

void showFeedbackDialog(BuildContext context, Booking booking) {
  showDialog(
    context: context,
    builder: (ctx) => FeedbackDialog(booking: booking),
  );
}

class FeedbackDialog extends StatefulWidget {
  final Booking booking;
  const FeedbackDialog({super.key, required this.booking});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  double _rating = 0;
  final _reviewController = TextEditingController();
  final BookingService _bookingService = BookingService();
  bool _isLoading = false;

  void _submitFeedback() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a star rating.")));
      return;
    }
    setState(() => _isLoading = true);
    await _bookingService.submitFeedback(
      widget.booking.id,
      widget.booking.helperId,
      widget.booking.userId,
      _rating,
      _reviewController.text.trim(),
    );
    setState(() => _isLoading = false);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rate your experience'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How was your service with ${widget.booking.helperName}?'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => setState(() => _rating = index + 1.0),
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Add a review (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _submitFeedback,
          child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Submit'),
        ),
      ],
    );
  }
}