part of 'random_image_bloc.dart';

/// Events for the random image bloc.
@freezed
class RandomImageEvent with _$RandomImageEvent {
  /// Initial event to load a random image when the screen starts.
  const factory RandomImageEvent.started() = _Started;
  
  /// Event to refresh and fetch a new random image.
  const factory RandomImageEvent.refreshRequested() = _RefreshRequested;
  
  /// Event to toggle bookmark status for the current image.
  const factory RandomImageEvent.bookmarkToggled() = _BookmarkToggled;
}

