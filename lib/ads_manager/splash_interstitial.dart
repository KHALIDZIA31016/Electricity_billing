// import 'dart:async';
//
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class SplashInterstitialAd extends GetxController {
//   InterstitialAd? _interstitialAd;
//
//   bool showInterstitialAd = true;
//   final Completer<void> _adCompleted = Completer<void>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadInterstitialAd();
//     fetchRemoteConfig();
//   }
//
//   /// Load the interstitial ad if ads are enabled
//   void loadInterstitialAd() {
//     // if (!showInterstitialAd) return;
//
//     InterstitialAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/1033173712", // Your ad unit ID
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) {
//           _interstitialAd = ad;
//           print("############ Interstitial ad loaded.");
//         },
//         onAdFailedToLoad: (error) {
//           print('######### Interstitial failed to load: ${error.message}');
//           _interstitialAd = null;
//         },
//       ),
//     );
//   }
//
//   /// Show the ad if available and hasn't been shown yet
//
//   Future<void> checkAndShowAdOnVisit() async {
//     // If ads are not enabled, just complete the future
//     if (!showInterstitialAd) {
//       _adCompleted.complete();
//       return;
//     }
//
//     if (_interstitialAd != null) {
//       // Always show the ad regardless of previous shows
//       _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
//         onAdDismissedFullScreenContent: (ad) {
//           print("Interstitial ad dismissed.");
//           loadInterstitialAd(); // Load next ad for future use
//           _adCompleted.complete(); // Mark the ad as complete
//         },
//         onAdFailedToShowFullScreenContent: (ad, error) {
//           print("Interstitial ad failed to show: ${error.message}");
//           loadInterstitialAd(); // Try loading again
//           _adCompleted.complete(); // Mark the ad as complete even on failure
//         },
//       );
//       _interstitialAd?.show();
//       _interstitialAd = null; // Set to null to indicate it's being shown
//     } else {
//       print("Interstitial ad not ready, loading...");
//       loadInterstitialAd(); // Load for next time
//       _adCompleted.complete(); // Mark the ad as complete if it's not ready
//     }
//   }
//   // This function will return a Future that completes when the ad is finished.
//   Future<void> waitForAdToComplete() {
//     return _adCompleted.future;
//   }
//
//   /// Fetch config from Firebase Remote Config
//   Future<void> fetchRemoteConfig() async {
//     final remoteConfig = FirebaseRemoteConfig.instance;
//
//     try {
//       await remoteConfig.setDefaults({
//         'SplashInterstitial': true,
//       });
//
//       await remoteConfig.fetchAndActivate();
//
//       showInterstitialAd = remoteConfig.getBool('SplashInterstitial');
//       print('Remote config - showInterstitialAd: $showInterstitialAd');
//
//       if (showInterstitialAd) {
//         loadInterstitialAd();
//       }
//
//     } catch (e) {
//       print('Remote Config fetch failed: $e');
//       showInterstitialAd = true;
//       loadInterstitialAd();
//       fetchRemoteConfig();
//     }
//   }
// }
//



import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class SplashInterstitialAd extends GetxController {
  InterstitialAd? _interstitialAd;
  bool _hasShownAd = false;
  bool showInterstitialAd = true;

  @override
  void onInit() {
    super.onInit();
    loadInterstitialAd();
    fetchRemoteConfig();
  }

  /// Load the interstitial ad if ads are enabled
  void loadInterstitialAd() {
    if (!showInterstitialAd) return;

    InterstitialAd.load(

      adUnitId: "ca-app-pub-3940256099942544/1033173712",

      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print("############################# Interstitial ad loaded.");
        },
        onAdFailedToLoad: (error) {
          print('################################# Interstitial failed to load: ${error.message}');
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Show the ad if available and hasn't been shown yet
  Future<void> checkAndShowAdOnVisit() async{
    if (!showInterstitialAd || _hasShownAd) return;

    if (_interstitialAd != null) {
      _hasShownAd = true;
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print("Interstitial ad dismissed.");
          _hasShownAd = false;
          loadInterstitialAd(); // Load next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print("Interstitial ad failed to show: ${error.message}");
          _hasShownAd = false;
          loadInterstitialAd(); // Try loading again
        },
      );
      _interstitialAd?.show();
      _interstitialAd = null;
    } else {
      print("Interstitial ad not ready, loading...");
      loadInterstitialAd(); // Load for next time
    }
  }

  /// Fetch config from Firebase Remote Config
  Future<void> fetchRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setDefaults({
        'SplashInterstitial': true,
      });

      await remoteConfig.fetchAndActivate();

      showInterstitialAd = remoteConfig.getBool('SplashInterstitial');
      print('Remote config - showInterstitialAd: $showInterstitialAd');

      if (showInterstitialAd) {
        loadInterstitialAd();

      }

    } catch (e) {
      print('Remote Config fetch failed: $e');
      showInterstitialAd = true;
      loadInterstitialAd();
      fetchRemoteConfig();

    }
  }
}


