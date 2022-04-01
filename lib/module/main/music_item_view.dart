import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/common/app_assets.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/style/app_text_style.dart';
import 'package:itunes_music_preview/widget/app_text.dart';
import 'package:skeletons/skeletons.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

class MusicItemView extends StatelessWidget {
  final MusicTrackResponse item;
  final GestureTapCallback onPressed;

  const MusicItemView({required this.item, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.isStreamable ? onPressed : null,
      child: Container(
        color: item.isStreamable ? Colors.white : CupertinoColors.systemGrey2,
        padding: const EdgeInsets.all(AppDimen.paddingMedium),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ///Album ArtWork
            ClipRRect(
                borderRadius: BorderRadius.circular(AppDimen.paddingMedium),
                child: CachedNetworkImage(
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  fit: BoxFit.cover,
                  imageUrl: item.trackArtWorkUrl,
                  placeholder: (context, url) => const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: double.infinity,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset(AppAssets.noImage, fit: BoxFit.cover),
                )),

            ///Song, Artist & Collection name
            const SizedBox(
              width: AppDimen.paddingMedium,
            ),
            Column(
              children: [
                AppText(
                  item.trackName,
                  style: AppTextStyle.regular(size: AppDimen.fontLarge),
                ),
                const SizedBox(height: AppDimen.paddingMedium),
                AppText(item.artistName),
                const SizedBox(height: AppDimen.paddingMedium),
                AppText(item.collectionName)
              ],
            )
          ],
        ),
      ),
    );
  }
}
