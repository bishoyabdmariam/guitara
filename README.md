# Guitara - Group Video Call App

A Flutter application for group video calls using the Stream Video SDK with a beautiful, modern interface.

## Features

- **Group Video Calls**: Multiple participants can join the same video call room
- **Real-time Communication**: High-quality audio and video streaming
- **Cross-platform**: Works on iOS, Android, Web, Windows, macOS, and Linux
- **Beautiful UI**: Modern gradient design with smooth animations
- **Guest Authentication**: Automatic guest user generation for easy testing
- **State Management**: Built-in state management with BLoC pattern
- **Call Controls**: Flip camera, end call, and navigation controls
- **Error Handling**: Comprehensive error states with retry functionality
- **Responsive Design**: Works seamlessly across different screen sizes

## Setup Instructions

### 1. Prerequisites

- Flutter SDK (version 3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)
- Android Emulator (for Android development)

### 2. Dependencies

The app uses the following packages:

```yaml
dependencies:
  # Stream Video SDK
  stream_video_flutter: ^0.10.0
  stream_video: ^0.10.0
  stream_video_screen_sharing: ^0.10.0
  
  # State Management
  flutter_bloc: ^9.1.1
  get_it: ^8.0.3
  
  # Permissions
  permission_handler: ^11.3.1
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

The app is currently configured with Stream Video test credentials and uses guest authentication:

- **API Key**: `mmhfdzb5evj2`
- **Authentication**: Guest authentication (no token required)
- **Call Room ID**: `I1yWB9hRGbYM`
- **User Generation**: Each session gets a unique guest user ID

### Guest Authentication

The app uses Stream's guest authentication feature, which automatically generates unique user IDs for each session. This makes testing easy without requiring backend token generation.

### For Production Use

To use your own Stream Video account:

1. Sign up at [getstream.io](https://getstream.io)
2. Create a new app in the Stream dashboard
3. Get your API key
4. Update the credentials in `lib/main.dart`:

```dart
// For regular user authentication
final client = StreamVideo(
  'YOUR_API_KEY',
  user: User.regular(
    userId: 'YOUR_USER_ID',
    name: 'Your Name',
  ),
  userToken: 'YOUR_USER_TOKEN',
);

// Or keep using guest authentication
final guest = User.guest(userId: 'unique_user_id', name: 'Guest User');
final client = StreamVideo('YOUR_API_KEY', user: guest);
await client.connect();
```

## Usage

### Getting Started

1. **Launch the app** - You'll see a beautiful home screen with app information
2. **Join the call** - Tap the "Join Video Call" button
3. **Grant permissions** - Allow camera and microphone access when prompted
4. **Start calling** - You'll be connected to the test room automatically

### Video Call Interface

- **Your video feed** - See yourself in the main view
- **Other participants** - View all other users in the call
- **Call controls** - Use the bottom control bar for:
  - **Flip Camera** - Switch between front and back cameras
  - **End Call** - Leave the call and return to home screen
- **Navigation** - Use the back button to leave the call

### Multiple Participants

- All users running the app will automatically join the same test room (`I1yWB9hRGbYM`)
- Each participant gets a unique guest user ID
- The interface automatically adjusts to show multiple video streams
- Real-time audio and video communication between all participants

## Project Structure

```
lib/
├── main.dart                    # App entry point with Stream Video initialization
├── video_call_advanced.dart     # Video call screen with StreamCallContainer
├── screens/
│   └── home_screen.dart         # Beautiful home screen with call information
├── cubit/
│   ├── call_cubit.dart          # BLoC cubit for call state management
│   └── call_state.dart          # Call state definitions
├── injection_container.dart     # Dependency injection setup with GetIt
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
   - Check device permissions in settings
   - Ensure no other apps are using the camera/microphone
   - Restart the app and grant permissions again

2. **Cannot join call**
   - Check internet connection
   - Verify Stream Video API key is correct
   - Ensure the call room ID is valid

3. **Video quality issues**
   - Check internet bandwidth
   - Close other bandwidth-intensive applications
   - Try on a different network connection

4. **App crashes on startup**
   - Run `flutter clean` and `flutter pub get`
   - Check if all dependencies are properly installed
   - Verify platform-specific configurations

### Debug Mode

To run the app in debug mode with verbose logging:

```bash
flutter run --debug
```

### Platform-Specific Issues

**iOS:**
- Ensure camera and microphone permissions are added to Info.plist
- Test on a physical device for best results

**Android:**
- Verify permissions are declared in AndroidManifest.xml
- Check that the app has proper internet permissions

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests if applicable
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Setup

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`
4. Test on multiple devices to verify group calling functionality

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues related to:
- **Stream Video SDK**: Visit [Stream Video Documentation](https://getstream.io/video/docs/)
- **Flutter**: Visit [Flutter Documentation](https://flutter.dev/docs)
- **App-specific issues**: Open an issue in this repository

## Features in Detail

### 🎥 Video Call Features
- **Multi-participant support**: Up to 10+ participants in a single call
- **Camera controls**: Flip between front and back cameras
- **Real-time audio/video**: High-quality streaming with adaptive bitrate
- **Automatic reconnection**: Handles network interruptions gracefully

### 🎨 UI/UX Features
- **Modern design**: Beautiful gradient backgrounds and smooth animations
- **Responsive layout**: Adapts to different screen sizes and orientations
- **Intuitive controls**: Easy-to-use call controls and navigation
- **Error handling**: User-friendly error messages and retry options

### 🔧 Technical Features
- **State management**: Clean architecture with BLoC pattern
- **Dependency injection**: Scalable code structure with GetIt
- **Guest authentication**: Easy testing without backend setup
- **Cross-platform**: Works on iOS, Android, Web, and Desktop

## Acknowledgments

- [Stream Video](https://getstream.io/video/) for providing the video calling SDK
- [Flutter](https://flutter.dev) for the cross-platform framework
- [flutter_bloc](https://bloclibrary.dev/) for state management
