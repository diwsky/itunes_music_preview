import 'package:itunes_music_preview/common/app_assets.dart';
import 'package:itunes_music_preview/utility/app_exception.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.


enum PlaceholderType {
  typeASearch,
  noData,
  noConnection,
  somethingWentWrong,
}

extension PlaceholderTypeExt on PlaceholderType {
  String get animationPath {
    switch (this) {
      case PlaceholderType.noData:
        return AppAssets.animationNoData;
      case PlaceholderType.noConnection:
        return AppAssets.animationNoConnection;
      case PlaceholderType.somethingWentWrong:
        return AppAssets.animationSomethingWentWrong;
      case PlaceholderType.typeASearch:
        return AppAssets.animationSearchTyping;
      default:
        throw AppException(
            "No PlaceholderType found for giving the animationPath");
    }
  }

  String get description {
    switch (this) {
      case PlaceholderType.noData:
        return "No data found";
      case PlaceholderType.noConnection:
        return "No connection available";
      case PlaceholderType.somethingWentWrong:
        return "Oops something went wrong";
      case PlaceholderType.typeASearch:
        return "Please search music from your favorite artist";
      default:
        throw AppException(
            "No PlaceholderType found for giving the description");
    }
  }
}