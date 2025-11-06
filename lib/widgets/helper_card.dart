import 'package:flutter/material.dart';
import 'package:locallinker/models/service_provider_model.dart';

class HelperCard extends StatelessWidget {
  final ServiceProvider provider;
  const HelperCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(provider.imageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        provider.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (provider.isVerified)
                        const Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Icon(Icons.verified, color: Colors.blue, size: 18),
                        ),
                    ],
                  ),
                  Text(
                    provider.service,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${provider.rating} (${provider.jobsDone}+ reviews)",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle favorite/bookmark action
              },
              icon: const Icon(Icons.favorite_border, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}