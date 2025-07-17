import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/call_cubit.dart';
import 'cubit/call_state.dart';
import 'injection_container.dart';

class AdvancedVideoCallScreen extends StatefulWidget {
  const AdvancedVideoCallScreen({super.key});

  @override
  State<AdvancedVideoCallScreen> createState() =>
      _AdvancedVideoCallScreenState();
}

class _AdvancedVideoCallScreenState extends State<AdvancedVideoCallScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<CallCubit>();
      if (cubit.currentCall == null) {
        cubit.initializeCall(getIt.get<StreamVideo>());
        cubit.joinCall();
      } else {
        cubit.joinCall();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guitara Video Call'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<CallCubit>().leaveCall();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<CallCubit, VideoCallState>(
        builder: (context, state) {
          return BlocListener<CallCubit, VideoCallState>(
            listener: (context, state) {
              if (state is CallLeft || state is CallError) {}
            },
            child: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(VideoCallState state) {
    if (state is CallInitial || state is CallLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Joining call...'),
          ],
        ),
      );
    } else if (state is CallJoined) {
      return _buildVideoCall(state);
    } else if (state is CallError) {
      return _buildErrorScreen(state);
    } else {
      return const Center(child: Text('Unknown state'));
    }
  }

  Widget _buildVideoCall(CallJoined state) {
    return StreamCallContainer(
      call: state.call,
      callContentWidgetBuilder: (context, call) {
        return StreamCallContent(
          call: call,
          onLeaveCallTap: () {
            context.read<CallCubit>().leaveCall();
          },
          callControlsWidgetBuilder: (context, call) {
            return _buildCustomControls();
          },
        );
      },
    );
  }

  Widget _buildCustomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Flip camera button
          FloatingActionButton(
            onPressed: () async {
              final call = context.read<CallCubit>().currentCall;
              if (call != null) {
                await call.flipCamera();
              }
            },
            backgroundColor: Colors.grey[700],
            child: const Icon(Icons.flip_camera_ios, color: Colors.white),
          ),
          // Leave call button
          FloatingActionButton(
            onPressed: () async {
              context.read<CallCubit>().leaveCall();
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.call_end, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen(CallError state) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 80, color: Colors.red),
            const SizedBox(height: 24),
            const Text(
              'Error',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    context.read<CallCubit>().rejoinCall();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CallCubit>().leaveCall();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
