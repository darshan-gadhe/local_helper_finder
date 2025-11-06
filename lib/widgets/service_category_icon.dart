import 'package:flutter/material.dart';
import 'package:locallinker/models/service_category_model.dart';

class ServiceCategoryIcon extends StatelessWidget {
  final ServiceCategory category;
  const ServiceCategoryIcon({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.circle,
          ),
          child: Icon(category.icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(category.name),
      ],
    );
  }
}