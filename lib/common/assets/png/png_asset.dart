/// PNG asset path constants.
///
/// This class contains all PNG asset paths used throughout the application.
/// Using constants prevents typos and makes asset management easier.
///
/// All paths are relative to the assets folder and defined as static const strings.
///
/// Example:
/// ```dart
/// Image.asset(PngAsset.appLogo)
/// ```
class PngAsset {
  /// Base path for all PNG assets.
  static const String basePath = "assets/pngs";

  /// Application logo image.
  static const String appLogo = "$basePath/app_logo.png";
}