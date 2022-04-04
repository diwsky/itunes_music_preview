import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/common/app_assets.dart';
import 'package:itunes_music_preview/style/app_color.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/style/app_text_style.dart';
import 'package:itunes_music_preview/utility/extension/widget_ext.dart';
import 'package:itunes_music_preview/widget/app_text.dart';
import 'package:itunes_music_preview/widget/scrolling_text.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletons/skeletons.dart';

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

  /// Doc : Listen to 3 stream in one call for getting current position time, buffered position & total duration of audio source.
  /// @author rizkyagungramadhan@gmail.com on 02-Apr-2022, Sat, 18:26.
  Stream<_PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, _PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => _PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    Widget playPauseButton = const SizedBox.shrink();

    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (_, snapshot) {
          ///Return no view if [snapshot.data] is not instance of [PlayerState]
          if (snapshot.data is! PlayerState) return const SizedBox.shrink();

          final PlayerState state = snapshot.data!;

          final process = state.processingState;

          ///Loading or Buffering
          if (process == ProcessingState.loading ||
              process == ProcessingState.buffering) {
            playPauseButton = Transform.scale(
                scale: 0.5,
                child:
                    const CircularProgressIndicator(color: AppColor.primary));
          }

          ///Ready or Completed
          if (process == ProcessingState.ready ||
              process == ProcessingState.completed) {
            final isPlaying = audioPlayer.playing;

            ///Song track completed playing
            if (process == ProcessingState.completed && isPlaying) {
              audioPlayer.seek(Duration.zero);
              _onPause;
            }

            playPauseButton = AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
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

          ///Main Player Widget
          return Container(
            width: double.infinity,
            height: AppDimen.musicPlayerHeight,
            padding: const EdgeInsets.all(AppDimen.paddingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ///Track artwork
                    SizedBox(
                      height: AppDimen.iconSizeMax2,
                      width: AppDimen.iconSizeMax2,
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppDimen.paddingMedium),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            fit: BoxFit.cover,
                            imageUrl: item.trackArtWorkUrl,
                            placeholder: (context, url) => const SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: AppDimen.iconSizeMax2,
                                height: AppDimen.iconSizeMax2,
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                                AppAssets.noImage,
                                fit: BoxFit.cover),
                          )),
                    ),

                    ///Song & artist name
                    const SizedBox(
                      width: AppDimen.paddingMedium,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScrollingText(
                            item.trackName,
                            height: AppDimen.iconSizeExtraLarge3,
                            style:
                            AppTextStyle.bold(size: AppDimen.fontLarge),
                          ),
                          AppText(
                            item.artistName,
                            style: AppTextStyle.light(color: AppColor.accent),
                          )
                        ],
                      ),
                    ),

                    ///Control button
                    playPauseButton
                  ],
                ),

                ///Duration Seekbar
                const SizedBox(height: AppDimen.paddingMedium),
                _buildDurationSeekBarWidget()
              ],
            ),
          ).asGlass();
        });
  }

  /// Doc : Play the [audioPlayer] & invoke [onPlay] callback.
  /// @author rizkyagungramadhan@gmail.com on 02-Apr-2022, Sat, 14:29.
  void _onPlay() async {
    audioPlayer.play();
    onPlay?.call();
  }

  /// Doc : Pause the [audioPlayer] & invoke [onStopOrPause] callback.
  /// @author rizkyagungramadhan@gmail.com on 02-Apr-2022, Sat, 14:29.
  void _onPause() async {
    await audioPlayer.pause();
    onStopOrPause?.call();
  }

  Widget _buildDurationSeekBarWidget() {
    return StreamBuilder<_PositionData>(
        stream: _positionDataStream,
        builder: (_, snapshot) {
          if (snapshot.data is! _PositionData) return const SizedBox.shrink();

          final data = snapshot.data!;
          return ProgressBar(
            baseBarColor: Colors.grey,
            thumbColor:
                audioPlayer.playing ? AppColor.primary : AppColor.accent,
            bufferedBarColor: AppColor.accent,
            progress: data.position,
            buffered: data.bufferedPosition,
            total: data.totalDuration,
            thumbRadius: 7.5,
            timeLabelTextStyle: AppTextStyle.light(color: AppColor.accent),
            timeLabelLocation: TimeLabelLocation.below,
            onSeek: (duration) => audioPlayer.seek(duration),
          );
        });
  }
}

class _PositionData {
  Duration position;
  Duration bufferedPosition;
  Duration totalDuration;

  _PositionData(this.position, this.bufferedPosition, this.totalDuration);
}
