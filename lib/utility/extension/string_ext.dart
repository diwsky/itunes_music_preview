/// Created by rizkyagungramadhan@gmail.com 
/// on 4/1/2022.


extension StringExt on String? {
  static const _nil = "null";

  String get asTitleCase {
    if (this?.isNotNullOrEmpty ?? false) {
      return this?.trim().split(" ").map((word) => word[0].toUpperCase() + word.substring(1)).join(" ") ?? this!;
    }
    return orDash();
  }

  bool get isNotNullOrEmpty => this != _nil ? (this ?? "").isNotEmpty : false;

  bool get isNullOrEmpty => this != _nil ? (this ?? "").isEmpty : true;

  String orDash() => isNullOrEmpty ? "-" : this!;
}
