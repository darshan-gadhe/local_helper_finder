import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locallinker/models/booking_model.dart';
import 'package:locallinker/services/booking_service.dart';
import 'package:locallinker/widgets/booking_card.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final BookingService _bookingService = BookingService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Bookings", style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _bookingService.getUserBookingsStream(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("You have no bookings yet."));
            }

            final allBookings = snapshot.data!.docs.map((doc) => Booking.fromFirestore(doc)).toList();

            final upcoming = allBookings.where((b) => b.status == BookingStatus.Upcoming).toList();
            final completed = allBookings.where((b) => b.status == BookingStatus.Completed).toList();
            final cancelled = allBookings.where((b) => b.status == BookingStatus.Cancelled).toList();

            return TabBarView(
              children: [
                _buildBookingList(upcoming),
                _buildBookingList(completed),
                _buildBookingList(cancelled),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookingList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return const Center(child: Text("No bookings in this category.", style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: BookingCard(booking: bookings[index]),
        );
      },
    );
  }
}