import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utils/app_theme.dart';
import 'package:weather_app/view/weather_screen.dart';
import 'package:weather_app/view/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get darkTheme => null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => WeatherProvider(
            weatherService: WeatherService(
              apiKey: '0688bc07ec45a6f87fee3740d8ed6f34',
            ),
          ),
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const MainScreen(),
      ),
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

  final List<Widget> _screens = [const WeatherScreen(), const SearchScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 100,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
