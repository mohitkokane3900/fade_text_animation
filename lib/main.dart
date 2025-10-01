import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fading Text Animation',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = PageController();
  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fading Text Animation')),
      body: PageView(
        controller: controller,
        children: [
          FadingView(textColor: textColor, durationMs: 800),
          FadingView(textColor: textColor, durationMs: 2000),
        ],
      ),
    );
  }
}

class FadingView extends StatefulWidget {
  final Color textColor;
  final int durationMs;
  const FadingView({
    super.key,
    required this.textColor,
    required this.durationMs,
  });
  @override
  State<FadingView> createState() => _FadingViewState();
}

class _FadingViewState extends State<FadingView> {
  bool visible = true;
  bool showFrame = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => setState(() => visible = !visible),
            child: AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: widget.durationMs),
              curve: Curves.easeInOut,
              child: Text(
                'Hello, Flutter!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, color: widget.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
