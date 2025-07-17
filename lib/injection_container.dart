import 'package:get_it/get_it.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'cubit/call_cubit.dart';

final getIt = GetIt.instance;

void setupInjection(StreamVideo client) {
  getIt.registerLazySingleton<StreamVideo>(() => client);
  getIt.registerLazySingleton<CallCubit>(() => CallCubit());
}
