import 'package:flutter/material.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/style/app_color.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:just_audio/just_audio.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MusicPlayerView extends StatelessWidget {
  final MusicTrackResponse item;
  final AudioPlayer audioPlayer;
  final Function()? onStopOrPause;
  final Function()? onPlay;

  const MusicPlayerView(
      {required this.audioPlayer,
      required this.item,
      this.onStopOrPause,
      this.onPlay,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget playPauseButton = const SizedBox.shrink();

    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (_, snapshot) {
          if (snapshot.data is! PlayerState) return const SizedBox.shrink();

          final PlayerState state = snapshot.data!;

          // if (!state.playing) return const SizedBox.shrink();

          final process = state.processingState;

          ///Loading or Buffering
          if (process == ProcessingState.loading ||
              process == ProcessingState.buffering) {
            playPauseButton = Transform.scale(
              scale: 0.5,
                child: const CircularProgressIndicator(color: AppColor.primary));
          }

          ///Ready or Completed
          if (process == ProcessingState.ready ||
              process == ProcessingState.completed) {
            final isPlaying = audioPlayer.playing;
            if (process == ProcessingState.completed && isPlaying) {
              audioPlayer.seek(Duration.zero);
              _onPause;
            }
            playPauseButton = AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: !isPlaying
                  ? IconButton(
                      key: const ValueKey("play"),
                      onPressed: _onPlay,
                      icon: const Icon(
                        Icons.play_arrow,
                        size: AppDimen.iconSizeExtraLarge3,
                      ),
                    )
                  : IconButton(
                      key: const ValueKey("pause"),
                      onPressed: _onPause,
                      icon: const Icon(
                        Icons.pause,
                        size: AppDimen.iconSizeExtraLarge3,
                      ),
                    ),
            );
          }

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimen.paddingLarge),
            child: Center(
              child: playPauseButton,
            ),
          );
        });
  }

  void _onPlay() async {
    audioPlayer.play();
    onPlay?.call();
  }

  void _onPause() async {
    await audioPlayer.pause();
    onStopOrPause?.call();
  }
}
