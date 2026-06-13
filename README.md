# Nasmah

A clean, minimal iOS weather app built with SwiftUI. Nasmah (Arabic for *breeze*) shows current conditions, hourly forecasts, and a 3-day outlook — with a theme that adapts to the weather itself.

---

## Screenshots

 <img src="https://github.com/user-attachments/assets/9ee157b1-ff85-451d-a40c-11068fe4764e" width="200"/>  <img src="https://github.com/user-attachments/assets/c7ac938d-82ce-45cc-8142-6bb276710f87" width="200"/>  <img src="https://github.com/user-attachments/assets/199f48ff-a719-4d83-8e8e-299cf636dab1" width="200"/>  <img src="https://github.com/user-attachments/assets/826c6644-4071-4f76-93b1-0ea459faabdd" width="200"/> |

 <img src="https://github.com/user-attachments/assets/5984d321-db84-4f8a-90cf-42a62d751177" width="200"/>  <img src="https://github.com/user-attachments/assets/1559e5da-233f-4603-bde8-754b44131e9c" width="200"/>  <img src="https://github.com/user-attachments/assets/cd1ab668-d1d2-44b7-beda-2a0b0f461a96" width="200"/> 

---

## Features

- **Current weather** — temperature, feels like, condition, wind, humidity, UV index, visibility, and pressure
- **Hourly forecast** — scrollable 8-hour strip with rain chance
- **3-day forecast** — tap any day to see its full hourly breakdown
- **Dynamic theme** — background and accent colors driven by the API condition code (sunny → green day theme, rain/fog/storm → dark teal night theme), with time-of-day as fallback
- **Location aware** — auto-detects your city via CoreLocation on first launch
- **City search** — debounced live search powered by WeatherAPI
- **Saved locations** — save and manage favourite cities, persisted with Core Data
- **Auto-refresh** — weather silently refreshes every 5 minutes in the background
- **Animated splash screen** — fade-in / fade-out on launch

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Architecture | MVVM + Clean Architecture (Use Cases / Repositories) |
| Networking | Alamofire |
| Persistence | Core Data |
| Location | CoreLocation + CLGeocoder |
| Reactive | Combine (search debounce) |
| Weather data | [WeatherAPI.com](https://www.weatherapi.com) |
| Min deployment | iOS 16 |

---

## Architecture

```
Nasmah/
├── App
│   ├── NasmahApp.swift
│   └── SplashScreenView.swift
│
├── Core
│   ├── AppTheme.swift              ← single source of truth for all colors
│   ├── Color+Hex.swift
│   └── Config.swift                ← API key + base URL
│
├── Domain
│   ├── Models.swift                ← WeatherEntity, ForecastDayEntity, HourEntity,
│   │                                  SearchResult, SavedLocation
│   └── UseCases.swift              ← FetchWeather, SearchLocations, SaveLocation,
│                                      FetchSavedLocations, DeleteLocation,
│                                      FetchForecastHours
│
├── Data
│   ├── DTOs.swift                  ← Codable API response models
│   ├── WeatherAPIService.swift     ← Alamofire network layer
│   ├── WeatherRepository.swift     ← protocol + impl, DTO → Entity mapping
│   ├── SavedLocationsRepository.swift
│   └── CoreData.swift              ← CoreDataManager + PersistenceController
│
├── DI
│   └── DIContainer.swift           ← factory methods for all dependencies
│
├── Features
│   ├── Home
│   │   ├── HomeViewModel.swift     ← weather loading, auto-refresh, computed props
│   │   ├── HomeView.swift
│   │   ├── HomeSubviews.swift      ← HeroSection, HourlyCard, HourlyCellView
│   │   └── StatsGridView.swift     ← UV, Feels Like, Wind, Sunset, Humidity,
│   │                                  Visibility, Pressure cards
│   │
│   ├── Forecast
│   │   ├── ForecastViewModel.swift
│   │   ├── ForecastView.swift      ← detail view with full hourly breakdown
│   │   └── ForecastViews.swift     ← ForecastSectionView, ForecastRowView
│   │
│   └── Search
│       ├── SearchViewModel.swift   ← search + saved locations + theme injection
│       ├── SearchViews.swift       ← SearchView, SearchSheetView, SearchBar
│       └── FavoritesViews.swift    ← FavoritesSheetView, list, empty state, row
│
├── Location
│   └── LocationManager.swift
│
└── Shared
    └── SharedViews.swift           ← WeatherStatCard, HomeToolbarButtons,
                                       LoadingView, ErrorView
```

---

## Getting Started

### Prerequisites

- Xcode 15+
- iOS 16+ device or simulator
- A free API key from [weatherapi.com](https://www.weatherapi.com)
- [CocoaPods](https://cocoapods.org) or Swift Package Manager for Alamofire

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/Nasmah.git
   cd Nasmah
   ```

2. **Install Alamofire**

   If using Swift Package Manager, add in Xcode:
   ```
   File → Add Package Dependencies
   https://github.com/Alamofire/Alamofire
   ```

3. **Add your API key**

   Open `Config.swift` and replace the placeholder:
   ```swift
   struct Config {
       static let apiKey  = "YOUR_API_KEY_HERE"
       static let baseURL = "https://api.weatherapi.com/v1"
   }
   ```

4. **Add location permission**

   Make sure `NSLocationWhenInUseUsageDescription` is in your `Info.plist`:
   ```xml
   <key>NSLocationWhenInUseUsageDescription</key>
   <string>Nasmah uses your location to show local weather.</string>
   ```

5. **Build and run** on simulator or device.

---

## Theme System

All colors flow from a single `AppTheme` struct. The condition code from the WeatherAPI response determines the period:

| Condition Code | Period | Background | Accent |
|---|---|---|---|
| 1000 (Clear/Sunny) | Day | `#527E31` | `#A8D5A2` |
| 1003–1009 (Cloudy) | Follows clock | — | — |
| Everything else | Night | `#0C2A2E` | `#7EC8C8` |

Search and Favorites sheets receive the same condition code from `HomeViewModel` so they always match the home screen theme.

---

## API Key Security

The API key is currently stored in `Config.swift` as a plain string. For production:
- Store it in a `.xcconfig` file excluded from version control
- Or use a backend proxy so the key is never shipped in the binary

Add `Config.swift` to `.gitignore` if you fork this repo publicly.

---

## License

MIT — do whatever you want with it.

---

*Built by Nemo · June 2026*
