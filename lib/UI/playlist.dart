import 'package:flutter/material.dart';
import '../components/appBar.dart';
import '../components/drawer.dart';
import 'song_list_screen.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final Map<String, List<String>> playlists = {
    'چِل وائبز': ['Barish Ki Boondein', 'Sukun', 'Ghalib Poetry'],
    'ورک آؤٹ': ['Power Beats', 'Energy Boost', 'Run Mode'],
    'روڈ ٹرپ': ['Safar', 'Dhol Mix', 'Long Drive Vibes'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: AppDrawer(),
      body: ListView(
        children: playlists.keys.map((playlistName) {
          return ListTile(
            leading: const Icon(Icons.playlist_play, color: Colors.deepPurple),
            title: Text(playlistName, style: const TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongListScreen(
                    playlistName: playlistName,
                    songs: playlists[playlistName]!,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('نئی پلے لسٹ کا فیچر جلد آرہا ہے!')),
          );
        },
      ),
    );
  }
}
