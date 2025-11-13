import 'package:flutter/material.dart';
import 'package:locallinker/services/booking_service.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService = BookingService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<bool> createBooking(Map<String, dynamic> bookingData) async {
    _setLoading(true);
    try {
      await _bookingService.createBooking(bookingData);
      _setLoading(false);
      return true;
    } catch (e) {
      print(e);
      _setLoading(false);
      return false;
    }
  }
}