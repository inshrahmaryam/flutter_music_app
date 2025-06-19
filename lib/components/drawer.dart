import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final sectionHeaderColor =
        isDarkMode
            ? Colors.white.withOpacity(0.7)
            : Colors.black.withOpacity(0.7);
    final itemColor = isDarkMode ? Colors.white : Colors.black;
    final dividerColor = isDarkMode ? Colors.white24 : Colors.black26;

    return Drawer(
      child: Container(
        color: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildProfileHeader(itemColor),

            _buildSectionHeader("MAIN", sectionHeaderColor),
            _buildDrawerItem(
              context,
              Icons.home,
              "Home",
              itemColor,
              route: '/home',
            ),
            _buildDrawerItem(
              context,
              Icons.dashboard,
              "Dashboard",
              itemColor,
              route: '/dashboard',
            ),
            _buildDrawerItem(
              context,
              Icons.notifications,
              "Notifications",
              itemColor,
              route: '/notifications',
            ),

            Divider(thickness: 0.2, color: dividerColor),

            _buildSectionHeader("MUSIC", sectionHeaderColor),

            _buildExpandableDrawerItem(
              context,
              Icons.playlist_play,
              "Playlists",
              itemColor,
              2,
              [
                _buildSubDrawerItem(
                  context,
                  "Workout Playlist",
                  itemColor,
                  route: '/playlists/workout',
                ),
                _buildSubDrawerItem(
                  context,
                  "Chill Vibes",
                  itemColor,
                  route: '/playlists/chill',
                ),
                _buildSubDrawerItem(
                  context,
                  "Top Hits",
                  itemColor,
                  route: '/playlists/top_hits',
                ),
              ],
            ),

            _buildDrawerItem(
              context,
              Icons.favorite,
              "Favorite Songs",
              itemColor,
              route: '/favorites',
            ),

            _buildDrawerItem(
              context,
              Icons.history,
              "Recently Played",
              itemColor,
              route: '/recently_played',
            ),

            _buildDrawerItem(
              context,
              Icons.settings,
              "Music Settings",
              itemColor,
              route: '/music_settings',
            ),

            Divider(thickness: 0.2, color: dividerColor),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Inshrah Maryam",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "\"Where words fail, music speaks.\"",
            style: TextStyle(fontSize: 14, color: color.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    Color color, {
    VoidCallback? onTap,
    String? route,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      onTap:
          onTap ??
          () {
            if (route != null) {
              Navigator.pop(context);
              Navigator.pushNamed(context, route);
            }
          },
    );
  }

  Widget _buildExpandableDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    int index,
    List<Widget> subItems,
  ) {
    final bool isExpanded = expandedIndex == index;

    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(title, style: TextStyle(color: color)),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: color.withOpacity(0.7),
          ),
          onTap: () {
            setState(() {
              expandedIndex = isExpanded ? -1 : index;
            });
          },
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Column(children: subItems),
          ),
      ],
    );
  }

  Widget _buildSubDrawerItem(
    BuildContext context,
    String title,
    Color color, {
    String? route,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: color.withOpacity(0.7), fontSize: 14),
      ),
      onTap: () {
        if (route != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
