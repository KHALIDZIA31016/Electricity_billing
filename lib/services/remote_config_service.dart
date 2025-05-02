// import 'package:firebase_remote_config/firebase_remote_config.dart';
//
// class RemoteConfigService {
//   final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
//
//
//   Future<void> init()  async{
//    await _remoteConfig.setConfigSettings(
//         RemoteConfigSettings(
//           fetchTimeout: Duration(seconds: 10),
//           minimumFetchInterval: Duration(seconds: 5),
//         ));
//     await _remoteConfig.fetchAndActivate();
//   }
//
//   int getInterstitialFrequency() {
//     String value = _remoteConfig.getString('interstitial');
//     return int.tryParse(value) ?? 0;
//   }
//
// }
//
