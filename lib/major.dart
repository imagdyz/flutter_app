import 'package:flutter/material.dart';
import 'home.dart';
import 'patent.dart';
import 'analysis.dart';
import 'symptoms.dart';

void main() {
  runApp(const Major());
}

class Major extends StatelessWidget {
  const Major({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    SymptomsPage(),
    PatientScreen(),
    AnalysisScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thyroid App"),
        backgroundColor: Colors.blue,
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade50,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "الاعراض",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "المريض",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: "التحاليل",
          ),
        ],
      ),
    );
  }
}