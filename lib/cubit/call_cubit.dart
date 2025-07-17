import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'call_state.dart';

// States

// Cubit
class CallCubit extends Cubit<VideoCallState> {
  CallCubit() : super(CallInitial());

  StreamVideo? _client;
  Call? _currentCall;
  String _callId = 'I1yWB9hRGbYM';

  Future<void> initializeCall(StreamVideo client) async {
    _client = client;
    _client!.connect();
    await joinCall();
  }

  Future<void> joinCall([String? callId]) async {
    if (callId != null) {
      _callId = callId;
    }

    emit(CallLoading());

    try {
      if (_client == null) {
        emit(CallError('Client not initialized'));
        return;
      }

      _currentCall = _client!.makeCall(
        callType: StreamCallType.defaultType(),
        id: _callId,
      );
      await _currentCall!.getOrCreate();
      await _currentCall!.join();
      emit(CallJoined(_currentCall!));
    } catch (e) {
      print('Failed to join call: $e');
      emit(CallError('Failed to join call: $e'));
    }
  }

  Future<void> leaveCall() async {
    try {
      if (_currentCall != null) {
        await _currentCall!.leave();
        emit(CallLeft(_currentCall!, _callId));
        emit(CallInitial());
      }
    } catch (e) {
      emit(CallError('Failed to leave call: $e'));
    }
  }

  Future<void> rejoinCall() async {
    await joinCall();
  }

  Call? get currentCall => _currentCall;
  String get callId => _callId;
  bool get isInCall => state is CallJoined;
  bool get hasLeftCall => state is CallLeft;
  bool get isLoading => state is CallLoading;
}
