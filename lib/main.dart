import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/call_cubit.dart';
import 'injection_container.dart';
import 'screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  // Ensure Flutter is able to communicate with Plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Request camera and microphone permissions
  await Permission.camera.request();
  await Permission.microphone.request();

  // Initialize Stream video with test credentials
  final client = StreamVideo(
    'mmhfdzb5evj2', // Test API key from Stream documentation
    user: User.regular(userId: 'Wedge_Antilles', name: 'Wedge Antilles'),
    userToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL1dlZGdlX0FudGlsbGVzIiwidXNlcl9pZCI6IldlZGdlX0FudGlsbGVzIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3NTI2Nzg5MzQsImV4cCI6MTc1MzI4MzczNH0.bUzG6AMQte_vKLJfwz8fTp3oS1g_uc7V4s1SiXSnhec',
  );

  setupInjection(client);

  runApp(const VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  const VideoCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitara Video Call',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: BlocProvider.value(
        value: getIt.get<CallCubit>(),
        child: const HomeScreen(),
      ),
    );
  }
}
