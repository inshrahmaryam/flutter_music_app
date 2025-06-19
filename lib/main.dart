import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UI/favorites.dart';
import 'UI/home.dart';
import 'UI/login_page.dart';
import 'UI/playlist.dart';
import 'UI/search.dart';
import 'UI/settings.dart';
import 'UI/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDPM6dLNRsRD2AylBPCZm4-aoYJAlwMOn4",
        authDomain: "mymusicapp101-e37ad.firebaseapp.com",
        projectId: "mymusicapp101-e37ad",
        storageBucket: "mymusicapp101-e37ad.appspot.com",
        messagingSenderId: "374123045973",
        appId: "1:374123045973:web:154c18ca5e49a4991c20dc",
        measurementId: "G-PRW25S131C",
      ),
    );
  } else {
    await Firebase.initializeApp(); // for Android/iOS later
  }

  // Check if a user is already logged in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyMusicApp(initialRoute: user == null ? '/login' : '/main'));
}

class MyMusicApp extends StatelessWidget {
  final String initialRoute;
  const MyMusicApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> favoriteSongs = [
    {
      'title': 'La Haasil',
      'artist': 'Sunny Khan Durrani',
      'audio': 'assets/music/La_Haasil.mp3',
      'image': 'assets/images/la_haasil.jpg',
    },
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const Home(),
      Favorites(favoriteSongs: favoriteSongs),
      const Playlist(),
      const Search(),
      const Settings(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
