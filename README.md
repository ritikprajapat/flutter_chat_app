# Chat Application

A Flutter chat application with user management, message history, and dynamic content fetching.

## Features

- **User Management**: Browse and manage a list of users with online/offline status indicators
- **Chat History**: View recent conversations with last message previews and timestamps
- **Dynamic Messages**: Fetch random messages from multiple APIs (Quotable, DummyJSON, BoredAPI, JSONPlaceholder)
- **Word Definitions**: Lookup word meanings from the Dictionary API
- **Gradient UI**: Beautiful gradient avatars and animated tab switching
- **Responsive Design**: Works seamlessly on Android and iOS

## Project Structure

```
lib/
├── main.dart              # App entry point
└── src/
    ├── app/              # App configuration and routing
    ├── core/             # Shared utilities, helpers, and widgets
    │   ├── helpers/      # SnackBar helper
    │   ├── routes/       # Provider setup
    │   └── widgets/      # Reusable widgets (GradientAvatarWidget, TabSwitcherWidget, etc.)
    ├── data/             # Data layer
    │   ├── models/       # Data models (User, Message, ChatHistory)
    │   └── services/     # API services
    └── modules/          # Feature modules
        ├── home/         # Home screen with tab switching
        └── chat/         # Chat conversation screens
```

## Getting Started

### Prerequisites

- Flutter 3.9.2 or higher
- Dart 3.9.2 or higher

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Testing

This project includes unit tests, widget tests, and integration tests.

### Run All Tests

```bash
flutter test
```

### Run Unit Tests Only

```bash
flutter test test/models test/services
```

### Run Widget Tests Only

```bash
flutter test test/widgets
```

### Run Integration Tests

```bash
flutter test integration_test/app_test.dart
```

### Test Coverage

- **Unit Tests**: Models and API services
  - `test/models/user_model_test.dart` - User model and ChatHistory timeAgo logic
  - `test/services/api_service_test.dart` - Word definition fetching with mocked Dio
- **Widget Tests**: UI components
  - `test/widgets/gradient_avatar_widget_test.dart` - Avatar rendering with online indicator
  - `test/widgets/tab_switcher_widget_test.dart` - Tab switching and styling
- **Integration Tests**: Full app flows
  - `integration_test/app_test.dart` - App launch, tab navigation smoke test

## Dependencies

- **flutter**: UI framework
- **provider**: State management
- **dio**: HTTP client
- **flutter_test**: Testing framework (dev)
- **integration_test**: Integration testing (dev)
- **flutter_lints**: Linting (dev)

## Building

### Build APK (Android)

```bash
flutter build apk --no-tree-shake-icons
```

### Build iOS

```bash
flutter build ios
```

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Dio Documentation](https://pub.dev/packages/dio)
