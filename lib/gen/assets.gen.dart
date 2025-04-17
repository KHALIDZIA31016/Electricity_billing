import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  static const AssetGenImage electricity = AssetGenImage(
    'assets/electricity.jpg',
  );
  static const AssetGenImage fesco = AssetGenImage('assets/fesco.png');
  static const AssetGenImage gepco = AssetGenImage('assets/gepco.png');
  static const AssetGenImage hesco = AssetGenImage('assets/hesco.png');
  static const AssetGenImage highVolt = AssetGenImage('assets/high_volt.png');
  static const AssetGenImage iesco = AssetGenImage('assets/iesco.png');
  static const AssetGenImage kelectric = AssetGenImage('assets/kelectric.png');
  static const AssetGenImage lesco = AssetGenImage('assets/lesco.png');
  static const AssetGenImage mepco = AssetGenImage('assets/mepco.png');
  static const AssetGenImage pesco = AssetGenImage('assets/pesco.png');
  static const AssetGenImage qesco = AssetGenImage('assets/qesco.png');
  static const AssetGenImage sepco = AssetGenImage('assets/sepco.png');
  static const AssetGenImage teco = AssetGenImage('assets/teco.png');
  static const AssetGenImage welcomeBack = AssetGenImage(
    'assets/welcome-back.png',
  );

  /// List of all assets
  static List<AssetGenImage> get values => [
    electricity,
    fesco,
    gepco,
    hesco,
    highVolt,
    iesco,
    kelectric,
    lesco,
    mepco,
    pesco,
    qesco,
    sepco,
    teco,
    welcomeBack,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
