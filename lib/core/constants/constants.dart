/// Hard-coded URLs and paths reused across the app.
class AppConstants {
  /// Points to the deployed backend handling API requests.
  static const String baseUrl =
      'https://november7-730026606190.europe-west1.run.app';

  /// Endpoint exposed by the backend to fetch a random image.
  static const String randomImagePath = '/image';

  /// Convenience getter to avoid manual string concatenation at call sites.
  static String get randomImageUrl => '$baseUrl$randomImagePath';
}