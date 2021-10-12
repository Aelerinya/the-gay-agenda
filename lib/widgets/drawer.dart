import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            // TODO: Add Image from camera
            backgroundImage: NetworkImage(
                'https://cdn.discordapp.com/avatars/132917155468541952/58daa0ef5c60904f6387e061e1575408.webp?size=80'),
          ),
          // TODO: Add Profile info
          accountName: Text(
            'Dit Scord',
            style: TextStyle(fontSize: 24.0),
          ),
          accountEmail: Text('example@example.com'),
        ),
        ListTile(
          leading: const Icon(Icons.house_outlined),
          title: const Text('Home'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
      ],
    ),
  );
}
