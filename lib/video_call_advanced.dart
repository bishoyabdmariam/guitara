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

  var cameraEnabled = true;
  var micEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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

  PreferredSizeWidget? _buildAppBar(Call call, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: Container(
        color: Colors.transparent,
        child: Row(children: []),
      ),
    );
  }

  Widget _buildVideoCall(CallJoined state) {
    return StreamCallContainer(
      call: state.call,
      callContentWidgetBuilder: (context, call) {
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: StreamCallContent(
                callAppBarWidgetBuilder: (context, call) {
                  return _buildAppBar(call, context);
                },
                extendBody: true,
                layoutMode: ParticipantLayoutMode.pictureInPicture,
                call: call,
                onLeaveCallTap: () {
                  context.read<CallCubit>().leaveCall();
                },

                callControlsWidgetBuilder: (context, call) {
                  return _buildCustomControls();
                },
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: Colors.transparent,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CallCubit>().leaveCall();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),

                    Spacer(),
                    IconButton(
                      onPressed: () {
                        call.flipCamera();
                      },
                      icon: Icon(
                        Icons.flip_camera_ios_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCustomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Flip camera button
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: IconButton(
              onPressed: () async {
                final call = context.read<CallCubit>().currentCall;
                if (call != null) {
                  cameraEnabled = !cameraEnabled;
                  await call.setCameraEnabled(enabled: cameraEnabled);
                }
              },
              style: IconButton.styleFrom(backgroundColor: Colors.white),
              icon: const Icon(
                Icons.photo_camera_front,
                color: Color(0xff67628e),
              ),
            ),
          ),
          // Leave call button
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FloatingActionButton(
              onPressed: () async {
                context.read<CallCubit>().leaveCall();
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.call_end, color: Colors.white),
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () async {
                micEnabled = !micEnabled;
                await context
                    .read<CallCubit>()
                    .currentCall
                    ?.setMicrophoneEnabled(enabled: micEnabled);
              },
              icon: const Icon(Icons.mic_off, color: Color(0xff67628e)),
            ),
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
