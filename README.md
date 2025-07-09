# LumiBook 🪄📘
This is Lumiform's iOS Challenge.

LumiBook is a SwiftUI-based modular content viewer app designed to display structured pages that can include nested sections, text, images, and links to other pages. It includes robust offline support using SwiftData and seamlessly falls back to local data if network access is unavailable.

## ✅ Requirements

- **Swift:** 5.9 or later
- **Xcode:** 15.0 or later
- **iOS:** 17.0 or later

---

## ✨ Features

- 🧩 Dynamic nested page rendering  
- 📴 Offline caching with SwiftData  
- 📷 Image caching  
- 🧭 Router-based dependency injection  
- 🎬 Splash screen animation
- 🔁 Pull-to-refresh  
- 📶 Network-aware loading and error handling  

---

## 📐 Architecture

- **MVVM + Repository Pattern** for scalable separation of concerns.
- **SwiftData** for local caching of pages and images.
- **RemoteDataSource + LocalDataSource** for layered persistence and fallback.
- **Router abstraction** for scalable scene building and DI.
---

## 📦 Installation

1. Clone this repo
2. Open the `.xcodeproj` or `.xcodeworkspace`
3. Build and run on iOS Simulator or device

---

## 🚀 Getting Started

1. On launch, `SplashScreenView` triggers data loading.
2. `PageViewModel` attempts to load remote data or fallbacks to SwiftData.
3. Pages are rendered recursively using `ItemView`, handling all item types (text, image, section, pageReference).
4. Pull down to refresh the data using `.refreshable`.
5. Offline? No problem. SwiftData caches both page structures and images.

---

## 🧪 Testing

- Remote and Local DataSources are mockable
- Supports loading test JSON using:

```swift
let mockData = try Data(contentsOf: Bundle.main.url(forResource: "MockPage", withExtension: "json")!)
```

---

## 🧰 Tools & Frameworks

- SwiftUI
- SwiftData
- XCConfig
- URLSession
- Swift Concurrency
