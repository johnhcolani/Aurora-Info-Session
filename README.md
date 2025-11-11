# Aurora Gallery

A Flutter showcase app that fetches a random image, builds an adaptive palette around it, and lets users bookmark their favourites for offline viewing.

## Preview

<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-11 at 18 17 28" src="https://github.com/user-attachments/assets/c748f7b6-435b-471b-afec-2d08c6fa7032" />

<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-11 at 18 17 41" src="https://github.com/user-attachments/assets/fa3a8b42-f774-49c3-b043-f8bfecd20c67" />
<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-11 at 18 17 56" src="https://github.com/user-attachments/assets/1d6088b9-55fd-4bff-860a-ac53f7aee551" />
<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-11 at 18 18 29" src="https://github.com/user-attachments/assets/4741d5f7-e563-4c96-923d-3dec92121b86" />
<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-11 at 18 18 53" src="https://github.com/user-attachments/assets/174c08e4-ddbd-4208-a118-e641f8052e5b" />
<img width="1320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-11-11 at 18 19 03" src="https://github.com/user-attachments/assets/4d63fca9-2cf8-48a0-b862-a95ba385848e" />






| Home (dark context) | Home (light context) | Empty bookmarks | Saved bookmarks |
| --- | --- | --- | --- |
| ![Home dark](docs/images/home-dark.png) | ![Home light](docs/images/home-light.png) | ![Empty bookmarks](docs/images/bookmarks-empty.png) | ![Saved bookmarks](docs/images/bookmarks-saved.png) |

> ℹ️ Put the exported screenshots into the paths listed above so they can render in this table.

## Highlights

- **Dynamic theming** – every refresh downloads a new photo and uses `palette_generator` to extract the dominant colour. That colour drives:
  - the gradient on the `Scaffold`
  - foreground contrast for labels, indicators, and the refresh button
  - the button background/outline so it remains legible on both light and dark palettes
- **Clean architecture + BLoC** – data, domain, and presentation layers stay isolated, allowing deterministic BLoC tests and dehydration/rehydration of state.
- **Bookmarks on device** – `sqflite` stores bookmarked images locally. Users can toggle the bookmark chip in the hero view and revisit their saved collection even offline.
- **Custom visuals** – hero image and app bar share complementary “wave” clippers, plus a glowing status halo and arc text for the image name.
- **Animations everywhere** – `AnimatedSwitcher` for the hero content, button loading indicator, and a bouncing splash logo backed by `TweenSequence`.

## Architecture

```
lib/
├── app/                # global router, theme, bootstrap
├── core/               # constants, data state, DI (GetIt)
├── features/
│   ├── home/           # presentation layer for the gallery screen
│   ├── random_image/   # data + domain + presentation for image fetching
│   ├── bookmark/       # sqflite data source, repository, Cubit UI
│   └── splash/         # timed splash BLoC + animated view
└── integration_test/   # end-to-end flow assertions
```

- **Freezed** generates immutable models/state (`RandomImageState`, `RandomImageModel`, `BookmarkEntity` DTOs) with exhaustive unions.
- **AutoRoute** declares navigation maps in `app_router.dart`; generated code provides `HomeRoute`, `BookmarkAlbumRoute`, etc., so navigation stays type-safe.
- **GetIt** wires dependencies (`Dio`, repositories, use cases, cubits/BLoCs) and keeps widget code clean.

## Data flow

1. `RandomImageBloc` reacts to `RandomImageEvent.refreshRequested`.
2. `GetRandomImageUseCase` calls `RandomImageRepository`, which requests JSON from the Cloud Run endpoint through `Dio`.
3. The dominant colour from the returned image is extracted and forwarded in the state to drive theming.
4. Bookmark toggles call into `AddBookmarkUseCase` / `RemoveBookmarkUseCase` and update the local cache through `BookmarkRepository` → `BookmarkLocalDataSource` (`sqflite`).
5. `BookmarkAlbumCubit` loads those entities when the bookmarks page comes into view.

## Running the app

```bash
flutter pub get
flutter run -d <device-id>
```

## Automated tests

| Suite | Description | Command |
| --- | --- | --- |
| **BLoC tests** | Validates `RandomImageBloc` transitions (loading → success/failure) using `bloc_test` and `mocktail`. | `flutter test test/features/random_image/presentation/bloc` |
| **Widget tests** | Exercises the gallery view widgets (loading states, error messages, button semantics). | `flutter test test/features/random_image/presentation/widgets/random_image_view_test.dart` |
| **Golden tests** | Pixel-diff checks for the gallery and bookmarks layouts. | `flutter test --update-goldens test/features/random_image/presentation/widgets/random_image_view_golden_test.dart`  
`flutter test --update-goldens test/features/bookmark/presentation/widgets/bookmark_album_view_golden_test.dart` |
| **Integration test** | Drives the full “fetch + tap refresh (×4) + bookmark” flow with `integration_test`. | `flutter test integration_test/random_image_flow_test.dart` |

### Integration test video

An end-to-end capture of the integration run lives in `docs/videos/integration_demo.mp4`. Embed it wherever you publish release notes or drop it into presentations to show the adaptive theming in motion.

## Navigation & routing

Routes live in `app_router.dart` and are generated by `auto_route`:

- `SplashRoute` → animated entry point
- `HomeRoute` → adaptive gallery view
- `BookmarkAlbumRoute` and `BookmarkDetailRoute`

Navigation calls remain terse (`context.router.push(const BookmarkAlbumRoute())`) while retaining compile-time safety.

## Development tips

- Regenerate Freezed & AutoRoute code after model or route changes:
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- Update goldens whenever you refresh UI styling:
  ```bash
  flutter test --update-goldens test/features/random_image/presentation/widgets/random_image_view_golden_test.dart
  flutter test --update-goldens test/features/bookmark/presentation/widgets/bookmark_album_view_golden_test.dart
  ```
- Integration test videos pair nicely with the CI artifact produced by `integration_test/random_image_flow_test.dart`.

## Credits

- UI concept & screenshots by the Aurora product team.
- Dominant colour extraction powered by the Flutter `palette_generator` package.
- App icon & splash logo sourced from the project assets folder.
