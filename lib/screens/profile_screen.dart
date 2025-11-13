import 'package:flutter/material.dart';
import 'package:locallinker/models/user_model.dart';
import 'package:locallinker/providers/auth_provider.dart';
import 'package:locallinker/providers/theme_provider.dart';
import 'package:locallinker/providers/user_provider.dart';
import 'package:locallinker/screens/profile_options/edit_profile_screen.dart';
import 'package:locallinker/screens/profile_options/notifications_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          // Use a switch statement to handle all possible states from the provider
          switch (userProvider.status) {
            case UserStatus.Loading:
            case UserStatus.Uninitialized:
            // Show a loading spinner while data is being fetched
              return const Center(child: CircularProgressIndicator());

            case UserStatus.Error:
            // Show a helpful error message if fetching failed
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Could not load profile.\nError: ${userProvider.errorMessage}",
                    textAlign: TextAlign.center,
                  ),
                ),
              );

            case UserStatus.Loaded:
            // If data is loaded successfully, build the full profile screen
              final UserModel user = userProvider.user!;

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildProfileHeader(context, user.name, user.email),
                  const SizedBox(height: 10),
                  _buildAccountOverview(context),
                  const SizedBox(height: 10),
                  _buildProfileMenu(context),
                ],
              );
          }
        },
      ),
    );
  }

  /// Builds the header section with the user's avatar, name, and email.
  Widget _buildProfileHeader(BuildContext context, String name, String email) {
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
              image: NetworkImage("https://images.unsplash.com/photo-1528459801416-a9e53bbf4e17?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80"),
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
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80"),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the overview section with stats like bookings, saved items, and rewards.
  Widget _buildAccountOverview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
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

  /// Helper widget for a single stat card in the overview section.
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

  /// Builds the main menu with theme toggle, navigation options, and logout button.
  Widget _buildProfileMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                secondary: const Icon(Icons.brightness_6_outlined),
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: "Edit Profile",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
          ),
          _buildMenuItem(
            context,
            icon: Icons.notifications_none,
            title: "Notifications",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          _buildMenuItem(
            context,
            icon: Icons.payment,
            title: "Payment Methods",
            onTap: () { /* TODO: Navigate to PaymentMethodsScreen */ },
          ),
          const Divider(height: 30),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () { /* TODO: Navigate to HelpSupportScreen */ },
          ),
          _buildMenuItem(
            context,
            icon: Icons.gavel,
            title: "Terms & Conditions",
            onTap: () { /* TODO: Navigate to TermsScreen */ },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Helper widget for a single menu item to keep the code clean.
  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7)),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}