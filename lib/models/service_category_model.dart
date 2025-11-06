import 'package:flutter/material.dart';

class ServiceCategory {
  final String name;
  final IconData icon;

  ServiceCategory({required this.name, required this.icon});
}

// Dummy Data for demonstration
final List<ServiceCategory> serviceCategories = [
  ServiceCategory(name: "Plumber", icon: Icons.plumbing_rounded),
  ServiceCategory(name: "Electrician", icon: Icons.power_rounded),
  ServiceCategory(name: "Driver / Cab", icon: Icons.drive_eta_rounded),
  ServiceCategory(name: "Cleaner", icon: Icons.cleaning_services_rounded),
  ServiceCategory(name: "Painter", icon: Icons.format_paint_rounded),
  ServiceCategory(name: "Cook / Maid", icon: Icons.soup_kitchen_rounded),
  ServiceCategory(name: "Technician", icon: Icons.build_rounded),
  ServiceCategory(name: "Carpenter", icon: Icons.carpenter_rounded),
  ServiceCategory(name: "Delivery", icon: Icons.delivery_dining_rounded),
  ServiceCategory(name: "Tutor", icon: Icons.school_rounded),
  ServiceCategory(name: "Movers", icon: Icons.local_shipping_rounded),
  ServiceCategory(name: "Repair", icon: Icons.home_repair_service_rounded),
];