import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';

Future<bool> startAudioService() async {
  print('audio servi');
  return await AudioService.start(
    backgroundTaskEntrypoint: backgroundTaskEntrypoint,
    androidNotificationChannelName: 'Notifications',
    // Enable this if you want the Android service to exit the foreground state on pause.
    // androidStopForegroundOnPause: true,
    // androidResumeOnClick: true,
    androidNotificationColor: 0xFF2196f3,
    androidNotificationIcon: 'mipmap/ic_launcher',
    androidEnableQueue: true,
    androidShowNotificationBadge: true
  );
}
backgroundTaskEntrypoint() {
  print('entry');
  AudioServiceBackground.run(() => AudioPlayerService());
}


class AudioPlayerService extends BackgroundAudioTask {
  AudioCache _audioCache = AudioCache();
  AudioPlayer _audioPlayer = AudioPlayer(playerId: 'player');

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    print('ON START');
    _audioPlayer = AudioPlayer(playerId: 'player');
  }

  @override
  Future<void> onPlay() async {
    print('ON PLAY');
    // if (_mediaItem != null) {
      AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop, MediaControl.skipToNext, MediaControl.skipToPrevious],
        playing: true,
        processingState: AudioProcessingState.ready
      );
      _audioPlayer.resume();
    // }
  }

  @override
  Future<void> onStop() async {
    print('ON STOP');
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop, MediaControl.skipToNext, MediaControl.skipToPrevious],
      playing: false,
      processingState: AudioProcessingState.stopped
    );
    _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onPause() async {
    print('ON PAUSE');
    // paused = true;
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop, MediaControl.skipToNext, MediaControl.skipToPrevious],
      playing: false,
      processingState: AudioProcessingState.stopped
    );
    _audioPlayer.pause();
  }

  @override
  Future<void> onPlayFromMediaId(String mediaId) async {
    _audioPlayer = await _audioCache.play('sounds/'+AudioServiceBackground.mediaItem!.id);
  }

  @override
  Future<void> onPlayMediaItem(MediaItem mediaItem) async {
    print('ON PLAY MEDIA ITEM');
    _audioPlayer.stop();
    AudioServiceBackground.setMediaItem(mediaItem);
    AudioServiceBackground.setState(
      controls: [MediaControl.pause, MediaControl.stop, MediaControl.skipToNext, MediaControl.skipToPrevious],
      playing: true,
      processingState: AudioProcessingState.ready
    );
    _audioPlayer = await _audioCache.play('sounds/'+AudioServiceBackground.mediaItem!.id);
    _audioPlayer.onPlayerCompletion.listen((event) {
      onSkipToNext();
    });
  }

  @override
  Future<void> onTaskRemoved() async {
    onStop();
  }

  @override
  Future<void> onSkipToPrevious() async {
    print('ON PREVIOUS');
    int index = AudioServiceBackground.queue!.indexOf(AudioServiceBackground.mediaItem!);
    late MediaItem mediaItemTemp;
    if (index != -1) {
      if (index == 0) {
        mediaItemTemp = AudioServiceBackground.queue![index];
      } else {
        mediaItemTemp = AudioServiceBackground.queue![index - 1];
      }
      AudioServiceBackground.setMediaItem(mediaItemTemp);
      AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop, MediaControl.skipToNext, MediaControl.skipToPrevious],
        playing: true,
        processingState: AudioProcessingState.ready
      );
      _audioPlayer.stop();
      _audioPlayer = await _audioCache.play('sounds/'+mediaItemTemp.id);
      _audioPlayer.onPlayerCompletion.listen((event) {
        onSkipToNext();
      });
    }
  }

  @override
  Future<void> onSkipToNext() async {
    print('ON NEXT');
    int index = AudioServiceBackground.queue!.indexOf(AudioServiceBackground.mediaItem!);
    late MediaItem mediaItemTemp;
    if (index != -1) {
      if (index == AudioServiceBackground.queue!.length) {
        mediaItemTemp = AudioServiceBackground.queue![index];
      } else {
        mediaItemTemp = AudioServiceBackground.queue![index + 1];
      }
      _audioPlayer.stop();
      _audioPlayer = await _audioCache.play('sounds/'+mediaItemTemp.id);
      AudioServiceBackground.setMediaItem(mediaItemTemp);
      AudioServiceBackground.setState(
        position: Duration(seconds: 0),
        bufferedPosition: Duration(seconds: 0),
        controls: [MediaControl.pause, MediaControl.stop, MediaControl.skipToNext, MediaControl.skipToPrevious],
        playing: true,
        processingState: AudioProcessingState.ready
      );
    }
    _audioPlayer.onPlayerCompletion.listen((event) {
      onSkipToNext();
    });
  }

  @override
  Future<void> onUpdateQueue(List<MediaItem> queue) async {
    print('ON UPDATE QUEUE');
    await AudioServiceBackground.setQueue(queue);
    print(AudioServiceBackground.queue!.length);
  }

  @override
  Future<void> onSetRepeatMode(AudioServiceRepeatMode repeatMode) async {
    print('ON SET REPEAT MODE');
    // if (repeatMode == AudioServiceRepeatMode.all) {
    //   int index = AudioServiceBackground.queue!.indexOf(AudioServiceBackground.mediaItem!);
    //   AudioServiceBackground.setState(
    //     controls: [MediaControl.pause, MediaControl.stop],
    //     playing: true,
    //     processingState: AudioProcessingState.ready
    //   );
    //   late MediaItem mediaItemTemp;
    //   if (index != -1) {
    //     if (index == AudioServiceBackground.queue!.length) {
    //       mediaItemTemp = AudioServiceBackground.queue![index];
    //     } else {
    //       mediaItemTemp = AudioServiceBackground.queue![index + 1];
    //     }
    //     AudioServiceBackground.setMediaItem(mediaItemTemp);
    //     _audioPlayer.stop();
    //     _audioPlayer = await _audioCache.play('sounds/'+mediaItemTemp.id);
    //   }
    // }
  }


}