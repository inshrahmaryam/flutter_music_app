import 'package:flutter/material.dart';
import '../components/appBar.dart';
import '../components/drawer.dart';
import 'now_playing.dart';

class Favorites extends StatefulWidget {
  final List<Map<String, String>> favoriteSongs;

  const Favorites({Key? key, required this.favoriteSongs}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<Map<String, String>> favorites;

  @override
  void initState() {
    super.initState();
    favorites = widget.favoriteSongs;
  }

  void _navigateToNowPlaying(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NowPlaying(songs: favorites, currentIndex: index),
      ),
    );
  }

  void _removeFromFavorites(int index) {
    final removedSong = favorites[index];
    setState(() {
      favorites.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed "${removedSong['title']}" from favorites'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              favorites.insert(index, removedSong);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            favorites.isEmpty
                ? const Center(
                  child: Text(
                    'No favorites added yet!',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                )
                : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final song = favorites[index];
                    return GestureDetector(
                      onTap: () => _navigateToNowPlaying(index),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                song['image'] ?? '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song['title'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${song['year'] ?? '2023'} • ${song['artist'] ?? 'Unknown'}",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () => _removeFromFavorites(index),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.deepPurple),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 20,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
