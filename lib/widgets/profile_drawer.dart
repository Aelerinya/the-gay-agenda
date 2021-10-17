import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_gay_agenda/screens/home_screen.dart';
import 'package:the_gay_agenda/screens/settings.dart';
import 'package:the_gay_agenda/services/user.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileDrawer extends StatelessWidget {
  final User user;
  const ProfileDrawer({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                foregroundImage: user.imagePath.isNotEmpty
                    ? Image.file(File(user.imagePath)).image
                    : Image.memory(kTransparentImage).image,
                backgroundImage: const NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/20/20079.png')),
            accountName: Text(
              user.getName(),
              style: const TextStyle(fontSize: 24),
            ),
            accountEmail: Text(user.email),
          ),
          ListTile(
            leading: const Icon(Icons.house_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],
      ),
    );
  }
}
