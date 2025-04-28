import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _supabase = Supabase.instance.client;
  bool _loading = true;
  String? _userId;
  String? _error;

  @override
  void initState() {
    super.initState();
    _signInAnonymously();
  }

  Future<void> _signInAnonymously() async {
    try {
      setState(() {
        _loading = true;
      });
      
      // Check if there's an existing session
      final Session? session = _supabase.auth.currentSession;
      
      if (session != null) {
        // User is already signed in
        setState(() {
          _userId = session.user.id;
          _loading = false;
        });
        return;
      }
      
      // Sign in anonymously
      final response = await _supabase.auth.signInAnonymously();
      
      setState(() {
        _userId = response.user?.id;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : _error != null
                  ? Text('Error: $_error')
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Hello World!'),
                        const SizedBox(height: 16),
                        Text('User ID: $_userId'),
                      ],
                    ),
        ),
      ),
    );
  }
}
