import 'package:flutter/material.dart';

class SongListScreen extends StatelessWidget {
  final String playlistName;
  final List<String> songs;

  const SongListScreen({
    Key? key,
    required this.playlistName,
    required this.songs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.music_note, color: Colors.deepPurple),
            title: Text(songs[index]),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Playing: ${songs[index]} 🎶')),
              );
            },
          );
        },
      ),
    );
  }
}
