import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NowPlaying extends StatefulWidget {
  final List<Map<String, String>> songs;
  final int currentIndex;

  const NowPlaying({Key? key, required this.songs, required this.currentIndex})
    : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  late int _currentIndex;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _audioPlayer = AudioPlayer();
    _playCurrentSong();
  }

  void _playCurrentSong() async {
    await _audioPlayer.stop(); // stop any previous song
    final audioPath = widget.songs[_currentIndex]['audio']!;
    await _audioPlayer.play(AssetSource(audioPath));
    setState(() {
      _isPlaying = true;
    });
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _nextSong() {
    setState(() {
      if (_currentIndex < widget.songs.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
    _playCurrentSong();
  }

  void _previousSong() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = widget.songs.length - 1;
      }
    });
    _playCurrentSong();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.songs[_currentIndex];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              song['image']!,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            Text(
              song['title']!,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              song['artist']!.isEmpty ? 'Unknown Artist' : song['artist']!,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: _previousSong,
                  color: Colors.deepPurple,
                ),
                IconButton(
                  iconSize: 80,
                  icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                  ),
                  onPressed: _togglePlayPause,
                  color: Colors.deepPurple,
                ),
                IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.skip_next),
                  onPressed: _nextSong,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
