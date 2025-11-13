import 'package:flutter/material.dart';
import 'package:locallinker/models/service_category_model.dart';
import 'package:locallinker/screens/category_helpers_screen.dart'; // <-- IMPORT the new screen
import 'package:locallinker/widgets/search_bar_widget.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Services", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SearchBarWidget(hintText: "Search for a service..."),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: serviceCategories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(context, serviceCategories[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, ServiceCategory category) {
    return InkWell(
      // --- THIS IS THE KEY CHANGE ---
      onTap: () {
        // Navigate to the new screen, passing the selected category.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryHelpersScreen(category: category),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 30),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              maxLines: 2, // Allow for two lines for longer names like "Driver / Cab"
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}