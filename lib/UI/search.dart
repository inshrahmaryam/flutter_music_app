import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> categories = ['Hip Hop', 'Soft', 'Pop', 'Soothing'];

  final List<Map<String, String>> trendingSongs = [
    {'title': 'Good Luck', 'image': 'assets/images/artist1.jpg'},
    {'title': 'Texas Hold', 'image': 'assets/images/artist2.jpg'},
    {'title': 'Espresso', 'image': 'assets/images/artist3.jpg'},
    {'title': 'With a smile', 'image': 'assets/images/artist4.jpg'},
    {'title': 'Apt', 'image': 'assets/images/artist5.jpg'},
    {'title': 'Not Like us', 'image': 'assets/images/artist6.jpg'},
    {'title': 'Khanabadosh', 'image': 'assets/images/artist7.jpg'},
    {'title': 'Departure Times', 'image': 'assets/images/artist8.jpg'},
  ];

  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    filteredSongs = trendingSongs;
  }

  void _filterSongs(String query) {
    setState(() {
      filteredSongs =
          trendingSongs
              .where(
                (song) =>
                    song['title']!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              const Text(
                "Search",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar
              TextField(
                controller: _controller,
                style: TextStyle(color: Colors.black),
                onChanged: _filterSongs,
                decoration: InputDecoration(
                  hintText: "What do you want to listen to?",
                  hintStyle: TextStyle(color: Colors.black54),
                  prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                  suffixIcon:
                      _controller.text.isNotEmpty
                          ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.deepPurple),
                            onPressed: () {
                              _controller.clear();
                              _filterSongs('');
                            },
                          )
                          : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Category Pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Chip(
                            label: Text(category),
                            backgroundColor: Colors.deepPurple.shade50,
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Colors.deepPurple.shade100,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Hot & Trending 🔥",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Grid of Songs
              GridView.builder(
                itemCount: filteredSongs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final song = filteredSongs[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Playing: ${song['title']}')),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(song['image']!, fit: BoxFit.cover),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black45],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Text(
                              song['title']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                shadows: [
                                  Shadow(blurRadius: 4, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
