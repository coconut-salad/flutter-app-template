# Flutter App Template

A modern Flutter application template implementing core features and best practices.

## Features

- 🔄 **State Management** - Riverpod for efficient state management and dependency injection
- 🔒 **Authentication** - Basic authentication flow with secure storage
- 🌐 **API Integration** - HTTP client setup with offline mode support
- 🎨 **Theme Support** - Material 3 theming with custom color schemes
- 🌍 **Internationalization** - Multi-language support with YAML-based translations
- 💾 **Local Storage** - Secure storage and shared preferences implementation
- 📱 **Responsive Design** - Basic responsive UI setup
- 🪵 **Logging** - Structured logging with the logger package

## Project Structure

```
lib/
├── api/              # API clients and services
├── models/           # Data models
├── providers/        # Riverpod providers
├── screens/          # UI screens
│   ├── home/        # Home screen related widgets
│   └── login/       # Login screen related widgets
├── utils/           # Utilities and helpers
└── main.dart        # Application entry point
```

## Dependencies

- flutter_riverpod: ^2.6.1
- flutter_secure_storage: ^9.2.2
- shared_preferences: ^2.3.3
- http: ^1.2.2
- logger: ^2.5.0
- yaml: ^3.1.2
- intl: ^0.20.1

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- iOS development setup (for Mac users)
- Android development setup

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter_app_template.git
   cd flutter_app_template
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Architecture

The template follows a clean architecture approach with:

- **Providers Layer** - State management and dependency injection using Riverpod
- **Services Layer** - API clients and authentication services
- **UI Layer** - Screens and widgets
- **Data Layer** - Models and data handling

## State Management

The template uses Riverpod for state management, featuring:

- State providers for app-wide state
- API state management
- Authentication state
- Settings management
- Offline mode support

## Authentication

Basic authentication implementation includes:

- Secure token storage
- API key management
- Login flow
- Authentication state management

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
