import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/entities/bookmark_entity.dart';
import '../cubit/bookmark_album_cubit.dart';

/// Page displaying all bookmarked images in a grid layout.
@RoutePage()
class BookmarkAlbumPage extends StatelessWidget {
  const BookmarkAlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<BookmarkAlbumCubit>()..loadBookmarks(),
      child: const _BookmarkAlbumView(),
    );
  }
}

/// Main view widget that displays loading, error, empty, or bookmark grid states.
class _BookmarkAlbumView extends StatelessWidget {
  const _BookmarkAlbumView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF141824), Color(0xFF65719A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Center(
              child: Text('Bookmarks', textAlign: TextAlign.center),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  context.read<BookmarkAlbumCubit>().loadBookmarks(),
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: BlocBuilder<BookmarkAlbumCubit, BookmarkAlbumState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }

            if (state.bookmarks.isEmpty) {
              return const _EmptyBookmarks();
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = state.bookmarks[index];
                return _BookmarkTile(bookmark: bookmark);
              },
            );
          },
        ),
      ),
    );
  }
}

/// Individual bookmark tile widget displaying the image with URL overlay, navigates to detail on tap.
class _BookmarkTile extends StatelessWidget {
  const _BookmarkTile({required this.bookmark});

  final BookmarkEntity bookmark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.pushRoute(BookmarkDetailRoute(url: bookmark.url)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xAA0D101A), Color(0x110D101A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: bookmark.url,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) => const _ImageErrorIndicator(),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _displayUrl(bookmark.url),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _displayUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return url;
    }
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.last : url;
  }
}

/// Empty state widget shown when there are no bookmarks.
class _EmptyBookmarks extends StatelessWidget {
  const _EmptyBookmarks();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.12),
            ),
            child: Icon(
              Icons.collections_bookmark_outlined,
              size: 48,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No marked images yet.',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tap the bookmark icon on a random image to save it here.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// Error indicator widget shown when an image fails to load.
class _ImageErrorIndicator extends StatelessWidget {
  const _ImageErrorIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withValues(alpha: 0.2),
      child: const Center(
        child: Icon(Icons.broken_image_outlined, size: 40, color: Colors.grey),
      ),
    );
  }
}
