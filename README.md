# Clean City 🧹

Urban Waste Management mobile application built with Flutter. Allows residents to report waste issues and drivers to manage cleanup tasks.

## Features

### Resident
- Login/Registration with role selection
- Report waste with photo, location, and category
- View all waste events on map
- Track report history and status
- Profile management

### Driver
- Task dashboard with assigned jobs
- View task details with location
- Accept and complete tasks
- Photo proof upon completion

## Demo Mode

The app works fully offline with mock data for portfolio presentations.

**Demo Accounts:**
- Resident: `resident@demo.com` / `demo123`
- Driver: `driver@demo.com` / `demo123`

## Tech Stack

- **Flutter** - UI Framework
- **BLoC** - State Management
- **Dio** - HTTP Client
- **GetIt** - Dependency Injection
- **SharedPreferences** - Local Storage

## Architecture

```
lib/
├── core/
│   ├── constants/        # App constants, routes, colors
│   ├── di/               # Dependency injection
│   ├── network/          # API clients, repositories
│   └── theme/            # App theme
└── presentation/
    ├── bloc/              # BLoC state management
    └── screens/          # UI screens
```

## Getting Started

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`

## Screenshots

![Image](https://github.com/abror787/clean-city/blob/0e625d4d62ec8e915c10b9d34bf1993249272590/splash_screen.jpg)

!{Image](https://github.com/abror787/clean-city/blob/0e625d4d62ec8e915c10b9d34bf1993249272590/resident_ordriver_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/0e625d4d62ec8e915c10b9d34bf1993249272590/resident_more_info.jpg)

![Image](https://github.com/abror787/clean-city/blob/0e625d4d62ec8e915c10b9d34bf1993249272590/resident_maps_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/0e625d4d62ec8e915c10b9d34bf1993249272590/resident_main_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/c20a283ddb9b6019651db0dffc2cf75abb93a627/resident_info.jpg)

![Image](https://github.com/abror787/clean-city/blob/c20a283ddb9b6019651db0dffc2cf75abb93a627/resident_garbage_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/c20a283ddb9b6019651db0dffc2cf75abb93a627/resident_detailInfo_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/resident_app%E2%84%96.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/resident_applications.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/password_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/garbage_location_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/email_enter_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/driver_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/driver_mission_garbage_screen.jpg)

![Image](https://github.com/abror787/clean-city/blob/1b1c50707e0155a31ebb5166aa19467f1ee5b840/driver_info_screen.jpg)

## API Backend

The backend API is built with Node.js/Express. See separate repository: [clean-city-backend](https://github.com/yourusername/clean-city-backend)

---

Built with using Flutter










