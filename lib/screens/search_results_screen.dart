import 'package:flutter/material.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/widgets/helper_card.dart';

class SearchResultsScreen extends StatelessWidget {
  final String searchQuery;
  const SearchResultsScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    // In a real app, you would filter the list based on the searchQuery
    final List<ServiceProvider> searchResults = popularProviders;

    return Scaffold(
      appBar: AppBar(
        title: Text('Results for "$searchQuery"'),
      ),
      body: searchResults.isEmpty
          ? const Center(child: Text("No helpers found for your search."))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: HelperCard(provider: searchResults[index]),
          );
        },
      ),
    );
  }
}