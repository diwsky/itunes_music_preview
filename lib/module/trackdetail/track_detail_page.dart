import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_music_preview/api/music/music_track_response.dart';
import 'package:itunes_music_preview/common/app_assets.dart';
import 'package:itunes_music_preview/module/trackdetail/track_detail_controller.dart';
import 'package:itunes_music_preview/style/app_color.dart';
import 'package:itunes_music_preview/style/app_dimen.dart';
import 'package:itunes_music_preview/style/app_text_style.dart';
import 'package:itunes_music_preview/utility/extension/date_time_ext.dart';
import 'package:itunes_music_preview/utility/extension/string_ext.dart';
import 'package:itunes_music_preview/utility/extension/widget_ext.dart';
import 'package:itunes_music_preview/widget/app_screen.dart';
import 'package:itunes_music_preview/widget/app_text.dart';
import 'package:itunes_music_preview/widget/scrolling_text.dart';
import 'package:skeletons/skeletons.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

class TrackDetailPage extends StatelessWidget {
  TrackDetailPage({Key? key}) : super(key: key);
  final MusicTrackResponse item = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(TrackDetailController(item));

    return AppScreen(
        body: SingleChildScrollView(
      child: Obx(() => Container(
            constraints:
                BoxConstraints(minHeight: Get.height, minWidth: Get.width),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [_controller.artworkColor.value, Colors.white],
                    stops: const [0.2, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              children: [
                ///Build genre widget if has data
                item.genre.isNotNullOrEmpty
                    ? Container(
                        margin: const EdgeInsets.all(AppDimen.paddingMedium),
                        height: Get.height / 10,
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimen.paddingMedium,
                                  vertical: AppDimen.paddingSuperSmall),
                              decoration: const BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppDimen.paddingMedium))),
                              child: AppText(
                                item.genre!,
                                style: AppTextStyle.regular(
                                    size: AppDimen.fontLarge,
                                    color: AppColor.accent),
                              ),
                            ).asGlass(
                                clipBorderRadius: const BorderRadius.all(
                                    Radius.circular(AppDimen.paddingMedium)))),
                      )
                    : SizedBox(
                        height: Get.height / 10,
                      ),

                ///Big album art work
                Hero(
                  tag: item.trackId,
                  child: SizedBox(
                    width: Get.width / 2,
                    height: Get.width / 2,
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimen.paddingMedium),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          fit: BoxFit.cover,
                          imageUrl: item.trackArtWorkUrl,
                          placeholder: (context, url) => SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: Get.width / 2,
                              height: Get.width / 2,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset(AppAssets.noImage, fit: BoxFit.cover),
                        )),
                  ),
                ),

                ///Song name
                const SizedBox(height: AppDimen.paddingLarge),
                ScrollingText(item.trackName,
                    style: AppTextStyle.bold(size: AppDimen.fontExtraLarge),
                    height: AppDimen.iconSizeExtraLarge),
                const SizedBox(height: AppDimen.paddingSuperSmall),
                AppText(
                  item.artistName,
                  maxLines: 2,
                  style: AppTextStyle.regular(
                      size: AppDimen.fontLarge, color: Colors.black87),
                ),

                ///Release Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      "${item.collectionName}. ",
                      style: AppTextStyle.regular(),
                    ),
                    // const SizedBox(width: AppDimen.paddingMedium),
                    AppText(
                      "Released on ${item.releaseDate.toCompactDate()}",
                      style: AppTextStyle.regular(),
                    )
                  ],
                ),

                ///Menu Items
                const SizedBox(height: AppDimen.paddingLarge),
                _buildMenuItems()
              ],
            ),
          )),
    ));
  }

  _buildMenuItems() {
    List<_MenuItem> items = [];

    items.add(_MenuItem(
        description: "Buy song for ${item.priceCurrency} ${item.trackPrice}",
        url: item.trackViewUrl));
    items.add(_MenuItem(
        description: "More from ${item.collectionName}",
        url: item.collectionViewUrl));
    items.add(_MenuItem(
        description: "More by ${item.artistName}", url: item.artistViewUrl));

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimen.paddingMedium),
              topRight: Radius.circular(AppDimen.paddingMedium))),
      child: Column(
        ///Map [MenuItem] as separated widget & put it inside column
        children: items.map((e) => _menuItemView(e)).toList(),
      ),
    ).asGlass();
  }

  Widget _menuItemView(_MenuItem _menuItem) {
    final _controller = Get.find<TrackDetailController>();
    return InkWell(
      onTap: () async {
        ///Invoke function when url is not null or empty
        if (_menuItem.url.isNotNullOrEmpty) {
          return await _controller.launchUrl(_menuItem.url!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimen.paddingLarge,
            horizontal: AppDimen.paddingMedium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              _menuItem.description,
              style: AppTextStyle.regular(size: AppDimen.fontLarge),
            ),

            ///Hide arrow icon when url is empty
            if (_menuItem.url.isNotNullOrEmpty)
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
                size: AppDimen.iconSizeMedium,
              )
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String description;
  final String? url;

  _MenuItem({required this.description, this.url});
}
