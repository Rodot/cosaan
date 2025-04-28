import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/components/user_name_field.dart';
import 'package:app/repositories/user_profile_repository.dart';
import 'package:app/domain/models/user.dart';

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
  final _userProfileRepository = UserProfileRepository();
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      final result = await _userProfileRepository.signInAnonymously();
      setState(() {
        _userProfile = result;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing in: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _updateUserProfile(UserProfile userProfile) async {
    try {
      final updatedUserProfile = await _userProfileRepository.update(
        userProfile.id,
        userProfile,
      );
      if (updatedUserProfile != null) {
        setState(() {
          _userProfile = updatedUserProfile;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('The Village')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserNameField(
                  userProfile: _userProfile,
                  onUpdateRequested: _updateUserProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
