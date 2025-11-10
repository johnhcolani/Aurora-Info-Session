import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/use_case.dart';
import '../../domain/entities/bookmark_entity.dart';
import '../../domain/usecases/get_bookmarks_usecase.dart';

class BookmarkAlbumState {
  const BookmarkAlbumState({
    this.isLoading = true,
    this.bookmarks = const <BookmarkEntity>[],
    this.errorMessage,
  });

  final bool isLoading;
  final List<BookmarkEntity> bookmarks;
  final String? errorMessage;

  BookmarkAlbumState copyWith({
    bool? isLoading,
    List<BookmarkEntity>? bookmarks,
    String? errorMessage,
  }) {
    return BookmarkAlbumState(
      isLoading: isLoading ?? this.isLoading,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage,
    );
  }
}

class BookmarkAlbumCubit extends Cubit<BookmarkAlbumState> {
  BookmarkAlbumCubit(this._getBookmarksUseCase)
      : super(const BookmarkAlbumState());

  final GetBookmarksUseCase _getBookmarksUseCase;

  Future<void> loadBookmarks() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final bookmarks = await _getBookmarksUseCase(NoParams());
      emit(
        state.copyWith(
          isLoading: false,
          bookmarks: bookmarks,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          bookmarks: const <BookmarkEntity>[],
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
