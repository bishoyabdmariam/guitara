# Guitara - Group Video Call App

A Flutter application for group video calls using the Stream Video SDK.

## Features

- **Group Video Calls**: Multiple participants can join the same video call room
- **Real-time Communication**: High-quality audio and video streaming
- **Cross-platform**: Works on iOS, Android, Web, Windows, macOS, and Linux
- **Simple Interface**: Clean and intuitive user interface
- **Automatic Room Joining**: All users automatically join the same test room
- **State Management**: Built-in state management with rejoin functionality
- **Call Controls**: Leave call with option to rejoin or close the app
- **Random User Generation**: Each session gets a unique random user ID and name

## Setup Instructions

### 1. Prerequisites

- Flutter SDK (version 3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)
- Android Emulator (for Android development)

### 2. Dependencies

The app uses the following Stream Video SDK packages:

```yaml
dependencies:
  stream_video_flutter: ^0.10.0
  stream_video: ^0.10.0
  stream_video_push_notification: ^0.10.0
  stream_video_screen_sharing: ^0.10.0
  flutter_bloc: ^8.1.4
```

### 3. Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd guitara
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Configuration

### Stream Video Setup

The app is currently configured with test credentials from Stream Video:

- **API Key**: `mmhfdzb5evj2`
- **User ID**: `Wedge_Antilles`
- **Token**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL1dlZGdlX0FudGlsbGVzIiwidXNlcl9pZCI6IldlZGdlX0FudGlsbGVzIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3NTI2Nzg5MzQsImV4cCI6MTc1MzI4MzczNH0.bUzG6AMQte_vKLJfwz8fTp3oS1g_uc7V4s1SiXSnhec`
- **Call Room ID**: `test-room`

### For Production Use

To use your own Stream Video account:

1. Sign up at [getstream.io](https://getstream.io)
2. Create a new app in the Stream dashboard
3. Get your API key and user token
4. Update the credentials in `lib/main.dart`:

```dart
final client = StreamVideo(
  'YOUR_API_KEY',
  user: User.regular(
    userId: 'YOUR_USER_ID',
    name: 'Your Name',
  ),
  userToken: 'YOUR_USER_TOKEN',
);
```

## Usage

### Basic Video Call

1. Launch the app
2. A unique random user ID and name are generated for your session
3. The app automatically joins the "test-room" call
4. Grant camera and microphone permissions when prompted
5. You'll see your video feed and any other participants
6. Use the red "End Call" button to leave the call
7. After leaving, you can choose to "Rejoin Call" or "Close" the app

### Multiple Participants

- All users running the app will automatically join the same "test-room"
- Each participant will see all other participants' video feeds
- The interface automatically adjusts to show multiple video streams

## Project Structure

```
lib/
├── main.dart                 # Main app entry point with basic video call
├── video_call_advanced.dart  # Advanced video call implementation
├── cubit/
│   └── call_cubit.dart       # State management for call operations
├── utils/
│   └── user_generator.dart   # Random user generation utilities
└── ...
```

## Permissions

The app requires the following permissions:

### Android
- Camera access
- Microphone access
- Internet access

### iOS
- Camera access
- Microphone access

These permissions are automatically requested when the app starts.

## Troubleshooting

### Common Issues

1. **Camera/Microphone not working**
   - Check device permissions
   - Ensure no other apps are using the camera/microphone
   - Restart the app

2. **Cannot join call**
   - Check internet connection
   - Verify Stream Video credentials
   - Ensure the call room ID is correct

3. **Video quality issues**
   - Check internet bandwidth
   - Close other bandwidth-intensive applications
   - Try on a different network

### Debug Mode

To run the app in debug mode with verbose logging:

```bash
flutter run --debug
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues related to:
- **Stream Video SDK**: Visit [Stream Video Documentation](https://getstream.io/video/docs/)
- **Flutter**: Visit [Flutter Documentation](https://flutter.dev/docs)
- **App-specific issues**: Open an issue in this repository

## Acknowledgments

- [Stream Video](https://getstream.io/video/) for providing the video calling SDK
- [Flutter](https://flutter.dev) for the cross-platform framework
