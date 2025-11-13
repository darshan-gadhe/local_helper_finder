import 'package:flutter/material.dart';
import 'package:locallinker/models/service_category_model.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/widgets/helper_card.dart';

class CategoryHelpersScreen extends StatelessWidget {
  final ServiceCategory category;

  const CategoryHelpersScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Filter the master list of providers to find ones matching the selected category.
    // The `.toLowerCase()` makes the matching case-insensitive and more robust.
    final List<ServiceProvider> filteredHelpers = popularProviders
        .where((helper) =>
    helper.service.toLowerCase() == category.name.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        // Use the category name for the title, e.g., "Plumbers"
        title: Text('${category.name}s'),
      ),
      body: filteredHelpers.isEmpty
          ? Center(
        child: Text(
          "No helpers found for this category yet.",
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredHelpers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            // We reuse the HelperCard widget for a consistent look.
            child: HelperCard(provider: filteredHelpers[index]),
          );
        },
      ),
    );
  }
}