import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/call_cubit.dart';
import 'injection_container.dart';
import 'video_call_advanced.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stream video with API key and random user
  final client = StreamVideo(
    'mmhfdzb5evj2', // Test API key from Stream documentation
    user: User.regular(userId: 'user_1', name: 'John Doe'),
    userToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL1dlZGdlX0FudGlsbGVzIiwidXNlcl9pZCI6IldlZGdlX0FudGlsbGVzIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3NTI2Nzg5MzQsImV4cCI6MTc1MzI4MzczNH0.bUzG6AMQte_vKLJfwz8fTp3oS1g_uc7V4s1SiXSnhec', // Test token
  );

  setupInjection(client);

  runApp(VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  const VideoCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitara Video Call',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserInfo user;
  late StreamVideo client;

  @override
  void initState() {
    super.initState();
    client = getIt.get<StreamVideo>();
    user = client.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guitara Video Call'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.video_call, size: 100, color: Colors.blue),
            const SizedBox(height: 32),
            const Text(
              'Welcome to Guitara',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Hello, ${user.name}!',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose your video call experience',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: getIt.get<CallCubit>(),
                      child: AdvancedVideoCallScreen(),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.video_call),
              label: const Text('Advanced Video Call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
