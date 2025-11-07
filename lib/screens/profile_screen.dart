import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildProfileHeader(context), // No longer needs a 'user' object
          const SizedBox(height: 10),
          _buildAccountOverview(context),
          const SizedBox(height: 10),
          _buildProfileMenu(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            image: DecorationImage(
              image: NetworkImage("https://i.imgur.com/G4fP2eJ.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage("https://i.imgur.com/L7Le2v1.png"),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // --- Reverted to static placeholder text ---
                  Text(
                    "Vaibhav",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "vaibhav@email.com",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountOverview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard(context, "5", "Bookings", Icons.book_online_outlined),
          const SizedBox(width: 8),
          _buildStatCard(context, "3", "Saved", Icons.favorite_border),
          const SizedBox(width: 8),
          _buildStatCard(context, "120", "Rewards", Icons.card_giftcard_outlined),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label, IconData icon) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.grey[400]),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildMenuItem(context, icon: Icons.person_outline, title: "Edit Profile", onTap: () {}),
          _buildMenuItem(context, icon: Icons.payment, title: "Payment Methods", onTap: () {}),
          _buildMenuItem(context, icon: Icons.notifications_none, title: "Notifications", onTap: () {}),
          const Divider(height: 30),
          _buildMenuItem(context, icon: Icons.help_outline, title: "Help & Support", onTap: () {}),
          _buildMenuItem(context, icon: Icons.gavel, title: "Terms & Conditions", onTap: () {}),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              // --- Reverted to a non-functional placeholder ---
              onPressed: () {
                // This button no longer does anything
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login/Logout functionality removed.")),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}