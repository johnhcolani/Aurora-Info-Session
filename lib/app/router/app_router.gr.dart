// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BookmarkAlbumPage]
class BookmarkAlbumRoute extends PageRouteInfo<void> {
  const BookmarkAlbumRoute({List<PageRouteInfo>? children})
    : super(BookmarkAlbumRoute.name, initialChildren: children);

  static const String name = 'BookmarkAlbumRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BookmarkAlbumPage();
    },
  );
}

/// generated route for
/// [BookmarkDetailPage]
class BookmarkDetailRoute extends PageRouteInfo<BookmarkDetailRouteArgs> {
  BookmarkDetailRoute({
    Key? key,
    required String url,
    List<PageRouteInfo>? children,
  }) : super(
         BookmarkDetailRoute.name,
         args: BookmarkDetailRouteArgs(key: key, url: url),
         initialChildren: children,
       );

  static const String name = 'BookmarkDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookmarkDetailRouteArgs>();
      return BookmarkDetailPage(key: args.key, url: args.url);
    },
  );
}

class BookmarkDetailRouteArgs {
  const BookmarkDetailRouteArgs({this.key, required this.url});

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'BookmarkDetailRouteArgs{key: $key, url: $url}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookmarkDetailRouteArgs) return false;
    return key == other.key && url == other.url;
  }

  @override
  int get hashCode => key.hashCode ^ url.hashCode;
}

/// generated route for
/// [RandomImagePage]
class RandomImageRoute extends PageRouteInfo<void> {
  const RandomImageRoute({List<PageRouteInfo>? children})
    : super(RandomImageRoute.name, initialChildren: children);

  static const String name = 'RandomImageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RandomImagePage();
    },
  );
}
