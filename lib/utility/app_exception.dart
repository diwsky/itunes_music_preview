/// Created by rizkyagungramadhan@gmail.com 
/// on 4/1/2022.


class AppException implements Exception {

  String message;

  AppException(this.message);

  @override
  String toString() => message;
}