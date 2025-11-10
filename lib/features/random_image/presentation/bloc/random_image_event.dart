part of 'random_image_bloc.dart';

@freezed
class RandomImageEvent with _$RandomImageEvent {
  const factory RandomImageEvent.started() = _Started;
  const factory RandomImageEvent.refreshRequested() = _RefreshRequested;
  const factory RandomImageEvent.bookmarkToggled() = _BookmarkToggled;
}

