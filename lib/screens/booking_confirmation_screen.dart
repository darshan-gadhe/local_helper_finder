import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/providers/booking_provider.dart';
import 'package:provider/provider.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final ServiceProvider helper;
  const BookingConfirmationScreen({super.key, required this.helper});

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() { _selectedDate = pickedDate; });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() { _selectedTime = pickedTime; });
    });
  }

  void _confirmBooking() async {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a date and time.")));
      return;
    }

    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You must be logged in to book.")));
      return;
    }

    final bookingDateTime = DateTime(
      _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
      _selectedTime!.hour, _selectedTime!.minute,
    );

    final bookingData = {
      'userId': user.uid,
      'helperId': widget.helper.name, // In a real app, use a unique helper ID
      'helperName': widget.helper.name,
      'helperImageUrl': widget.helper.imageUrl,
      'serviceName': widget.helper.service,
      'dateTime': Timestamp.fromDate(bookingDateTime),
      'status': 'Upcoming',
      'feedbackSubmitted': false,
    };

    final success = await bookingProvider.createBooking(bookingData);
    if(success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking confirmed successfully!")));
      // Pop twice to go back to the helper list screen
      Navigator.of(context)..pop()..pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to create booking. Please try again.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You are booking:", style: Theme.of(context).textTheme.titleMedium),
            Text(widget.helper.name, style: Theme.of(context).textTheme.headlineSmall),
            Text(widget.helper.service, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
            const Divider(height: 32),
            Text("Select Date & Time", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Text(_selectedDate == null ? 'No date chosen' : DateFormat.yMMMd().format(_selectedDate!))),
                TextButton(onPressed: _presentDatePicker, child: const Text("Choose Date")),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(_selectedTime == null ? 'No time chosen' : _selectedTime!.format(context))),
                TextButton(onPressed: _presentTimePicker, child: const Text("Choose Time")),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Consumer<BookingProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _confirmBooking,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text("Confirm Booking"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}