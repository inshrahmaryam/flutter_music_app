import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ThemeType { light, dark, pink, green }

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeType themeType = ThemeType.light;
  bool notificationsEnabled = true;

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Color get backgroundColor {
    switch (themeType) {
      case ThemeType.dark:
        return Colors.black;
      case ThemeType.pink:
        return const Color(0xFFFFE4E1);
      case ThemeType.green:
        return const Color(0xFFE8F5E9); // Light green
      case ThemeType.light:
      default:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (themeType) {
      case ThemeType.dark:
        return Colors.white;
      case ThemeType.pink:
        return Colors.pink.shade800;
      case ThemeType.green:
        return Colors.green.shade800;
      case ThemeType.light:
      default:
        return Colors.black;
    }
  }

  Color get appBarColor {
    switch (themeType) {
      case ThemeType.dark:
        return Colors.grey[900]!;
      case ThemeType.pink:
        return Colors.pinkAccent;
      case ThemeType.green:
        return Colors.green;
      case ThemeType.light:
      default:
        return Colors.deepPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: appBarColor,
        foregroundColor: textColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Select Theme', style: TextStyle(color: textColor)),
          ),
          RadioListTile<ThemeType>(
            title: Text('Light Mode 🐧', style: TextStyle(color: textColor)),
            value: ThemeType.light,
            groupValue: themeType,
            onChanged: (value) => setState(() => themeType = value!),
            activeColor: Colors.deepPurple,
          ),
          RadioListTile<ThemeType>(
            title: Text('Dark Mode 👽', style: TextStyle(color: textColor)),
            value: ThemeType.dark,
            groupValue: themeType,
            onChanged: (value) => setState(() => themeType = value!),
            activeColor: Colors.deepPurple,
          ),
          RadioListTile<ThemeType>(
            title: Text('Pink Mode 🎀', style: TextStyle(color: textColor)),
            value: ThemeType.pink,
            groupValue: themeType,
            onChanged: (value) => setState(() => themeType = value!),
            activeColor: Colors.pinkAccent,
          ),
          RadioListTile<ThemeType>(
            title: Text('Green Mode 🌿', style: TextStyle(color: textColor)),
            value: ThemeType.green,
            groupValue: themeType,
            onChanged: (value) => setState(() => themeType = value!),
            activeColor: Colors.green,
          ),
          const Divider(),
          SwitchListTile(
            title: Text(
              'Enable Notifications',
              style: TextStyle(color: textColor),
            ),
            value: notificationsEnabled,
            onChanged: (value) => setState(() => notificationsEnabled = value),
            secondary: Icon(Icons.notifications, color: textColor),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.info, color: textColor),
            title: Text('About', style: TextStyle(color: textColor)),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'My Music App 🎵',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.music_note,
                  size: 50,
                  color: Colors.deepPurple,
                ),
                children: const [
                  Text('A minimal and cute Flutter music player app. 🎶'),
                ],
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () => Navigator.pop(context, true),
                        ),
                      ],
                    ),
              );
              if (shouldLogout ?? false) await _logout();
            },
          ),
        ],
      ),
    );
  }
}
