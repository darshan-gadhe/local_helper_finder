import 'package:locallinker/models/service_provider_model.dart';

enum BookingStatus { Upcoming, Completed, Cancelled }

class Booking {
  final ServiceProvider provider;
  final String serviceName;
  final DateTime dateTime;
  final BookingStatus status;

  Booking({
    required this.provider,
    required this.serviceName,
    required this.dateTime,
    required this.status,
  });
}

// Dummy Data for demonstration
final List<Booking> upcomingBookings = [
  Booking(
    provider: popularProviders[1], // Sunita Sharma
    serviceName: "Switchboard Repair",
    dateTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
    status: BookingStatus.Upcoming,
  ),
  Booking(
    provider: popularProviders[0], // Ramesh Kumar
    serviceName: "Kitchen Sink Leakage",
    dateTime: DateTime.now().add(const Duration(days: 4, hours: 5)),
    status: BookingStatus.Upcoming,
  ),
];

final List<Booking> completedBookings = [
  Booking(
    provider: popularProviders[2], // Amit Singh
    serviceName: "Airport Drop",
    dateTime: DateTime.now().subtract(const Duration(days: 10)),
    status: BookingStatus.Completed,
  ),
];