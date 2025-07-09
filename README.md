# 🌤️ Vaaniq – Cross‑Platform Weather App

#### Video Demo:
`<Insert YouTube link here>`

---

## Description

**Vaaniq** is a real-time weather app built using Flutter that works seamlessly across **Windows**, **Android**, and **iOS**. It empowers users to search for any city worldwide and instantly view current conditions and forecasts, complete with dynamic Lottie animations. It integrates API consumption, state management, UI design, and modular architecture.

---

## Distinctiveness & Complexity

This project draws lessons from CS50 problem sets (HTTP, JSON, UI layout, state management) but integrates them into a **cross-platform mobile and desktop app**—a scope significantly greater than individual problem sets. By deploying on three platforms with consistent performance and UI fidelity, it satisfies both CS50’s **distinctiveness** and **complexity** requirements:

- **Cross-Platform Deployment** – one codebase, three operating systems.
- **Stateful UI with Provider** – handling asynchronous data and dynamic rendering.
- **API Integration** – dual consumption of current weather and forecast endpoints.
- **Theming & Animations** – dynamic theme and weather-aware visuals.

---

## Table of Contents

1. [Features](#features)
2. [Project Structure](#project-structure)
3. [Design Decisions](#design-decisions)
4. [Installation & Usage](#installation--usage)
5. [Contributions](#contributions)
6. [Credits & Academic Honesty](#credits--academic-honesty)

---

## Features

- 🔍 **Location Search** – Find weather for cities globally.
- ⛅ **Current Conditions** – Temperature, weather description.
- 📅 **Forecast** – Multi-day forecast data.
- 🎨 **Weather Animations** – Lottie sequences for rain, sun, clouds.
- 🎛️ **Theming** – Light/Dark themes via centralized `app_theme.dart`.
- ⌚ **Cross-Platform Support** – Built and tested for Windows desktop, Android, and iOS mobile.
- 🛠️ **State Management** – Provider and ChangeNotifier for reactive updates.

---

## Project Structure

```
lib/
├── main.dart                   # App launch & initialization
├── models/
│   ├── forecast_model.dart     # Forecast data structures
│   └── weather_model.dart      # Current weather data structures
├── providers/
│   └── weather_provider.dart   # Weather state notifier
├── services/
│   ├── weather_service.dart    # Fetch current weather via API
│   └── forecast_service.dart   # Fetch forecast via API
├── utils/
│   ├── app_theme.dart          # Theme definitions
│   └── weather_utils.dart      # Data formatting 
└── view/
    ├── search_screen.dart      # UI for city input/search and forecast results
    └── weather_screen.dart     # Display weather for current location
```

Each folder separates concerns—models define data, services manage API calls, providers handle state, and views manage UI.

---

## Design Decisions

- **Modular Architecture**: MVC-style grouping aids maintainability and readability, essential for multiplatform apps.
- **Provider State Management**: Preferred over `setState` for cleaner asynchronous UI updates.
- **Utility Layer**: Centralized functions (`weather_utils.dart`) remove redundancy and allow easier formatting changes.
- **Theming**: `app_theme.dart` supports future customization like user theme preference.
- **Lottie Animations**: Enhances UX by visually matching current weather without inflating binary size.

---

## Installation & Usage

### Prerequisites
- Flutter SDK (compatible version)
- Platform-specific tools: Android SDK, Xcode (for iOS), and Windows build tools

### Setup
```bash
git clone <repo-url>
cd Weather_App
flutter pub get
```

### Running
- **Windows**:  
  `flutter run -d windows`
- **Android**:  
  `flutter run -d <emulator/device-id>`
- **iOS** (macOS host):  
  `flutter run -d ios`

---

## Contributions

This project was created solely by me as my CS50 final project. I welcome feedback on UI, architecture, or additional features like hourly forecasts, geolocation, or accessibility support.

---

## Credits & Academic Honesty

- **APIs**: Uses OpenWeather API for data.
- **Animations**: Lottie files used under their respective licenses.
- **Tools**: Flutter, Provider, HTTP package.
- **Code Assistance**: AI tools (ChatGPT) aided in boilerplate generation and bug fixes. The core logic remains original and authored manually by me.
