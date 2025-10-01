import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode mode = ThemeMode.light;
  void toggleMode() => setState(
    () => mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
  );

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
      themeMode: mode,
      home: HomeScreen(onToggleTheme: toggleMode),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = PageController();
  Color textColor = Colors.black;

  Future<void> pickColor() async {
    final palette = [
      Colors.black,
      Colors.white,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    Color? chosen = await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick Text Color'),
          content: SizedBox(
            width: 280,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: palette.map((c) {
                return InkWell(
                  onTap: () => Navigator.of(context).pop(c),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
    if (chosen != null) setState(() => textColor = chosen);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fading Text Animation'),
        actions: [
          IconButton(
            onPressed: pickColor,
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Text Color',
          ),
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            ),
            tooltip: isDark ? 'Day Mode' : 'Night Mode',
          ),
        ],
      ),
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
