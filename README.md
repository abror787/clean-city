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

<p float="left">
  <img src="screenshots/1-login.png" width="200"/>
  <img src="screenshots/2-resident-dashboard.png" width="200"/>
  <img src="screenshots/3-select-category.png" width="200"/>
  <img src="screenshots/4-report-success.png" width="200"/>
</p>

<p float="left">
  <img src="screenshots/5-driver-login.png" width="200"/>
  <img src="screenshots/6-driver-dashboard.png" width="200"/>
  <img src="screenshots/7-task-details.png" width="200"/>
  <img src="screenshots/8-profile.png" width="200"/>
</p>

## API Backend

The backend API is built with Node.js/Express. See separate repository: [clean-city-backend](https://github.com/yourusername/clean-city-backend)

---

Built with ❤️ using Flutter

















!{image alt}(https://github.com/abror787/clean-city/blob/0e625d4d62ec8e915c10b9d34bf1993249272590/splash_screen.jpg)

