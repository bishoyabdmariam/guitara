import 'package:stream_video_flutter/stream_video_flutter.dart';

abstract class VideoCallState {}

class CallInitial extends VideoCallState {}

class CallLoading extends VideoCallState {}

class CallJoined extends VideoCallState {
  final Call call;
  CallJoined(this.call);
}

class CallLeft extends VideoCallState {
  final Call call;
  final String callId;
  CallLeft(this.call, this.callId);
}

class CallError extends VideoCallState {
  final String message;
  CallError(this.message);
}
