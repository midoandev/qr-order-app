# README - Mobile QR Order App

## 1. Project Architecture

This project follows strict Clean Architecture. We divide the code into three layers:

* **Domain Layer**: It contains Entities, Repository Interfaces, and Use Cases. This layer uses pure Dart. It has zero dependencies on other layers.
* **Data Layer**: It contains Models, Data Sources, and Repository Implementations. Models convert JSON data to Entities using `.toEntity()`.
* **Presentation Layer**: It contains Cubit, State, Pages, and Widgets. Cubit only communicates with Use Cases.

## 2. Technical Stack

* **State Management**: Flutter Cubit (Bloc).
* **Navigation**: GoRouter.
* **Dependency Injection**: GetIt.
* **Functional Programming**: Dartz (Either for Failure or Success).
* **UI Standard**: Material 3.
* **Internationalization**: i18n (ARB files).

## 3. How to Build the Project

### Prerequisites

* Install Flutter SDK.
* Install Dart SDK.

### Build Steps

1. **Get Dependencies**
   Open your terminal. Run this command:
```bash
flutter pub get

```


2. **Generate Localization (i18n)**
   Run this whenever you change .arb files:
```bash
flutter gen-l10n
```


3. **Environment Setup**
   Create a `.env` file in the root folder. Copy values from `.env.example`.
   Example content for `.env`:
```bash
APP_NAME=OrderApp
API_URL=https://offline.local
```

4. **Run Unit Test**
   We must test the logic before build. Run this command:
```bash
flutter test

```


5. **Build Debug APK**
   Run this command to create a debug version:
```bash
flutter build apk --debug

```



## 4. Coding Rules

* **Entities**: Use pure Dart only. Must end with `Entity`.
* **Models**: Must end with `Model`. Must have `toEntity()` and `fromJson()`.
* **Paths**: Every file must show its path at the top.
* **Colors**: Use `.withValues(alpha: 0.x)` for transparency.
* **Strings**: Access via `context.s.[feature].[key]`.

---