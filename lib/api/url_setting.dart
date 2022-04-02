/// Created by rizkyagungramadhan@gmail.com 
/// on 4/2/2022.


class UrlSetting {
  const UrlSetting._();

  static const baseUrl = "https://itunes.apple.com";

  ///TimeOut in second unit
  static const _defaultMaxTimeOut = 10 * 1000;
  static const maxReceiveTimeOut = _defaultMaxTimeOut;
  static const maxSendTimeOut = _defaultMaxTimeOut;
  static const maxConnectTimeOut = _defaultMaxTimeOut;
}