# Aurora Gallery




https://github.com/user-attachments/assets/3ae83f7a-2a48-4994-9417-08e98f0e23bb


A Flutter showcase app that fetches a random image, builds an adaptive palette around it, and lets users bookmark their favourites for offline viewing.

## Preview

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c748f7b6-435b-471b-afec-2d08c6fa7032" width="260" alt="Home screen with dark palette" />
      <br /><sub>Adaptive palette from a dark photo</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/fa3a8b42-f774-49c3-b043-f8bfecd20c67" width="260" alt="Home screen with warm palette" />
      <br /><sub>Orange glow reacts to photo tones</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/1d6088b9-55fd-4bff-860a-ac53f7aee551" width="260" alt="Empty bookmarks screen" />
      <br /><sub>Empty state nudges users to save images</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/4741d5f7-e563-4c96-923d-3dec92121b86" width="260" alt="Light themed gallery" />
      <br /><sub>Contrast adjusts automatically for bright photos</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/174c08e4-ddbd-4208-a118-e641f8052e5b" width="260" alt="Bookmark chip highlighted" />
      <br /><sub>Bookmark indicator doubles as a glowing status</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/4d63fca9-2cf8-48a0-b862-a95ba385848e" width="260" alt="Bookmarks grid with saved items" />
      <br /><sub>Saved items appear in a grid sourced from SQLite</sub>
    </td>
  </tr>
</table>

## Highlights

- **Dynamic theming** – every refresh downloads a new photo and uses `palette_generator` to extract the dominant colour. That colour drives:
  - the gradient on the `Scaffold`
  - foreground contrast for labels, indicators, and the refresh button
  - the button background/outline so it remains legible on both light and dark palettes
- **Clean architecture + BLoC** – data, domain, and presentation layers stay isolated, allowing deterministic BLoC tests and dehydration/rehydration of state.
lib/
├── core/
│   ├── constants/
│   ├── di/                 # service_locator.dart
│   ├── network/            # Dio client
│   └── resources/          # DataState, etc.
├── app/
│   ├── router/             # auto_route config + generated files
│   └── theme/              # theme cubit + styles
├── features/
│   ├── home/               # presentation (HomePage scaffold, providers)
│   ├── random_image/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── random_image_remote_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── random_image_model.dart
│   │   │   └── repositories/
│   │   │       └── random_image_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── random_image_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── random_image_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_random_image_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── random_image_bloc.dart
│   │       │   ├── random_image_event.dart
│   │       │   └── random_image_state.dart
│   │       └── widgets/
│   │           └── random_image_view.dart (+ supporting widgets/clipper)
│   ├── bookmark/
│   │   ├── data/
│   │   │   └── datasources/local/ (sqflite) + repositories
│   │   ├── domain/
│   │   │   └── entities/usecases/repositories (Add/Remove/Get bookmarks)
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   └── bookmark_album_cubit.dart
│   │       └── screens/
│   │           └── bookmark_album_page.dart (+ detail page)
│   └── splash/
│       ├── presentation/
│       │   ├── bloc/       └── splash_bloc.dart
│       │   └── screens/    └── splash_page.dart
└── integration_test/
    └── random_image_flow_test.dart
    
- **Bookmarks on device** – `sqflite` stores bookmarked images locally. Users can toggle the bookmark chip in the hero view and revisit their saved collection even offline.
- **Custom visuals** – hero image and app bar share complementary “wave” clippers, plus a glowing status halo and arc text for the image name.
- **Animations everywhere** – `AnimatedSwitcher` for the hero content, button loading indicator, and a bouncing splash logo backed by `TweenSequence`.
- **Accessible semantics** – refresh button, bookmark toggle, and empty-bookmark icon expose descriptive semantics across both light and dark themes so TalkBack/VoiceOver users get informative labels.

<p align="center">
  <img src="https://github.com/user-attachments/assets/1cca1e17-924b-4922-a83c-28812e8c7f7c" width="200" height="430" alt="Dark mode button semantics" />
  <img src="https://github.com/user-attachments/assets/12f31cd8-bf80-4577-b2f1-7744a447bda1" width="200" height="430" alt="Light mode button semantics" />
  <img src="https://github.com/user-attachments/assets/7e8902e3-cb21-4d65-9f54-7538066420b3" width="200" height="430" alt="Bookmarks screen semantics" />
</p>

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
| **Golden tests** | Pixel-diff checks for the gallery and bookmarks layouts. | `flutter test --update-goldens test/features/random_image/presentation/widgets/random_image_view_golden_test.dart`<br>`flutter test --update-goldens test/features/bookmark/presentation/widgets/bookmark_album_view_golden_test.dart` |
| **Integration test** | Drives the full “fetch + tap refresh (×4) + bookmark” flow with `integration_test`. | `flutter test integration_test/random_image_flow_test.dart` |

### Integration test video

An end-to-end capture of the integration run lives in `docs/videos/integration_demo.mp4`. Embed it wherever you publish release notes or drop it into presentations to show the adaptive theming in motion.

<p align="center">
  <a href="https://github.com/user-attachments/assets/44e788eb-6ac3-4fef-8972-043c55f4da2f" target="_blank" rel="noopener noreferrer">
    🎬 Watch the integration test walkthrough
  </a>
</p>

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
- Dominant colour extraction powered by the Flutter `palette_generator`
