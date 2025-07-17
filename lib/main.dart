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

  // Generate a unique user ID for each session
  final uniqueUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';

  // Create a guest user
  final guest = User.guest(userId: uniqueUserId, name: 'Guest User');
  final client = StreamVideo('mmhfdzb5evj2', user: guest);

  await client.connect();

  setupInjection(client);

  runApp(const VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  const VideoCallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guitara Video Call',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: BlocProvider.value(
        value: getIt.get<CallCubit>(),
        child: const HomeScreen(),
      ),
    );
  }
}
