# Taghyeer Test - Flutter Application

A modern Flutter application built with Clean Architecture principles, featuring product and post management with pagination, authentication, and theme support.

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Dependencies](#-dependencies)
- [Screenshots](#-screenshots)

## ✨ Features

### Core Features
- 🔐 **Authentication** - Secure user login with JWT token management
- 📦 **Product Management** - Browse products with pagination and detailed views
- 📝 **Post Management** - View posts with reactions (likes/dislikes) and tags
- 🎨 **Theme Support** - Light, Dark, and System theme modes
- 📱 **Responsive Design** - Adaptive UI using Flutter ScreenUtil
- ♾️ **Infinite Scroll** - Pagination with loading indicators

### Product Features
- Product listing with grid view
- Product details with image carousel
- Pagination with end-of-list loader
- Product information display (price, rating, stock, etc.)
- Product tags and additional information

### Post Features
- Post listing with card view
- Post details with full content
- Reactions display (likes/dislikes)
- Post tags with hashtags
- View count tracking

## 🛠 Tech Stack

- **Framework**: Flutter 3.38.7
- **State Management**: GetX 4.7.3
- **Local Storage**: GetStorage 2.1.1
- **Networking**: Dio 5.9.2
- **UI Components**: 
  - Flutter ScreenUtil 5.9.3 (Responsive design)
  - Flutter SVG 2.2.4 (SVG support)
- **Utilities**:
  - Logger 2.6.2 (Logging)
  - JWT Decoder 2.0.1 (Token management)

## 🏗 Architecture

This project follows **Clean Architecture** principles, ensuring separation of concerns and maintainability. The architecture is divided into three main layers:

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                     │
│  (Views, ViewModels, Widgets, Routing, Common Widgets)   │
└──────────────────────┬──────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────┐
│                      Domain Layer                         │
│  (Entities, Repositories Interfaces, Use Cases, Results)  │
└──────────────────────┬──────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────┐
│                       Data Layer                         │
│  (Models, API Repositories, Requests, Local Storage)     │
└─────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

#### 1. **Presentation Layer** (`lib/presentation/`)
- **Views**: UI screens and widgets
- **ViewModels**: Business logic and state management using GetX
- **Routing**: Navigation configuration
- **Common Widgets**: Reusable UI components

#### 2. **Domain Layer** (`lib/domain/`)
- **Entities**: Business objects (ProductEntity, PostEntity, etc.)
- **Repositories**: Abstract interfaces defining data contracts
- **Use Cases**: Business logic implementation
- **Results**: Success/Failure result types

#### 3. **Data Layer** (`lib/data/`)
- **Remote**: API communication (models, repositories, requests)
- **Local**: Local storage and caching
- **Controllers**: Network and storage controllers

#### 4. **Common Layer** (`lib/common/`)
- **Utils**: Dependency injection, logging, routing utilities
- **Themes**: App theming configuration
- **Assets**: Asset management
- **Colors & Dimensions**: Design system constants

## 📁 Project Structure

```
lib/
├── common/                          # Shared utilities and constants
│   ├── assets/                      # Asset references
│   ├── colors/                      # Color constants
│   ├── dimensions/                  # Spacing and padding constants
│   ├── themes/                      # Theme configuration
│   └── utils/                       # Utilities (DI, routing, logger)
│
├── data/                            # Data layer
│   ├── local/                       # Local storage
│   │   ├── config/                 # Cache keys
│   │   └── controller/             # Storage controller
│   └── remote/                     # API communication
│       ├── config/                 # API endpoints
│       ├── controller/             # Network controller
│       ├── models/                 # Data models
│       ├── repositories/           # API repository implementations
│       ├── requests/               # API request handlers
│       └── response/               # API response wrapper
│
├── domain/                         # Domain layer (Business logic)
│   ├── entities/                   # Business entities
│   ├── repositories/               # Repository interfaces
│   ├── result/                     # Result types (Success/Failure)
│   └── uc/                         # Use cases
│
└── presentation/                   # Presentation layer
    ├── view_models/                # GetX view models
    └── views/                      # UI screens and widgets
        ├── bottom_nav_bar/         # Bottom navigation
        ├── common_widgets/         # Reusable widgets
        ├── login/                  # Login screen
        ├── post_details/           # Post details screen
        ├── post_list/              # Post list screen
        ├── product_details/        # Product details screen
        ├── product_list/           # Product list screen
        ├── settings/               # Settings screen
        └── splash/                 # Splash screen
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.38.7 or higher
- Dart SDK 3.10.7 or higher
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd taghyeer_test
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📦 Dependencies

### Main Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `get` | ^4.7.3 | State management, dependency injection, routing |
| `get_storage` | ^2.1.1 | Local storage solution |
| `dio` | ^5.9.2 | HTTP client for API calls |
| `flutter_screenutil` | ^5.9.3 | Responsive UI design |
| `flutter_svg` | ^2.2.4 | SVG image support |
| `logger` | ^2.6.2 | Logging utility |
| `jwt_decoder` | ^2.0.1 | JWT token decoding |

### Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_lints` | ^6.0.0 | Linting rules for Flutter |

## 🎯 Key Features Implementation

### State Management (GetX)

The project uses GetX for:
- **State Management**: Reactive state with `Rx` variables
- **Dependency Injection**: Service locator pattern
- **Routing**: Named route navigation
- **Reactive Programming**: Observable streams

### Dependency Injection

Dependency injection is configured in `lib/common/utils/di/dependency_injection.dart`:

```dart
// Example: ViewModel registration
Get.lazyPut<ProductVM>(
  () => ProductVM(ProductUseCase(ProductRequest(networkController))),
  fenix: true,
);
```

### Pagination Implementation

Both Product and Post lists implement pagination:
- Scroll detection at 80% of list
- Loading indicator at list end
- Automatic data fetching
- End-of-list detection

### Theme Management

Theme support includes:
- Light mode
- Dark mode
- System default
- Persistent theme preference

## 🔄 Data Flow

```
User Action
    ↓
View (UI)
    ↓
ViewModel (GetX Controller)
    ↓
Use Case (Business Logic)
    ↓
Repository Interface (Domain)
    ↓
Repository Implementation (Data)
    ↓
API/Storage
    ↓
Result (Success/Failure)
    ↓
ViewModel Update
    ↓
UI Update (Reactive)
```

## 📱 Screens

### Authentication
- **Splash Screen**: Initial app loading and authentication check
- **Login Screen**: User authentication

### Main Navigation
- **Bottom Navigation Bar**: Product, Post, Settings tabs

### Product Screens
- **Product List**: Grid view with pagination
- **Product Details**: Image carousel, full product information

### Post Screens
- **Post List**: Card view with pagination
- **Post Details**: Full post content, reactions, tags

### Settings
- **Settings Screen**: Theme and app preferences

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Code Style

The project follows Flutter's official style guide and uses `flutter_lints` for code quality.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👥 Authors

- **Taghyeer Team**

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX community for the state management solution
- All contributors and maintainers

---

**Note**: This project is built with Flutter 3.38.7 and follows Clean Architecture principles for maintainability and scalability.
