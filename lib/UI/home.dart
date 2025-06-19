import 'package:flutter/material.dart';
import '../components/appBar.dart';
import '../components/drawer.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;
  bool isPlaying = false;

  List<Map<String, String>> favorites = [];

  final List<Map<String, String>> topArtists = const [
    {'name': 'Atif Aslam', 'image': 'assets/images/artist1.jpg'},
    {'name': 'Momina Mustehsan', 'image': 'assets/images/artist8.jpg'},
    {'name': 'Rahat Fateh Ali', 'image': 'assets/images/artist5.jpg'},
    {'name': 'Ali Zafar', 'image': 'assets/images/artist2.jpg'},
    {'name': 'Ali Zafar', 'image': 'assets/images/artist3.jpg'},
    {'name': 'Ali Zafar', 'image': 'assets/images/artist4.jpg'},
    {'name': 'Ali Zafar', 'image': 'assets/images/artist6.jpg'},
    {'name': 'Ali Zafar', 'image': 'assets/images/artist7.jpg'},
  ];

  final List<Map<String, String>> songs = const [
    {
      'title': 'La Haasil',
      'artist': 'Sunny Khan Durrani',
      'audio': 'assets/music/La_Haasil.mp3',
      'image': 'assets/images/la_haasil.jpg',
    },
    {
      'title': 'Afreen Afreen',
      'artist': 'Rahat Fateh Ali x Momina Mustehsan',
      'audio': 'assets/music/Afreen_Afreen.mp3',
      'image': 'assets/images/afreen_afreen.jpg',
    },
    {
      'title': 'Bachana',
      'artist': 'Bilal Khan',
      'audio': 'assets/music/Bachana.mp3',
      'image': 'assets/images/bachana.jpg',
    },
    {
      'title': 'Hona Tha Pyar',
      'artist': 'Atif Aslam',
      'audio': 'assets/music/Hona_Tha_Pyar.mp3',
      'image': 'assets/images/hona_tha_pyaar.jpg',
    },
  ];

  void _playPauseSong(String assetPath, int index) async {
    if (_currentlyPlayingIndex == index && isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(
        AssetSource(assetPath.replaceFirst('assets/', '')),
      );
      setState(() {
        _currentlyPlayingIndex = index;
        isPlaying = true;
      });
      _showSongInfo(songs[index]['title']!, songs[index]['artist']!);
    }
  }

  void _showSongInfo(String title, String artist) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text('Artist: $artist'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _toggleFavorite(Map<String, String> song) {
    setState(() {
      if (favorites.any((fav) => fav['title'] == song['title'])) {
        favorites.removeWhere((fav) => fav['title'] == song['title']);
      } else {
        favorites.add(song);
      }
    });
  }

  bool _isFavorite(Map<String, String> song) {
    return favorites.any((fav) => fav['title'] == song['title']);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black54),
                  hintText: 'Search Music',
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Featured Artist
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/concert2.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.headphones, color: Colors.black, size: 16),
                        SizedBox(width: 6),
                        Text('12,942', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Top Artists
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Top Artists',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('See All', style: TextStyle(color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topArtists.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(topArtists[index]['image']!),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Top Musics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Top Musics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('See All', style: TextStyle(color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children:
                  songs.asMap().entries.map((entry) {
                    int index = entry.key;
                    var song = entry.value;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          song['image']!,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        song['title']!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        song['artist']!,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              _isFavorite(song)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  _isFavorite(song)
                                      ? Colors.deepPurple
                                      : Colors.black54,
                            ),
                            onPressed: () => _toggleFavorite(song),
                          ),
                          Icon(
                            _currentlyPlayingIndex == index && isPlaying
                                ? Icons.pause_circle
                                : Icons.play_arrow_rounded,
                            color: Colors.black54,
                            size: 28,
                          ),
                        ],
                      ),
                      onTap: () {
                        _playPauseSong(song['audio']!, index);
                      },
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
